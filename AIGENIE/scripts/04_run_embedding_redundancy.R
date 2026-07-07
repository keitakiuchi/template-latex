script_file <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1])
script_dir <- dirname(normalizePath(script_file, mustWork = TRUE))
Sys.setenv(AIGENIE_SCRIPT_BASE_DIR = dirname(script_dir))
source(file.path(script_dir, "aigenie_helpers.R"))

project_root <- find_project_root()
base_dir <- aigenie_base_dir(project_root)
require_aigenie()

openai_key <- get_openai_key(project_root)
labels <- read_label_table(base_dir)

input_mode <- Sys.getenv("AIGENIE_EMBEDDING_INPUT", unset = "auto")
candidate_path <- file.path(base_dir, "outputs", "latest_aigenie_generated_candidates.csv")
combined_path <- file.path(base_dir, "outputs", "latest_combined_item_pool.csv")

if (identical(input_mode, "existing")) {
  items <- add_item_labels(read_item_pool(base_dir), labels)
  input_label <- "existing"
} else if (file.exists(candidate_path) && input_mode %in% c("auto", "combined")) {
  original_items <- add_item_labels(read_item_pool(base_dir), labels)
  candidate_items <- add_item_labels(read_csv_utf8(candidate_path), labels)
  common_columns <- intersect(names(original_items), names(candidate_items))
  items <- rbind(
    original_items[, common_columns, drop = FALSE],
    candidate_items[, common_columns, drop = FALSE]
  )
  write_csv_utf8(items, combined_path)
  input_label <- "combined"
} else if (file.exists(combined_path) && input_mode %in% c("auto", "combined")) {
  items <- add_item_labels(read_csv_utf8(combined_path), labels)
  input_label <- "combined"
} else if (identical(input_mode, "combined")) {
  stop("Combined input requested, but no generated candidate file is available.", call. = FALSE)
} else {
  items <- add_item_labels(read_item_pool(base_dir), labels)
  input_label <- "existing"
}
validate_item_pool(items)

genie_items <- to_genie_items(items)
out_dir <- create_output_dir(base_dir, paste0("embedding_redundancy_", input_label))
write_csv_utf8(genie_items, file.path(out_dir, "embedding_redundancy_input.csv"))

embedding_result <- AIGENIE::GENIE(
  items = genie_items,
  openai.API = openai_key,
  embedding.model = Sys.getenv("AIGENIE_EMBEDDING_MODEL", unset = "text-embedding-3-small"),
  embeddings.only = TRUE,
  plot = FALSE,
  silently = TRUE
)

saveRDS(embedding_result, file.path(out_dir, "embedding_result.rds"))
embedding <- extract_embedding_matrix(embedding_result)
embedding <- align_embedding_rows(embedding, items)
saveRDS(embedding, file.path(out_dir, "embedding_matrix.rds"))

cutoff <- as.numeric(Sys.getenv("AIGENIE_EMBEDDING_REDUNDANCY_CUTOFF", unset = "0.88"))
top_n <- as.integer(Sys.getenv("AIGENIE_EMBEDDING_TOP_N", unset = "200"))
pairs <- embedding_redundancy_pairs(items, embedding, cutoff = cutoff, top_n = top_n)
write_csv_utf8(pairs, file.path(out_dir, "embedding_redundancy_pairs.csv"))

same_type_pairs <- pairs[pairs$same_type, , drop = FALSE]
write_csv_utf8(same_type_pairs, file.path(out_dir, "embedding_redundancy_pairs_same_type.csv"))

high_similarity <- pairs[pairs$above_cutoff, , drop = FALSE]
write_csv_utf8(high_similarity, file.path(out_dir, "embedding_redundancy_pairs_above_cutoff.csv"))

manifest <- data.frame(
  input_label = input_label,
  item_count = nrow(items),
  cutoff = cutoff,
  top_n = top_n,
  output_dir = out_dir,
  stringsAsFactors = FALSE
)
write_csv_utf8(manifest, file.path(out_dir, "embedding_redundancy_manifest.csv"))

if (input_label == "existing") {
  writeLines(out_dir, file.path(base_dir, "outputs", "latest_existing_embedding_redundancy_dir.txt"))
} else {
  writeLines(out_dir, file.path(base_dir, "outputs", "latest_combined_embedding_redundancy_dir.txt"))
}

message("Embedding redundancy analysis complete: ", out_dir)
