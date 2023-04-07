Input carbon transition risk (ICTR)
================
Kalash Singhal

# Setup

Load Packages

``` r
library(tidyverse, warn.conflicts = FALSE)
#> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
#> ✔ ggplot2 3.4.1     ✔ purrr   1.0.1
#> ✔ tibble  3.2.1     ✔ dplyr   1.1.1
#> ✔ tidyr   1.3.0     ✔ stringr 1.5.0
#> ✔ readr   2.1.4     ✔ forcats 1.0.0
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
library(vroom)
library(here)
#> here() starts at /home/rstudio/git/tiltIndicator
```

# Introduction

The Input Product Carbon Transition Risk Indicator assesses the
transition risk of the input products due to their relative carbon
footprint to other input products. As a default option, each input
product will be compared to the carbon footprint of every other input
product. Alternatively, users can also choose to compare those input
products of the same type, so e.g., comparing only raw materials with
each other. Input products with a higher carbon footprint will also face
a higher risk.

The Input Product Carbon Transition Risk Indicator is therefore similar
to the Product Carbon Transition Risk Indicator, but it focuses on the
input products and not the product of the company. Input products are,
for example, resources, packaging materials, energy and enabling
services (such as tractor use on farm) to produce the product.

After identifying each carbon footprint for one input product, the input
products will be ranked according to their footprint. Input products in
the highest percentile (≥70%) will be classified as high transition risk
input products. Input products in the medium percentile (between ≥30%
and \<70%) will be classified as medium transition risk input products.
Products in the lowest percentile (\<30%) will be classified as low
transition risk input products.

After assessing the input products transition risk based on its carbon
footprint for each product, they will be aggregated at company-level. We
derive what percentage of the input products are high, medium and low
transition risk.

The goal of the transition risk MVP is to create a first draft of how
the transition risk indicator for inputs would be build in code in order
to convert it into code production easily in the future.

The transition risk indicator consists of 3 main steps:

- Step 1: Identifying the input products for each product
- Step 2: Calculating the relative carbon footprint per input product
- Step 3: Aggregating on the company-level

# Step 1: Identifying

Identifying the input products for each product

## 1.1 Load company data and inputs data

Sample data set includes inputs and co2 footprints for each product from
Ecoinvent and sectors from Europages. NOTE: the following columns are a
complete random selection and do not reflect the true information:

    - co2 footprints (not allowed to share licensed data right now)
    - sectors (as the matching with ecoinvent is not done yet, we do not have one sector per product yet)

``` r
# FIXME: Temporarily redirect to where the data actually is
here <- function(...) here::here("data-raw", "ictr", ...)

inputs <- read.csv(here("data_prep","02_input_data", "data_ecoinvent_co2.csv"))
inputs |> glimpse()
#> Rows: 75
#> Columns: 10
#> $ ei_activity           <chr> "transport, freight, lorry 7.5-16 metric ton, EU…
#> $ activity_product_uuid <chr> "0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d…
#> $ input_number          <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
#> $ inputs                <chr> "table ornaments", "hydraulic valve", "calves", …
#> $ input_co2             <dbl> 73.58, 96.00, 39.07, 80.12, 10.72, 25.71, 16.93,…
#> $ input_sector          <chr> "transport", "infrastructure & machinery", "elec…
#> $ geo                   <chr> "RoW", "GLO", "RER", "GLO", "GLO", "RER", "RoW",…
#> $ isic_class            <chr> "4923:Freight transport by road", "3822:Treatmen…
#> $ ref_prod              <chr> "transport, freight, lorry 7.5-16 metric ton, EU…
#> $ unit                  <chr> "metric ton*km", "kg", "metric ton*km", "kg", "m…

companies <- read.csv(here("data_prep","02_input_data", "tilt_companies.csv"))

# FIXME: Can we reuse pctr_companies?
companies |> glimpse()
#> Rows: 25
#> Columns: 6
#> $ company_id            <chr> "fleischerei-stiefsohn_00000005219477-001", "fle…
#> $ company_name          <chr> "fleischerei stiefsohn", "fleischerei stiefsohn"…
#> $ ep_product            <chr> "shellfish", "crustaceans", "fish", "meat", "off…
#> $ activity_product_uuid <chr> "0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d…
#> $ ei_activity           <chr> "transport, freight, lorry 7.5-16 metric ton, EU…
#> $ unit                  <chr> "metric ton*km", "kg", "metric ton*km", "kg", "m…
```

# Step 2: Calculate ranks per input product and assign scores

## 2.1 Calculate the rank of each input product

This is done based on the input products’ carbon footprints compared to
4 different benchmarks (all products, products with same unit, products
with same sector, products with same unit and sector)

``` r
# rank in comparison to all input products
ecoinvent_input <- inputs %>%
  mutate(perc_all = rank(input_co2) / length(input_co2))

# rank in comparison to all input products with same unit
ecoinvent_input <- ecoinvent_input |>
  group_by(unit) |>
  mutate(perc_unit = rank(input_co2) / length(input_co2)) %>%
  ungroup()

# rank in comparison to all input products with same input sector
ecoinvent_input <- ecoinvent_input |>
  group_by(input_sector) |>
  mutate(perc_sec = rank(input_co2) / length(input_co2)) %>%
  ungroup()

# rank in comparison to all input products with same unit and input sector
ecoinvent_input <- ecoinvent_input |>
  group_by(unit, input_sector) |>
  mutate(perc_unit_sec = rank(input_co2) / length(input_co2)) %>%
  ungroup()

ecoinvent_input
#> # A tibble: 75 × 14
#>    ei_activ…¹ activ…² input…³ inputs input…⁴ input…⁵ geo   isic_…⁶ ref_p…⁷ unit 
#>    <chr>      <chr>     <int> <chr>    <dbl> <chr>   <chr> <chr>   <chr>   <chr>
#>  1 transport… 0a242b…       1 table…    73.6 transp… RoW   4923:F… transp… metr…
#>  2 treatment… be06d2…       1 hydra…    96   infras… GLO   3822:T… residu… kg   
#>  3 market gr… 977d99…       1 calves    39.1 electr… RER   4912:F… transp… metr…
#>  4 treatment… 5fd7fc…       1 custo…    80.1 infras… GLO   3821:T… waste … kg   
#>  5 market fo… ebb847…       1 carri…    10.7 agricu… GLO   2819:M… ventil… m    
#>  6 market fo… 2f7b77…       1 equip…    25.7 infras… RER   2011:M… sodium… kg   
#>  7 transport… edd290…       1 funct…    16.9 infras… RoW   4922:O… transp… km   
#>  8 market fo… d2c084…       1 elect…    55.8 fuels   GLO   1080:M… minera… kg   
#>  9 citric ac… abdb78…       1 harbo…    29.1 infras… RNA   2011:M… citric… kg   
#> 10 sodium et… 16e1dc…       1 paint…    92.7 infras… ZA    2011:M… sodium… kg   
#> # … with 65 more rows, 4 more variables: perc_all <dbl>, perc_unit <dbl>,
#> #   perc_sec <dbl>, perc_unit_sec <dbl>, and abbreviated variable names
#> #   ¹​ei_activity, ²​activity_product_uuid, ³​input_number, ⁴​input_co2,
#> #   ⁵​input_sector, ⁶​isic_class, ⁷​ref_prod
```

## 2.2 Assign scores to the input products

This is done based on their position within the distribution of co2
footprints in comparison to different benchmarks.

``` r
# creat variables for thresholds
low_threshold <- 0.3
high_threshold <- 0.7

# assign scores to position within percentile distribution
# for all input products
ecoinvent_scores <- ecoinvent_input %>%
  mutate(
    score_all = case_when(
      perc_all < low_threshold ~ "low",
      perc_all >= low_threshold & perc_all < high_threshold ~ "medium",
      perc_all >= high_threshold ~ "high"
    )
  )

# for products with same unit
ecoinvent_scores <- ecoinvent_scores %>%
  mutate(
    score_unit = case_when(
      perc_unit < low_threshold ~ "low",
      perc_unit >= low_threshold & perc_unit < high_threshold ~ "medium",
      perc_unit >= low_threshold ~ "high"
    )
  )

# for products with same sector
ecoinvent_scores <- ecoinvent_scores %>%
  mutate(
    score_sector = case_when(
      perc_sec < low_threshold ~ "low",
      perc_sec >= low_threshold & perc_sec < high_threshold ~ "medium",
      perc_sec >= low_threshold ~ "high"
    )
  )

# for products with same unit and sector
ecoinvent_scores <- ecoinvent_scores %>%
  mutate(
    score_unit_sec = case_when(
      perc_unit_sec < low_threshold ~ "low",
      perc_unit_sec >= low_threshold & perc_unit_sec < high_threshold ~ "medium",
      perc_unit_sec >= high_threshold ~ "high",
    )
  )

ecoinvent_scores
#> # A tibble: 75 × 18
#>    ei_activ…¹ activ…² input…³ inputs input…⁴ input…⁵ geo   isic_…⁶ ref_p…⁷ unit 
#>    <chr>      <chr>     <int> <chr>    <dbl> <chr>   <chr> <chr>   <chr>   <chr>
#>  1 transport… 0a242b…       1 table…    73.6 transp… RoW   4923:F… transp… metr…
#>  2 treatment… be06d2…       1 hydra…    96   infras… GLO   3822:T… residu… kg   
#>  3 market gr… 977d99…       1 calves    39.1 electr… RER   4912:F… transp… metr…
#>  4 treatment… 5fd7fc…       1 custo…    80.1 infras… GLO   3821:T… waste … kg   
#>  5 market fo… ebb847…       1 carri…    10.7 agricu… GLO   2819:M… ventil… m    
#>  6 market fo… 2f7b77…       1 equip…    25.7 infras… RER   2011:M… sodium… kg   
#>  7 transport… edd290…       1 funct…    16.9 infras… RoW   4922:O… transp… km   
#>  8 market fo… d2c084…       1 elect…    55.8 fuels   GLO   1080:M… minera… kg   
#>  9 citric ac… abdb78…       1 harbo…    29.1 infras… RNA   2011:M… citric… kg   
#> 10 sodium et… 16e1dc…       1 paint…    92.7 infras… ZA    2011:M… sodium… kg   
#> # … with 65 more rows, 8 more variables: perc_all <dbl>, perc_unit <dbl>,
#> #   perc_sec <dbl>, perc_unit_sec <dbl>, score_all <chr>, score_unit <chr>,
#> #   score_sector <chr>, score_unit_sec <chr>, and abbreviated variable names
#> #   ¹​ei_activity, ²​activity_product_uuid, ³​input_number, ⁴​input_co2,
#> #   ⁵​input_sector, ⁶​isic_class, ⁷​ref_prod
```

# Step 3. Aggregating on the company level

## 3.1 Join dataset `companies` and `ecoinvent_scores`

This is required to combine company-level information with LCA info from
ecoinvent.

``` r
# join by activity_product_uuid and other joint columns from companies with
# ecoinvent_scores

companies_scores <- companies |>
  left_join(ecoinvent_scores, by = c("activity_product_uuid", "ei_activity", "unit"))

companies_scores |> tibble::as_tibble()
#> # A tibble: 75 × 21
#>    compan…¹ compa…² ep_pr…³ activ…⁴ ei_ac…⁵ unit  input…⁶ inputs input…⁷ input…⁸
#>    <chr>    <chr>   <chr>   <chr>   <chr>   <chr>   <int> <chr>    <dbl> <chr>  
#>  1 fleisch… fleisc… shellf… 0a242b… transp… metr…       1 table…   73.6  transp…
#>  2 fleisch… fleisc… shellf… 0a242b… transp… metr…       2 aspha…   47.3  infras…
#>  3 fleisch… fleisc… shellf… 0a242b… transp… metr…       3 commu…   -3.9  infras…
#>  4 fleisch… fleisc… crusta… be06d2… treatm… kg          1 hydra…   96    infras…
#>  5 fleisch… fleisc… crusta… be06d2… treatm… kg          2 indoo…   -0.76 metals 
#>  6 fleisch… fleisc… crusta… be06d2… treatm… kg          3 elect…   88.2  infras…
#>  7 fleisch… fleisc… fish    977d99… market… metr…       1 calves   39.1  electr…
#>  8 fleisch… fleisc… fish    977d99… market… metr…       2 split…   -3.78 infras…
#>  9 fleisch… fleisc… fish    977d99… market… metr…       3 patio…   91.3  infras…
#> 10 fleisch… fleisc… meat    5fd7fc… treatm… kg          1 custo…   80.1  infras…
#> # … with 65 more rows, 11 more variables: geo <chr>, isic_class <chr>,
#> #   ref_prod <chr>, perc_all <dbl>, perc_unit <dbl>, perc_sec <dbl>,
#> #   perc_unit_sec <dbl>, score_all <chr>, score_unit <chr>, score_sector <chr>,
#> #   score_unit_sec <chr>, and abbreviated variable names ¹​company_id,
#> #   ²​company_name, ³​ep_product, ⁴​activity_product_uuid, ⁵​ei_activity,
#> #   ⁶​input_number, ⁷​input_co2, ⁸​input_sector
```

## 3.2 Caclulate the scores for each company

This is done by calculating the share of input products with each score.

``` r
# scores in comparison to all input products
scores_all <- companies_scores |>
  group_by(company_id, score_all) |>
  summarise(n_all = n()) |>
  mutate(share_all = n_all / sum(n_all)) |>
  select(-n_all) |>
  rename("score" = "score_all")
#> `summarise()` has grouped output by 'company_id'. You can override using the
#> `.groups` argument.
scores_all
#> # A tibble: 14 × 3
#> # Groups:   company_id [5]
#>    company_id                               score  share_all
#>    <chr>                                    <chr>      <dbl>
#>  1 bst-procontrol-gmbh_00000005104947-001   high       0.394
#>  2 bst-procontrol-gmbh_00000005104947-001   low        0.273
#>  3 bst-procontrol-gmbh_00000005104947-001   medium     0.333
#>  4 fleischerei-stiefsohn_00000005219477-001 high       0.286
#>  5 fleischerei-stiefsohn_00000005219477-001 low        0.333
#>  6 fleischerei-stiefsohn_00000005219477-001 medium     0.381
#>  7 hoche-butter-gmbh_deu422723-693847001    low        0.333
#>  8 hoche-butter-gmbh_deu422723-693847001    medium     0.667
#>  9 pecheries-basques_fra316541-00101        high       0.333
#> 10 pecheries-basques_fra316541-00101        low        0.111
#> 11 pecheries-basques_fra316541-00101        medium     0.556
#> 12 vicquelin-espaces-verts_fra697272-00101  high       0.111
#> 13 vicquelin-espaces-verts_fra697272-00101  low        0.444
#> 14 vicquelin-espaces-verts_fra697272-00101  medium     0.444

# scores in comparison to input products with same unit
scores_unit <- companies_scores |>
  group_by(company_id, score_unit) |>
  summarise(n_unit = n()) |>
  mutate(share_unit = n_unit / sum(n_unit)) |>
  select(-n_unit) |>
  rename("score" = "score_unit")
#> `summarise()` has grouped output by 'company_id'. You can override using the
#> `.groups` argument.
scores_unit
#> # A tibble: 14 × 3
#> # Groups:   company_id [5]
#>    company_id                               score  share_unit
#>    <chr>                                    <chr>       <dbl>
#>  1 bst-procontrol-gmbh_00000005104947-001   high        0.364
#>  2 bst-procontrol-gmbh_00000005104947-001   low         0.212
#>  3 bst-procontrol-gmbh_00000005104947-001   medium      0.424
#>  4 fleischerei-stiefsohn_00000005219477-001 high        0.333
#>  5 fleischerei-stiefsohn_00000005219477-001 low         0.190
#>  6 fleischerei-stiefsohn_00000005219477-001 medium      0.476
#>  7 hoche-butter-gmbh_deu422723-693847001    low         0.333
#>  8 hoche-butter-gmbh_deu422723-693847001    medium      0.667
#>  9 pecheries-basques_fra316541-00101        high        0.333
#> 10 pecheries-basques_fra316541-00101        low         0.111
#> 11 pecheries-basques_fra316541-00101        medium      0.556
#> 12 vicquelin-espaces-verts_fra697272-00101  high        0.222
#> 13 vicquelin-espaces-verts_fra697272-00101  low         0.333
#> 14 vicquelin-espaces-verts_fra697272-00101  medium      0.444

# scores in comparison to input products with same input sector
scores_sector <- companies_scores |>
  group_by(company_id, score_sector) |>
  summarise(n_sector = n()) |>
  mutate(share_sector = n_sector / sum(n_sector)) |>
  select(-n_sector) |>
  rename("score" = "score_sector")
#> `summarise()` has grouped output by 'company_id'. You can override using the
#> `.groups` argument.
scores_sector
#> # A tibble: 14 × 3
#> # Groups:   company_id [5]
#>    company_id                               score  share_sector
#>    <chr>                                    <chr>         <dbl>
#>  1 bst-procontrol-gmbh_00000005104947-001   high          0.455
#>  2 bst-procontrol-gmbh_00000005104947-001   low           0.212
#>  3 bst-procontrol-gmbh_00000005104947-001   medium        0.333
#>  4 fleischerei-stiefsohn_00000005219477-001 high          0.333
#>  5 fleischerei-stiefsohn_00000005219477-001 low           0.238
#>  6 fleischerei-stiefsohn_00000005219477-001 medium        0.429
#>  7 hoche-butter-gmbh_deu422723-693847001    low           0.333
#>  8 hoche-butter-gmbh_deu422723-693847001    medium        0.667
#>  9 pecheries-basques_fra316541-00101        high          0.556
#> 10 pecheries-basques_fra316541-00101        low           0.111
#> 11 pecheries-basques_fra316541-00101        medium        0.333
#> 12 vicquelin-espaces-verts_fra697272-00101  high          0.111
#> 13 vicquelin-espaces-verts_fra697272-00101  low           0.333
#> 14 vicquelin-espaces-verts_fra697272-00101  medium        0.556

# scores in comparison to input products with same unit and input sector
scores_unit_sec <- companies_scores |>
  group_by(company_id, score_unit_sec) |>
  summarise(n_unit_sec = n()) |>
  mutate(share_unit_sec = n_unit_sec / sum(n_unit_sec)) |>
  select(-n_unit_sec) |>
  rename("score" = "score_unit_sec")
#> `summarise()` has grouped output by 'company_id'. You can override using the
#> `.groups` argument.
scores_unit_sec
#> # A tibble: 14 × 3
#> # Groups:   company_id [5]
#>    company_id                               score  share_unit_sec
#>    <chr>                                    <chr>           <dbl>
#>  1 bst-procontrol-gmbh_00000005104947-001   high           0.515 
#>  2 bst-procontrol-gmbh_00000005104947-001   low            0.152 
#>  3 bst-procontrol-gmbh_00000005104947-001   medium         0.333 
#>  4 fleischerei-stiefsohn_00000005219477-001 high           0.476 
#>  5 fleischerei-stiefsohn_00000005219477-001 low            0.0952
#>  6 fleischerei-stiefsohn_00000005219477-001 medium         0.429 
#>  7 hoche-butter-gmbh_deu422723-693847001    low            0.333 
#>  8 hoche-butter-gmbh_deu422723-693847001    medium         0.667 
#>  9 pecheries-basques_fra316541-00101        high           0.556 
#> 10 pecheries-basques_fra316541-00101        low            0.222 
#> 11 pecheries-basques_fra316541-00101        medium         0.222 
#> 12 vicquelin-espaces-verts_fra697272-00101  high           0.222 
#> 13 vicquelin-espaces-verts_fra697272-00101  low            0.111 
#> 14 vicquelin-espaces-verts_fra697272-00101  medium         0.667
```

## 3.3 Create final dataset

The final dataset should have three rows per company, i.e. one for each
risk_group (low, medium, high) and one column each indicating the share
of products in the respective risk groups for the four different
benchmarks (all input products, input products with same unit, input
products with same input sector, and input products with same unit and
input sector)

``` r
# create dataset sceleton
dt_sceleton <- tibble(
  company_id = rep(unique(companies_scores$company_id), each = 3),
  score = rep(c("high", "medium", "low"), 5),
)
dt_sceleton
#> # A tibble: 15 × 2
#>    company_id                               score 
#>    <chr>                                    <chr> 
#>  1 fleischerei-stiefsohn_00000005219477-001 high  
#>  2 fleischerei-stiefsohn_00000005219477-001 medium
#>  3 fleischerei-stiefsohn_00000005219477-001 low   
#>  4 pecheries-basques_fra316541-00101        high  
#>  5 pecheries-basques_fra316541-00101        medium
#>  6 pecheries-basques_fra316541-00101        low   
#>  7 hoche-butter-gmbh_deu422723-693847001    high  
#>  8 hoche-butter-gmbh_deu422723-693847001    medium
#>  9 hoche-butter-gmbh_deu422723-693847001    low   
#> 10 vicquelin-espaces-verts_fra697272-00101  high  
#> 11 vicquelin-espaces-verts_fra697272-00101  medium
#> 12 vicquelin-espaces-verts_fra697272-00101  low   
#> 13 bst-procontrol-gmbh_00000005104947-001   high  
#> 14 bst-procontrol-gmbh_00000005104947-001   medium
#> 15 bst-procontrol-gmbh_00000005104947-001   low

# join scores with dt_sceleton so that each company is shown with 3 rows for
# low, medium, and high, even if the share is 0.
pctr_output <- dt_sceleton |>
  left_join(scores_all, by = c("company_id", "score")) |>
  left_join(scores_unit, by = c("company_id", "score")) |>
  left_join(scores_sector, by = c("company_id", "score")) |>
  left_join(scores_unit_sec, by = c("company_id", "score"))

# replace NAs with 0
pctr_output <- pctr_output |>
  replace(is.na(pctr_output), 0)

pctr_output
#> # A tibble: 15 × 6
#>    company_id                              score share…¹ share…² share…³ share…⁴
#>    <chr>                                   <chr>   <dbl>   <dbl>   <dbl>   <dbl>
#>  1 fleischerei-stiefsohn_00000005219477-0… high    0.286   0.333   0.333  0.476 
#>  2 fleischerei-stiefsohn_00000005219477-0… medi…   0.381   0.476   0.429  0.429 
#>  3 fleischerei-stiefsohn_00000005219477-0… low     0.333   0.190   0.238  0.0952
#>  4 pecheries-basques_fra316541-00101       high    0.333   0.333   0.556  0.556 
#>  5 pecheries-basques_fra316541-00101       medi…   0.556   0.556   0.333  0.222 
#>  6 pecheries-basques_fra316541-00101       low     0.111   0.111   0.111  0.222 
#>  7 hoche-butter-gmbh_deu422723-693847001   high    0       0       0      0     
#>  8 hoche-butter-gmbh_deu422723-693847001   medi…   0.667   0.667   0.667  0.667 
#>  9 hoche-butter-gmbh_deu422723-693847001   low     0.333   0.333   0.333  0.333 
#> 10 vicquelin-espaces-verts_fra697272-00101 high    0.111   0.222   0.111  0.222 
#> 11 vicquelin-espaces-verts_fra697272-00101 medi…   0.444   0.444   0.556  0.667 
#> 12 vicquelin-espaces-verts_fra697272-00101 low     0.444   0.333   0.333  0.111 
#> 13 bst-procontrol-gmbh_00000005104947-001  high    0.394   0.364   0.455  0.515 
#> 14 bst-procontrol-gmbh_00000005104947-001  medi…   0.333   0.424   0.333  0.333 
#> 15 bst-procontrol-gmbh_00000005104947-001  low     0.273   0.212   0.212  0.152 
#> # … with abbreviated variable names ¹​share_all, ²​share_unit, ³​share_sector,
#> #   ⁴​share_unit_sec
```
