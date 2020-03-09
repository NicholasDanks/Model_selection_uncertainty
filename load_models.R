# Load all conceivable models

## All five models use the same measurement model
corp_rep_measurement_model = list()

## Five different structural models
corp_rep_structural_model = list()

### Model 1
corp_rep_structural_model[[1]] <- relationships(
  paths(from = c("QUAL","PERF","CSOR","ATTR"),  to = c("COMP","LIKE")),
  paths(from = c("COMP","LIKE"),                to = c("CUSA","CUSL")),
  paths(from = "CUSA",                          to = "CUSL")
)

corp_rep_measurement_model[[1]] <- constructs(
  composite("QUAL", multi_items("qual_", 1:8), weights = mode_B),
  composite("PERF", multi_items("perf_", 1:5), weights = mode_B),
  composite("CSOR", multi_items("csor_", 1:5), weights = mode_B),
  composite("ATTR", multi_items("attr_", 1:3), weights = mode_B),
  composite("COMP", multi_items("comp_", 1:3)),
  composite("CUSA", single_item("cusa")),
  composite("LIKE", multi_items("like_", 1:3)),
  composite("CUSL", multi_items("cusl_", 1:3))
)

### Model 2
corp_rep_structural_model[[2]] <- relationships(
  paths(from = c("QUAL","PERF","CSOR","ATTR"),  to = c("COMP","LIKE")),
  paths(from = c("COMP","LIKE"),                to = c("CUSA")),
  paths(from = c("CUSA","LIKE"),                to = "CUSL")
)

corp_rep_measurement_model[[2]] <- constructs(
  composite("QUAL", multi_items("qual_", 1:8), weights = mode_B),
  composite("PERF", multi_items("perf_", 1:5), weights = mode_B),
  composite("CSOR", multi_items("csor_", 1:5), weights = mode_B),
  composite("ATTR", multi_items("attr_", 1:3), weights = mode_B),
  composite("COMP", multi_items("comp_", 1:3)),
  composite("CUSA", single_item("cusa")),
  composite("LIKE", multi_items("like_", 1:3)),
  composite("CUSL", multi_items("cusl_", 1:3))
)

### Model 3
corp_rep_structural_model[[3]] <- relationships(
  paths(from = c("QUAL","PERF","CSOR","ATTR"),  to = c("COMP","LIKE")),
  paths(from = c("COMP","LIKE"),                to = c("CUSA")),
  paths(from = "CUSA",                          to = "CUSL")
)

corp_rep_measurement_model[[3]] <- constructs(
  composite("QUAL", multi_items("qual_", 1:8), weights = mode_B),
  composite("PERF", multi_items("perf_", 1:5), weights = mode_B),
  composite("CSOR", multi_items("csor_", 1:5), weights = mode_B),
  composite("ATTR", multi_items("attr_", 1:3), weights = mode_B),
  composite("COMP", multi_items("comp_", 1:3)),
  composite("CUSA", single_item("cusa")),
  composite("LIKE", multi_items("like_", 1:3)),
  composite("CUSL", multi_items("cusl_", 1:3))
)

### Model 4
corp_rep_structural_model[[4]] <- relationships(
  paths(from = c("QUAL","PERF","CSOR","ATTR"),  to = c("COMP","LIKE","CUSA")),
  paths(from = c("COMP","LIKE"),                to = c("CUSA","CUSL")),
  paths(from = "CUSA",                          to = "CUSL")
)

corp_rep_measurement_model[[4]] <- constructs(
  composite("QUAL", multi_items("qual_", 1:8), weights = mode_B),
  composite("PERF", multi_items("perf_", 1:5), weights = mode_B),
  composite("CSOR", multi_items("csor_", 1:5), weights = mode_B),
  composite("ATTR", multi_items("attr_", 1:3), weights = mode_B),
  composite("COMP", multi_items("comp_", 1:3)),
  composite("CUSA", single_item("cusa")),
  composite("LIKE", multi_items("like_", 1:3)),
  composite("CUSL", multi_items("cusl_", 1:3))
)

### Model 5
corp_rep_structural_model[[5]] <- relationships(
  paths(from = c("QUAL","PERF","CSOR","ATTR"),  to = c("COMP","LIKE","CUSA","CUSL")),
  paths(from = c("COMP","LIKE"),                to = c("CUSA","CUSL")),
  paths(from = "CUSA",                          to = "CUSL")
)

corp_rep_measurement_model[[5]] <- constructs(
  composite("QUAL", multi_items("qual_", 1:8), weights = mode_B),
  composite("PERF", multi_items("perf_", 1:5), weights = mode_B),
  composite("CSOR", multi_items("csor_", 1:5), weights = mode_B),
  composite("ATTR", multi_items("attr_", 1:3), weights = mode_B),
  composite("COMP", multi_items("comp_", 1:3)),
  composite("CUSA", single_item("cusa")),
  composite("LIKE", multi_items("like_", 1:3)),
  composite("CUSL", multi_items("cusl_", 1:3))
)

