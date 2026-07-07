find_project_root <- function(start = getwd()) {
  current <- normalizePath(start, mustWork = TRUE)
  repeat {
    if (dir.exists(file.path(current, ".git"))) {
      return(current)
    }
    parent <- dirname(current)
    if (identical(parent, current)) {
      stop("Could not find project root containing .git", call. = FALSE)
    }
    current <- parent
  }
}

find_aigenie_base_dir <- function(start = getwd()) {
  current <- normalizePath(start, mustWork = TRUE)
  repeat {
    if (
      file.exists(file.path(current, "scripts", "aigenie_helpers.R")) &&
        dir.exists(file.path(current, "inputs"))
    ) {
      return(current)
    }
    parent <- dirname(current)
    if (identical(parent, current)) {
      stop("Could not find AIGENIE template root containing scripts/ and inputs/.", call. = FALSE)
    }
    current <- parent
  }
}

aigenie_base_dir <- function(project_root = NULL) {
  env_base <- Sys.getenv("AIGENIE_BASE_DIR", unset = "")
  if (nzchar(trimws(env_base))) {
    return(normalizePath(env_base, mustWork = TRUE))
  }

  script_base <- Sys.getenv("AIGENIE_SCRIPT_BASE_DIR", unset = "")
  if (nzchar(trimws(script_base))) {
    return(normalizePath(script_base, mustWork = TRUE))
  }

  if (!is.null(project_root) && dir.exists(project_root)) {
    found <- tryCatch(find_aigenie_base_dir(project_root), error = function(e) NULL)
    if (!is.null(found)) {
      return(found)
    }
  }

  find_aigenie_base_dir()
}

load_project_env <- function(project_root = find_project_root()) {
  env_path <- file.path(project_root, ".env")
  if (!file.exists(env_path)) {
    return(invisible(FALSE))
  }

  lines <- readLines(env_path, warn = FALSE, encoding = "UTF-8")
  lines <- trimws(lines)
  lines <- lines[nzchar(lines) & !grepl("^#", lines)]

  for (line in lines) {
    line <- sub("^export[[:space:]]+", "", line)
    if (!grepl("=", line, fixed = TRUE)) {
      next
    }
    key <- trimws(sub("=.*$", "", line))
    value <- trimws(sub("^[^=]*=", "", line))
    value <- sub("^['\"]", "", value)
    value <- sub("['\"]$", "", value)
    if (nzchar(key) && !nzchar(Sys.getenv(key, unset = ""))) {
      do.call(Sys.setenv, stats::setNames(list(value), key))
    }
  }

  invisible(TRUE)
}

configure_local_r_library <- function(base_dir = aigenie_base_dir()) {
  lib <- file.path(base_dir, "R", "library")
  if (dir.exists(lib)) {
    .libPaths(unique(c(normalizePath(lib, mustWork = TRUE), .libPaths())))
  }
  invisible(lib)
}

get_openai_key <- function(project_root = find_project_root()) {
  load_project_env(project_root)
  openai_key <- Sys.getenv("OPENAI_API_KEY", unset = "")
  if (!nzchar(openai_key)) {
    stop("OPENAI_API_KEY is not set. Add it to .env or the shell environment.", call. = FALSE)
  }
  openai_key
}

require_aigenie <- function(base_dir = aigenie_base_dir()) {
  configure_local_r_library(base_dir)
  if (!requireNamespace("AIGENIE", quietly = TRUE)) {
    stop(
      paste(
        "The R package AIGENIE is not installed.",
        "Install it from R-universe before running this script:",
        "install.packages('AIGENIE', repos = c('https://laralee.r-universe.dev', 'https://cloud.r-project.org'))"
      ),
      call. = FALSE
    )
  }
}

read_csv_utf8 <- function(path) {
  read.csv(path, stringsAsFactors = FALSE, check.names = FALSE, fileEncoding = "UTF-8")
}

write_csv_utf8 <- function(x, path) {
  utils::write.csv(x, path, row.names = FALSE, fileEncoding = "UTF-8")
}

parse_bool <- function(value, default = FALSE) {
  if (length(value) == 0) {
    return(logical(0))
  }

  value <- as.character(value)
  result <- rep(default, length(value))
  has_value <- !is.na(value) & nzchar(trimws(value))
  result[has_value] <- tolower(trimws(value[has_value])) %in% c("true", "t", "1", "yes", "y")
  result
}

parse_int_env <- function(name, default, minimum = NULL) {
  value <- Sys.getenv(name, unset = "")
  if (!nzchar(trimws(value))) {
    return(as.integer(default))
  }

  parsed <- suppressWarnings(as.integer(value))
  if (is.na(parsed)) {
    stop(name, " must be an integer.", call. = FALSE)
  }
  if (!is.null(minimum) && parsed < minimum) {
    stop(name, " must be >= ", minimum, ".", call. = FALSE)
  }
  parsed
}

parse_pipe_env <- function(name, default) {
  value <- Sys.getenv(name, unset = "")
  if (!nzchar(trimws(value))) {
    return(default)
  }

  values <- trimws(strsplit(value, "\\|", fixed = FALSE)[[1]])
  values[nzchar(values)]
}

resolve_input_path <- function(env_name, default_path) {
  path <- Sys.getenv(env_name, unset = "")
  if (!nzchar(trimws(path))) {
    path <- default_path
  }
  if (!file.exists(path)) {
    stop(
      "Input file does not exist: ", path,
      ". Create project inputs under inputs/ or copy examples from examples/inputs/.",
      call. = FALSE
    )
  }
  normalizePath(path, mustWork = TRUE)
}

read_item_pool <- function(base_dir = aigenie_base_dir()) {
  path <- resolve_input_path("AIGENIE_ITEM_POOL", file.path(base_dir, "inputs", "item_pool.csv"))
  items <- read_csv_utf8(path)
  validate_item_pool(items)
  items
}

read_label_table <- function(base_dir = aigenie_base_dir()) {
  path <- resolve_input_path("AIGENIE_LABEL_TABLE", file.path(base_dir, "inputs", "type_attribute_labels.csv"))
  read_csv_utf8(path)
}

read_generation_targets <- function(base_dir = aigenie_base_dir()) {
  path <- resolve_input_path("AIGENIE_GENERATION_TARGETS", file.path(base_dir, "inputs", "generation_targets.csv"))
  targets <- read_csv_utf8(path)
  required <- c(
    "generate", "generation_group", "type", "attribute", "n_candidates",
    "generation_group_definition_en"
  )
  missing <- setdiff(required, names(targets))
  if (length(missing) > 0) {
    stop("Generation target table is missing columns: ", paste(missing, collapse = ", "), call. = FALSE)
  }
  targets$n_candidates <- as.integer(targets$n_candidates)
  targets
}

read_prompt_notes <- function(base_dir = aigenie_base_dir()) {
  path <- Sys.getenv("AIGENIE_PROMPT_NOTES", unset = file.path(base_dir, "inputs", "prompt_notes.txt"))
  if (!file.exists(path)) {
    return("")
  }
  paste(readLines(path, warn = FALSE, encoding = "UTF-8"), collapse = " ")
}

validate_item_pool <- function(items) {
  required <- c("ID", "statement", "type", "attribute", "origin")
  missing <- setdiff(required, names(items))
  if (length(missing) > 0) {
    stop("Item pool is missing columns: ", paste(missing, collapse = ", "), call. = FALSE)
  }
  if (any(!nzchar(trimws(items$ID)))) {
    stop("Item pool contains empty IDs", call. = FALSE)
  }
  if (any(duplicated(items$ID))) {
    stop("Item pool contains duplicated IDs", call. = FALSE)
  }
  if (any(!nzchar(trimws(items$statement)))) {
    stop("Item pool contains empty statements", call. = FALSE)
  }
  invisible(TRUE)
}

to_genie_items <- function(items) {
  items[, c("statement", "attribute", "type", "ID"), drop = FALSE]
}

create_output_dir <- function(base_dir = aigenie_base_dir(), label) {
  stamp <- format(Sys.time(), "%Y%m%d_%H%M%S")
  out_dir <- file.path(base_dir, "outputs", paste0(label, "_", stamp))
  dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
  out_dir
}

find_first_named <- function(x, candidates, depth = 0L, max_depth = 8L) {
  if (depth > max_depth || !is.list(x)) {
    return(NULL)
  }
  nms <- names(x)
  if (!is.null(nms)) {
    hit <- intersect(candidates, nms)
    if (length(hit) > 0) {
      return(x[[hit[[1]]]])
    }
  }
  for (value in x) {
    found <- find_first_named(value, candidates, depth + 1L, max_depth)
    if (!is.null(found)) {
      return(found)
    }
  }
  NULL
}

write_data_frame_if_present <- function(x, path) {
  if (is.data.frame(x)) {
    write_csv_utf8(x, path)
    return(TRUE)
  }
  FALSE
}

save_genie_artifacts <- function(result, out_dir, prefix) {
  saveRDS(result, file.path(out_dir, paste0(prefix, "_result.rds")))

  analysis_result <- result
  if (is.list(result) && !is.null(result$overall) && is.list(result$overall)) {
    analysis_result <- result$overall
  }

  final_items <- analysis_result$final_items
  redundant_pairs <- analysis_result$UVA$redundant_pairs
  items_removed <- analysis_result$bootEGA$items_removed

  if (is.null(final_items)) {
    final_items <- find_first_named(result, c("final_items", "final.items"))
  }
  if (is.null(redundant_pairs)) {
    redundant_pairs <- find_first_named(result, c("redundant_pairs", "redundant.pairs"))
  }
  if (is.null(items_removed)) {
    items_removed <- find_first_named(result, c("items_removed", "items.removed"))
  }

  write_data_frame_if_present(final_items, file.path(out_dir, paste0(prefix, "_final_items.csv")))
  write_data_frame_if_present(redundant_pairs, file.path(out_dir, paste0(prefix, "_redundant_pairs.csv")))
  write_data_frame_if_present(items_removed, file.path(out_dir, paste0(prefix, "_items_removed.csv")))

  manifest <- data.frame(
    artifact = c("result_rds", "final_items_csv", "redundant_pairs_csv", "items_removed_csv"),
    path = c(
      file.path(out_dir, paste0(prefix, "_result.rds")),
      file.path(out_dir, paste0(prefix, "_final_items.csv")),
      file.path(out_dir, paste0(prefix, "_redundant_pairs.csv")),
      file.path(out_dir, paste0(prefix, "_items_removed.csv"))
    ),
    exists = file.exists(c(
      file.path(out_dir, paste0(prefix, "_result.rds")),
      file.path(out_dir, paste0(prefix, "_final_items.csv")),
      file.path(out_dir, paste0(prefix, "_redundant_pairs.csv")),
      file.path(out_dir, paste0(prefix, "_items_removed.csv"))
    )),
    stringsAsFactors = FALSE
  )
  write_csv_utf8(manifest, file.path(out_dir, paste0(prefix, "_manifest.csv")))
  invisible(manifest)
}

run_genie_with_boot_controls <- function(items, embedding.matrix = NULL, openai.API = NULL,
                                         hf.token = NULL, jina.API = NULL,
                                         embedding.model = "text-embedding-3-small",
                                         EGA.model = NULL, EGA.algorithm = NULL,
                                         EGA.uni.method = NULL, uva.cut.off = 0.2,
                                         embeddings.only = FALSE, run.overall = FALSE,
                                         all.together = FALSE, plot = TRUE,
                                         silently = FALSE, boot.iter = 100L,
                                         ncores = 1L) {
  ns <- asNamespace("AIGENIE")
  ns_get <- function(name) {
    get(name, envir = ns)
  }

  ns_get("uva.cut.off_validate")(uva.cut.off)
  validation <- ns_get("validate_user_input_GENIE")(
    items = items,
    embedding.matrix = embedding.matrix,
    openai.API = openai.API,
    hf.token = hf.token,
    jina.API = jina.API,
    embedding.model = embedding.model,
    EGA.model = EGA.model,
    EGA.algorithm = EGA.algorithm,
    EGA.uni.method = EGA.uni.method,
    embeddings.only = embeddings.only,
    run.overall = run.overall,
    all.together = all.together,
    plot = plot,
    silently = silently
  )

  items <- validation$items
  embedding.matrix <- validation$embedding.matrix
  item.attributes <- validation$item.attributes
  EGA.model <- validation$EGA.model
  EGA.algorithm <- validation$EGA.algorithm
  EGA.uni.method <- validation$EGA.uni.method
  embedding.model <- validation$embedding.model
  openai.API <- validation$openai.API
  hf.token <- validation$hf.token
  jina.API <- validation$jina.API
  run.overall <- validation$run.overall
  all.together <- validation$all.together

  if (is.null(embedding.matrix)) {
    if (!silently) {
      cat("Generating embeddings using", embedding.model, "\n")
    }
    embedding_result <- ns_get("generate_embeddings")(
      embedding.model = embedding.model,
      items = items,
      openai.API = openai.API,
      hf.token = hf.token,
      jina.API = jina.API,
      silently = silently
    )
    if (!embedding_result$success) {
      stop("Failed to generate embeddings. Please check your API credentials and model selection.")
    }
    embeddings <- embedding_result$embeddings
  } else {
    if (!silently) {
      cat("Using provided embedding matrix\n")
    }
    embeddings <- embedding.matrix
  }

  if (embeddings.only) {
    return(embeddings)
  }

  if (!silently) {
    cat("Running GENIE pipeline with boot.iter =", boot.iter, "and ncores =", ncores, "\n")
  }

  if (all.together) {
    items_to_run <- ns_get("run_all_together")(items)
    try_item_level <- ns_get("run_item_reduction_pipeline")(
      embedding_matrix = embeddings,
      items = items_to_run,
      EGA.model = EGA.model$overall,
      EGA.algorithm = EGA.algorithm$overall,
      EGA.uni.method = EGA.uni.method$overall,
      uva.cut.off = uva.cut.off,
      keep.org = FALSE,
      silently = silently,
      plot = plot,
      ncores = ncores,
      boot.iter = boot.iter
    )
    if (!try_item_level$success) {
      if (!silently) {
        message("AI-GENIE reduction failed. Returning partial results.")
      }
      return(try_item_level$item_level)
    }
    item_level <- try_item_level$item_level
    IDs <- item_level[["All"]][["final_items"]]$ID
    item_level[["All"]][["final_items"]] <- items[items$ID %in% IDs, ]
    return(item_level[["All"]])
  }

  try_item_level <- ns_get("run_item_reduction_pipeline")(
    embedding_matrix = embeddings,
    items = items,
    EGA.model = EGA.model$type,
    EGA.algorithm = EGA.algorithm$type,
    EGA.uni.method = EGA.uni.method$type,
    uva.cut.off = uva.cut.off,
    keep.org = FALSE,
    silently = silently,
    plot = plot,
    ncores = ncores,
    boot.iter = boot.iter
  )
  if (!try_item_level$success) {
    warning("GENIE: Item-level analysis failed. Returning partial results.")
    return(try_item_level$item_level)
  }
  item_level <- try_item_level$item_level

  if (run.overall && length(names(item.attributes)) > 1) {
    try_overall_result <- ns_get("run_pipeline_for_all")(
      item_level = item_level,
      items = items,
      embeddings = embeddings,
      model = EGA.model$overall,
      algorithm = EGA.algorithm$overall,
      uni.method = EGA.uni.method$overall,
      uva.cut.off = uva.cut.off,
      keep.org = FALSE,
      silently = silently,
      plot = plot,
      ncores = ncores,
      boot.iter = boot.iter
    )
    if (!try_overall_result$success) {
      warning("Overall analysis failed. Returning item-level results only.")
      return(item_level)
    }
    overall_result <- try_overall_result$overall_result
  } else {
    overall_result <- item_level
    try_overall_result <- list(success = TRUE)
  }

  if (!silently && try_overall_result$success && try_item_level$success) {
    tryCatch(
      ns_get("print_results")(overall_result, item_level, run.overall),
      error = function(e) {
        warning("Could not print GENIE summary: ", conditionMessage(e))
      }
    )
  }
  ns_get("build_return")(item_level, overall_result, run.overall, keep.org = FALSE)
}

extract_embedding_matrix <- function(result) {
  candidates <- c(
    "embeddings", "embedding", "embedding_matrix", "embedding.matrix",
    "embedding.matrix.reduced", "embedding_matrix_reduced"
  )
  embedding <- find_first_named(result, candidates)
  if (is.null(embedding)) {
    if (is.matrix(result) || is.data.frame(result)) {
      embedding <- result
    } else {
      stop("Could not find an embedding matrix in the GENIE result.", call. = FALSE)
    }
  }

  embedding <- as.matrix(embedding)
  storage.mode(embedding) <- "numeric"
  embedding
}

align_embedding_rows <- function(embedding, items) {
  ids <- items$ID
  row_ids <- rownames(embedding)
  col_ids <- colnames(embedding)

  if (!is.null(row_ids) && all(ids %in% row_ids)) {
    return(embedding[ids, , drop = FALSE])
  }
  if (!is.null(col_ids) && all(ids %in% col_ids)) {
    return(t(embedding[, ids, drop = FALSE]))
  }
  if (nrow(embedding) == nrow(items)) {
    rownames(embedding) <- ids
    return(embedding)
  }
  if (ncol(embedding) == nrow(items)) {
    embedding <- t(embedding)
    rownames(embedding) <- ids
    return(embedding)
  }

  stop("Embedding dimensions do not match item count.", call. = FALSE)
}

cosine_similarity_matrix <- function(embedding) {
  norms <- sqrt(rowSums(embedding^2))
  if (any(norms == 0)) {
    stop("Embedding matrix contains zero-length vectors.", call. = FALSE)
  }
  scaled <- embedding / norms
  scaled %*% t(scaled)
}

embedding_redundancy_pairs <- function(items, embedding, cutoff = 0.88, top_n = 100) {
  embedding <- align_embedding_rows(embedding, items)
  similarity <- cosine_similarity_matrix(embedding)

  pair_idx <- which(upper.tri(similarity), arr.ind = TRUE)
  pairs <- data.frame(
    item_1_id = rownames(similarity)[pair_idx[, "row"]],
    item_2_id = colnames(similarity)[pair_idx[, "col"]],
    cosine_similarity = as.numeric(similarity[pair_idx]),
    stringsAsFactors = FALSE
  )

  item_lookup <- items
  idx1 <- match(pairs$item_1_id, item_lookup$ID)
  idx2 <- match(pairs$item_2_id, item_lookup$ID)
  pairs$item_1_statement <- item_lookup$statement[idx1]
  pairs$item_2_statement <- item_lookup$statement[idx2]
  pairs$item_1_type <- item_lookup$type[idx1]
  pairs$item_2_type <- item_lookup$type[idx2]
  pairs$item_1_attribute <- item_lookup$attribute[idx1]
  pairs$item_2_attribute <- item_lookup$attribute[idx2]
  pairs$same_type <- pairs$item_1_type == pairs$item_2_type
  pairs$same_attribute <- pairs$item_1_attribute == pairs$item_2_attribute
  pairs$above_cutoff <- pairs$cosine_similarity >= cutoff

  pairs <- pairs[order(-pairs$cosine_similarity), , drop = FALSE]
  if (!is.na(top_n) && top_n > 0 && nrow(pairs) > top_n) {
    pairs <- pairs[seq_len(top_n), , drop = FALSE]
  }
  rownames(pairs) <- NULL
  pairs
}

prepare_generation_inputs <- function(items, targets) {
  active <- targets[parse_bool(targets$generate, default = FALSE), , drop = FALSE]
  if (nrow(active) == 0) {
    stop("No active generation targets. Set generate=TRUE in generation_targets.csv.", call. = FALSE)
  }

  split_targets <- split(active, active$generation_group)
  item_attributes <- lapply(split_targets, function(x) unique(x$attribute))
  target_n <- lapply(split_targets, function(x) sum(as.integer(x$n_candidates), na.rm = TRUE))
  type_definitions <- lapply(split_targets, function(x) unique(x$generation_group_definition_en)[[1]])

  for (group in names(item_attributes)) {
    if (length(item_attributes[[group]]) < 2) {
      stop("Generation group has fewer than two attributes: ", group, call. = FALSE)
    }
  }

  examples <- items[items$attribute %in% active$attribute, c("statement", "attribute", "type"), drop = FALSE]
  matched_group <- active$generation_group[match(examples$attribute, active$attribute)]
  examples$type <- matched_group
  examples <- examples[!is.na(examples$type), , drop = FALSE]

  list(
    active_targets = active,
    item_attributes = item_attributes,
    target_n = target_n,
    type_definitions = type_definitions,
    item_examples = examples
  )
}

add_item_labels <- function(items, labels) {
  key <- paste(labels$type, labels$attribute, sep = "::")
  row_key <- paste(items$type, items$attribute, sep = "::")
  idx <- match(row_key, key)
  items$type_label_ja <- labels$type_label_ja[idx]
  items$attribute_label_ja <- labels$attribute_label_ja[idx]
  items
}

normalise_generated_candidates <- function(candidates, active_targets, labels) {
  required <- c("ID", "statement", "type", "attribute")
  missing <- setdiff(required, names(candidates))
  if (length(missing) > 0) {
    stop("AIGENIE candidate output is missing columns: ", paste(missing, collapse = ", "), call. = FALSE)
  }

  attr_key <- active_targets$attribute
  target_idx <- match(candidates$attribute, attr_key)
  if (any(is.na(target_idx))) {
    warning("Some generated attributes were not found in the target table; keeping generated type values.")
  }

  candidates$aigenie_raw_ID <- candidates$ID
  candidates$type <- ifelse(is.na(target_idx), candidates$type, active_targets$type[target_idx])
  candidates$ID <- sprintf("CAND_%03d", seq_len(nrow(candidates)))
  candidates$origin <- "aigenie_candidate"
  candidates <- add_item_labels(candidates, labels)

  candidates[, c(
    "ID", "statement", "type", "attribute", "origin",
    "type_label_ja", "attribute_label_ja", "aigenie_raw_ID"
  ), drop = FALSE]
}
