
yarn <- read.csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2022/2022-10-11/yarn.csv')

common_yarns <- yarn$yarn_company_name |> table() |> sort(decreasing = T) |> head(10)

common_yarns <- yarn |> filter(yarn_company_name %in% names(common_yarns))

company_weight <- common_yarns |>
  group_by(yarn_company_name, yarn_weight_name) |>
  count()

company_weight |> 
  ungroup() |>
  pivot_wider(names_from = yarn_weight_name, values_from = n)


top_descriptors <- yarn$texture_clean |> str_split(", ") |> unlist() |> table() |> sort(decreasing = T) |> head(15)

convert_yarn_weight <- function(x) {
  str_remove(x, "\\d{1,}-") |>
    as.integer()
}


yarn <- yarn |>
  mutate(yarn_weight_wpi_num = convert_yarn_weight(yarn$yarn_weight_wpi))

write.csv(yarn, "prob6pt4.csv")
