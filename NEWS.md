<!-- NEWS.md is maintained by https://cynkra.github.io/fledge, do not edit -->

# tiltIndicator 0.0.0.9057

* `pstr_prepare_scenarios()` now handles "weo" data correctly (@kalashsinghal #309).

# tiltIndicator 0.0.0.9056

* With `type` "ipr", for each company and `grouped_by`, `value` sums 1 (#307).

# tiltIndicator 0.0.0.9055

* The column `grouped_by` now includes the scenario type (#306). This makes
the column `grouped_by` contain all the information in `scenarios`, `year`, and
`type` -- meaning that those columns could be removed to keep the output
simpler, without loosing information.

# tiltIndicator 0.0.0.9054

* `pstr_at_product_level()` now output columns as in the google sheet template (#303).

* Each `company_id + grouped_by` now gets one low, medium & high `risk_category` (#278).

# tiltIndicator 0.0.0.9053

* In ISTR the old argument `scenario` is now named `scenarios`, consistently with PSTR (#299).

# tiltIndicator 0.0.0.9052

* In `xstr*()`, `NA`s in `reductions` now trigger an error (#298).

# tiltIndicator 0.0.0.9051

* In PSTR the example datasets are now updated (@kalashsinghal #287).

# tiltIndicator 0.0.0.9050

* Each company & benchmark now gets a unique risk_category (@Tilmon #286).

# tiltIndicator 0.0.0.9049

* New article handling long runtime (#283)

* `pstr*()` gain arguments `low_threshold` and `high_threshold` (@kalashsinghal #273).

* `pstr*()` values are now expressed as proportion (@lindadelacombaz #274).

# tiltIndicator 0.0.0.9048

* `xctr_at_product_level()` now drops `NA`s from unmatched products (#267).

# tiltIndicator 0.0.0.9047

* `ictr*()` and `pctr*()` are now retired (#264).

# tiltIndicator 0.0.0.9046

The data is now simpler:

* `ictr_companies` and `pctr_companies` are now retired. Instead use the new dataset `companies`.

* `pctr_ecoinvent_co2` is now renamed to `products`.

* `ictr_inputs` is now renamed to `inputs`.

# tiltIndicator 0.0.0.9045

* New `xctr*()` replace `ictr*()` and `pctr*()` (#256). The functions `ictr*()` and `pctr*()` are internal for backward compatibility but will be
retired soon.

# tiltIndicator 0.0.0.9044

* ICTR and PCTR at product level no longer output needless columns (#251).

# tiltIndicator 0.0.0.9043

* In ICTR and PCTR the argument `low_threshold` now default to 1/3 and `high_threshold` to 2/3 (#249).

# tiltIndicator 0.0.0.9042

* A company with 3 different products and varying footprints now getes correct value (@Tilmon #248).

# tiltIndicator 0.0.0.9041

* ICTR and PCTR now handle duplicated `co2` data (#230).

# tiltIndicator 0.0.0.9040

* `*ctr_at_product_level()` now outputs `clustered` and `*_uuid` (#242).

# tiltIndicator 0.0.0.9039

* In ICTR and PCTR example datasets are now updated (@kalashsinghal #237).
* `pctr_at_product_level()` now returns visibly (#239). 
* ICTR and PCTR now handle duplicated `companies` data (#230).
* In ICTR & PCTR ranking benchmarks are now updated (@kalashsinghal #229).
* In ICTR & PCTR `high_threshold` is now computed correctly (@kalashsinghal #229).

# tiltIndicator 0.0.0.9037

* All product-level functions now output the same three columns (#228, #227):

    * `companies_id`
    * `grouped_by`
    * `risk_category`

# tiltIndicator 0.0.0.9036

* Datasets from the same family are now documented together (#224).

# tiltIndicator 0.0.0.9035

* All company-level functions now output the same four columns:

    * `companies_id`
    * `grouped_by`
    * `risk_category`
    * `value`

# tiltIndicator 0.0.0.9034

* In ICTR and PCTR the example datasets are now updated (@kalashsinghal #217).

# tiltIndicator 0.0.0.9033

* All top level functions now output the same first four columns (#214):

    * `companies_id`
    * `grouped_by`
    * `risk_category`
    * `value`

# tiltIndicator 0.0.0.9032

* `ictr_at_product_level()` and `pctr_at_product_level()` now output company
data (#213).

# tiltIndicator 0.0.0.9031

* In PSTR use new data  (@lindadelacombaz #196).

# tiltIndicator 0.0.0.9030

* In both `ictr()` and `pctr()` the first argument is now named `co2`.

* New internal-ish functions in the xctr family (#207).

# tiltIndicator 0.0.0.9029

* In PCTR, if a company matches no input, all shares are now `NA` (#205).

# tiltIndicator 0.0.0.9028

* In ICTR, if a company matches no input, all shares are now `NA` (@kalashsinghal #202).

# tiltIndicator 0.0.0.9027

* Even if companies has a *uuid absent in inputs/co2, all shares now sum 1  (@kalashsinghal #197).

# tiltIndicator 0.0.0.9026

* All indicators now output ungrouped data (#193)

# tiltIndicator 0.0.0.9025

* All indicators now export a single and similar top-level interface (#189).  The old functions are still available but are are now considered developer-oriented and therefore not visible on the website. The output is
also more similar: The first column is always `id`, the second column is always
`transition_risk`, and the following column(s) provide score(s).

* All indicators now output an id for each company and a score (#190).

# tiltIndicator 0.0.0.9024

* In ICTR the example data now reflects real data more closely (@kalashsinghal #170).

# tiltIndicator 0.0.0.9023

* `ictr_score_companies()` now errors if `inputs_co2` has `NA`s (@kalashsinghal #150).

* New article Get started (#152).

# tiltIndicator 0.0.0.9022

* Add istr mvp ( @Lyanneho #144).

# tiltIndicator 0.0.0.9021

BREAKING CHANGES

* `ictr_inputs` and `ictr_companies` loose non-crucial columns(@kalashsingal #117).

* `pctr_ecoinvent_co2` and `pctr_companies` loose non-crucial columns (#116).

BUG FIXES

* `ictr_score_companies()` and `ictr_score_companies()` now return three rows
per company regardless the number of rows in the co2 data (#122).

* `pctr_score_companies()` and `ictr_score_companies()` now return three rows
per company (@kalashsinghal  #111).

# tiltIndicator 0.0.0.9018

* Document PCTR functions (@kalashsinghal, #104).

* New ICTR functions and datasets (@kalashsinghal, #90).

# tiltIndicator 0.0.0.9017

* Add ICTR MVP (#90).

# tiltIndicator 0.0.0.9016

* The un-prefixed pstr datasets are now retired (#79).

# tiltIndicator 0.0.0.9014

* Remove `pstr_plot_company()` (#84).
* The name of PSTR datasets now include the prefix "pstr_" (#74).
* The developer-oriented functions are now internal (#67).
* Remove internal article (#66).

# tiltIndicator 0.0.0.9013

* New `pctr_*()` family of functions and datasets (#60, #61).

# tiltIndicator 0.0.0.9012

* Add pctr (@Tilmon, #56)

# tiltIndicator 0.0.0.9011

* FIX: The article pstr now shows the expected content (#52).

* FIX: `mvp_path()` with nonexistent path now throws an error (#51).

# tiltIndicator 0.0.0.9010

* Document the `pstr_*()` functions (@lindadelacombaz, #50)

* dev: Rename helper to `render_to_list()` (#43).

* dev: Prune needless helpers (#42).

* dev: Rename data-files related to pstr (#41).

* dev: Fix CODEOWNERS.

# tiltIndicator 0.0.0.9009

* dev: Rename data-files related to pstr so it's easier to express Linda's
ownership (#41).

# tiltIndicator 0.0.0.9008

* dev: Use CODEOWNERS (#39).

# tiltIndicator 0.0.0.9007

* In `pstr_at_company_level()` fix missing argument `companies` (#38).

* dev: Address R CMD Check about undefined global variables (#37).

# tiltIndicator 0.0.0.9006

* dev: Use new argument to `left_join()`.

# tiltIndicator 0.0.0.9004

* dev: Address dplyr warnings (#32).

# tiltIndicator 0.0.0.9003

* New `pstr_*()` family for product sector transition risk.

* New `pstr_*()` family of PSTR functions.

* New article "Product sector transition risk" (@lindadelacombaz, #18, #22).

