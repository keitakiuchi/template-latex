script_file <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1])
script_dir <- dirname(normalizePath(script_file, mustWork = TRUE))
Sys.setenv(AIGENIE_SCRIPT_BASE_DIR = dirname(script_dir))
source(file.path(script_dir, "aigenie_helpers.R"))

project_root <- find_project_root()
base_dir <- aigenie_base_dir(project_root)
require_aigenie()

openai_key <- get_openai_key(project_root)
items <- read_item_pool(base_dir)
genie_items <- to_genie_items(items)

out_dir <- create_output_dir(base_dir, "genie_existing_items")
write_csv_utf8(genie_items, file.path(out_dir, "genie_existing_input.csv"))

boot_iter <- parse_int_env("AIGENIE_BOOT_ITER", default = 100L, minimum = 1L)
boot_ncores <- parse_int_env("AIGENIE_BOOT_NCORES", default = 1L, minimum = 1L)

result <- run_genie_with_boot_controls(
  items = genie_items,
  openai.API = openai_key,
  embedding.model = Sys.getenv("AIGENIE_EMBEDDING_MODEL", unset = "text-embedding-3-small"),
  uva.cut.off = as.numeric(Sys.getenv("AIGENIE_UVA_CUT_OFF", unset = "0.20")),
  run.overall = parse_bool(Sys.getenv("AIGENIE_RUN_OVERALL", unset = "TRUE"), default = TRUE),
  all.together = parse_bool(Sys.getenv("AIGENIE_ALL_TOGETHER", unset = "FALSE"), default = FALSE),
  plot = parse_bool(Sys.getenv("AIGENIE_PLOT", unset = "FALSE"), default = FALSE),
  silently = parse_bool(Sys.getenv("AIGENIE_SILENTLY", unset = "FALSE"), default = FALSE),
  boot.iter = boot_iter,
  ncores = boot_ncores
)

save_genie_artifacts(result, out_dir, "genie_existing")
message("GENIE existing-item analysis complete: ", out_dir)
