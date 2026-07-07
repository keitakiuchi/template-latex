script_file <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1])
script_dir <- dirname(normalizePath(script_file, mustWork = TRUE))
Sys.setenv(AIGENIE_SCRIPT_BASE_DIR = dirname(script_dir))
source(file.path(script_dir, "aigenie_helpers.R"))

project_root <- find_project_root()
base_dir <- aigenie_base_dir(project_root)
require_aigenie()

openai_key <- get_openai_key(project_root)
items <- read_item_pool(base_dir)
labels <- read_label_table(base_dir)
targets <- read_generation_targets(base_dir)
generation_inputs <- prepare_generation_inputs(items, targets)

out_dir <- create_output_dir(base_dir, "aigenie_generated_candidates")
write_csv_utf8(generation_inputs$active_targets, file.path(out_dir, "active_generation_targets.csv"))
write_csv_utf8(generation_inputs$item_examples, file.path(out_dir, "item_examples_for_prompt.csv"))

prompt_notes <- read_prompt_notes(base_dir)
response_options <- parse_pipe_env(
  "AIGENIE_RESPONSE_OPTIONS",
  default = c(
    "strongly disagree",
    "disagree",
    "slightly disagree",
    "slightly agree",
    "agree",
    "strongly agree"
  )
)

candidates_raw <- AIGENIE::AIGENIE(
  item.attributes = generation_inputs$item_attributes,
  openai.API = openai_key,
  model = Sys.getenv("AIGENIE_LLM_MODEL", unset = "gpt-4o"),
  temperature = as.numeric(Sys.getenv("AIGENIE_TEMPERATURE", unset = "0.7")),
  top.p = as.numeric(Sys.getenv("AIGENIE_TOP_P", unset = "1")),
  target.N = generation_inputs$target_n,
  domain = Sys.getenv("AIGENIE_DOMAIN", unset = "Questionnaire item pool development"),
  scale.title = Sys.getenv("AIGENIE_SCALE_TITLE", unset = "Questionnaire item pool"),
  item.examples = generation_inputs$item_examples,
  audience = Sys.getenv("AIGENIE_AUDIENCE", unset = "Target respondents who can answer Japanese web questionnaires"),
  item.type.definitions = generation_inputs$type_definitions,
  response.options = response_options,
  prompt.notes = prompt_notes,
  items.only = TRUE,
  adaptive = TRUE,
  plot = FALSE,
  silently = parse_bool(Sys.getenv("AIGENIE_SILENTLY", unset = "FALSE"), default = FALSE)
)

candidates <- normalise_generated_candidates(
  candidates_raw,
  generation_inputs$active_targets,
  labels
)

write_csv_utf8(candidates_raw, file.path(out_dir, "aigenie_generated_candidates_raw.csv"))
write_csv_utf8(candidates, file.path(out_dir, "aigenie_generated_candidates.csv"))
write_csv_utf8(candidates, file.path(base_dir, "outputs", "latest_aigenie_generated_candidates.csv"))
message("AIGENIE candidate generation complete: ", out_dir)
