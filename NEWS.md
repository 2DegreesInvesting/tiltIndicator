<!-- NEWS.md is maintained by https://cynkra.github.io/fledge, do not edit -->

# tiltIndicator 0.0.0.9224 (2024-06-03)

* `spa_compute_profile_ranking()` is now exported as internal, and documented
along with `epa_compute_profile_ranking()` under the topic
`?spa_compute_profile_ranking` (#TODO).

# tiltIndicator 0.0.0.9223 (2024-05-20)

* `sector_profile()` now accounts for unmatched `type`, `sector` or `subsector`
(@Tilmon #739). For example, given a `clustered` matching one but not a second
`type` of scenario, when the `scenarios` dataset has the two types, then the
second `type` and its corresponding `scenario` are still present in
`grouped_by`, and the mismatch is reflected correctly in the `value`.

# tiltIndicator 0.0.0.9221 (2024-05-07)

* The developer-oriented `example_data_factory()` is now exported so it can be
reused elsewhere (#776).

# tiltIndicator 0.0.0.9220 (2024-04-23)

* New `exclude()` helps remove columns and resulting duplicated rows (#772).

# tiltIndicator 0.0.0.9219 (2024-04-23)

* New `join_to()` helps add a summary to a 'data.frame' or 'tilt\_profile' (#771).

# tiltIndicator 0.0.0.9218 (2024-04-22)

* New developer oriented (internal) function `document_tilt_profile()` (#770).
This makes it easy to consistently document the output of any profile function.

# tiltIndicator 0.0.0.9217 (2024-04-22)

* Rename 'profile' to 'tilt_profile' to avoid clash the with `stats::profile()`
(#769). Specifically:

    * The class 'profile' is now renamed to 'tilt\_profile'.
    * The constructor `profile()` is now renamed to `tilt_profile()`.
    * The predicate `is_profile()` is now renamed to `is_tilt_profile()`.

# tiltIndicator 0.0.0.9216 (2024-04-22)

* New class 'profile', and related developer-oriented (internal) functions (#768):

  * New constructor `tilt_profile()`.
  * New predicate `is_tilt_profile()`.

# tiltIndicator 0.0.0.9215 (2024-04-19)

* `summarize_range()` is now a generic function with methods for both data frames
and list of data frames (#764).

# tiltIndicator 0.0.0.9213

* `summarize_range()` now defaults to `na.rm = FALSE` (#747). This is most common
and conservative.

# tiltIndicator 0.0.0.9212

* `summarize_range()` gains `na.rm` and defaults to removing missing values
(#743).

# tiltIndicator 0.0.0.9211

* The `sector*()` functions now preserve unmatched products (@AnneSchoenauer
@Tilmon #738). This changes the structure of the output at company level, which
now has four levels of risk_category: "high", "low", "medium", and `NA`.

# tiltIndicator 0.0.0.9209

* The `emissions*()` functions now preserve unmatched products and missing
benchmarks (@AnneSchoenauer @Tilmon #639). This changes the structure of the
output at company level, which now has four levels of `risk_category`: "high",
"low", "medium", and `NA`.

# tiltIndicator 0.0.0.9206

* The retired `xxtr()` functions now throw an error (#724) which more
appropriately communicates to users the changes in #719.

# tiltIndicator 0.0.0.9205

* The datasets that moved to tiltToyData are now retired (#722). They have been
deprecated for about 6 months now.

# tiltIndicator 0.0.0.9204

* Remove the article 'Handling long runtime' (#723). The tiltIndicator package
is no longer suitable for it.

# tiltIndicator 0.0.0.9203

* The `xxtr*()` functions are now retired (#719). They have been deprecated for
about 6 months now.

# tiltIndicator 0.0.0.9201

* Change license to GPLv3 (#674).

# tiltIndicator 0.0.0.9200

* The documentation of `emissions_profile()` is now reviewed (#693 @Tilmon).

# tiltIndicator 0.0.0.9110

* Depend on R 4.1.0 (released on 2021-05-18) (#690).

* The installation instructions now include r-universe (#685).

# tiltIndicator 0.0.0.9109

* `emissions_profile_any_compute_profile_ranking()` is now deprecated. This
function is now internal (#669).

# tiltIndicator 0.0.0.9108

* `emissions_profile_any_compute_profile_ranking()` now handles special cases (#644 @kalashsinghal).

# tiltIndicator 0.0.0.9107

* The column `*isic_4digit` can now have values of any length (#630
@kalashsinghal).

# tiltIndicator 0.0.0.9106

* The percent deviation caused by `jitter*()` is now more even (#627).

# tiltIndicator 0.0.0.9105

* New helpers `summarize_range()` and `jitter_range()` (#622, @AnneSchoenauer).

# tiltIndicator 0.0.0.9104

* All functions now use `companies_id` but still accept `company_id` with a
warning (#621).

# tiltIndicator 0.0.0.9102

* All functions at product level now output the new column `profile_ranking`
(#613, @AnneSchoenauer).

# tiltIndicator 0.0.0.9101

* In results at product level, `clustered` is no longer  `NA` when `risk_category`
is `NA` (#614, @AnneSchoenauer, @kalashsinghal).

# tiltIndicator 0.0.0.9100

Get started now shows `sector_profile*()` documentation (#619).

# tiltIndicator 0.0.0.9099

* Rename `emissions_profile_any_add_values_to_categorize` to `emissions_profile_any_compute_profile_ranking` (#609). The old name is retired without deprecation since it had no users.

# tiltIndicator 0.0.0.9098

* `emissions_profile_any_add_values_to_categorize()` now relocates the new
columns to the left.

# tiltIndicator 0.0.0.9097

* `emissions_profile*()` uses `co2$values_to_categorize` if present (#605).

# tiltIndicator 0.0.0.9096

* New pre-processing helper `emissions_profile_any_add_values_to_categorize()`
(#602).

# tiltIndicator 0.0.0.9095

* The values of `grouped_by` are now less surprising (see related principle)
(#601). They now simply refer to the full name of the corresponding columns in
the "co2" dataset (products or inputs) passed to the `emissions_profile*()`
functions. For example, passing a column `products$tilt_sector` now yields the
value "tilt\_sector" in `group_by` -- which before got cropped to "tilt\_sec".

# tiltIndicator 0.0.0.9094

* The usage of `*rowid` columns is now documented and is more rigorous (#516):
  * The name `rowid` is now reserved. If any input dataset uses it, the result is an
  error.
  * Each `*rowid` column now must be unique. Duplicated names now result in an
  error.

# tiltIndicator 0.0.0.9093

* All profile functions allow passing `*rowid` columns from input tables to the
output at product level (#511).

# tiltIndicator 0.0.0.9092

* Rename pre- and post-processing helpers (#503).

# tiltIndicator 0.0.0.9091

* Rename indicators in public documentation (#496).

# tiltIndicator 0.0.0.9090

* `emissions_profile*()` now handles numeric values of `*isic_4digit`
(#494).

# tiltIndicator 0.0.0.9089

* Deprecate datasets. They all moved to tiltToyData with new names (#493).

# tiltIndicator 0.0.0.9088

* All `*_at_product_level()` and `*_at_company_level()` are now deprecated
(#491).

# tiltIndicator 0.0.0.9087

* `xctr(data, inputs)` is now deprecated in favor or the new
`emissions_profile_upstream()` (#481).

# tiltIndicator 0.0.0.9086

* `xctr(data, products)` is now deprecated in favor or the new
`emissions_profile()` (#481).

# tiltIndicator 0.0.0.9085

* `istr()` is now deprecated in favor of the new `sector_profile_upstream()`
(#480).

# tiltIndicator 0.0.0.9084

* `pstr()` is now deprecated in favor of the new `sector_profile()` (#479).

# tiltIndicator 0.0.0.9083

* Results at company level now preserve unmatched companies (#466).

# tiltIndicator 0.0.0.9082

* The article "Handling a long runtime" now shows an enhanced approach (#450).

# tiltIndicator 0.0.0.9081

* In `pstr()` now warns if the `companies` has any semicolon ';' in `sector` or
`subsector` (#449).

# tiltIndicator 0.0.0.9080

* In `products`, `activity_uuid_product_uuid` is now unique (#447).

# tiltIndicator 0.0.0.9079

* `xctr()` now outputs results at both levels (#443).

# tiltIndicator 0.0.0.9078

* `istr()` now outputs results at both levels (#442).

# tiltIndicator 0.0.0.9077

* `pstr()` now outputs results at both levels (#441).

* New `unnest_product()` and `unnest_company()` help get results at product and
company levels from nested outputs like the one of `pstr()`.

# tiltIndicator 0.0.0.9076

* Ensure all outputs have no duplicate (#438)

# tiltIndicator 0.0.0.9075

* XSTR no longer errors with duplicated scenarios (#437).

# tiltIndicator 0.0.0.9074

* For all indicators at product level, each company with some match outputs no `NA`, and with no match outputs 1 row with `NA`s in all columns (except `companeis_id` (#436).

# tiltIndicator 0.0.0.9073

* For all indicators at company level, each company with a match has 3 `value`s that sum 1 and no `NA` for each level of `grouped_by`, and each company with no match has 1 `value` that is `NA` in total (#434).

# tiltIndicator 0.0.0.9072

* `xstr_prepare_scenario()` with duplicated scenario data now throws an error (#431). This avoids running indicators with corrupt input data and alerts that
the preparation must be fixed.

# tiltIndicator 0.0.0.9071

* `istr()` is now sensitive to `low_threshold` and `high_threshold` (#420).

# tiltIndicator 0.0.0.9070

* New `xstr_scenarios` replaces `istr_scenarios` and `pstr_scenarios` (@kalashsinghal #413).

# tiltIndicator 0.0.0.9069

* `pstr_prepare_scenario()` is now named `xstr_prepare_scenario()` (#385).

# tiltIndicator 0.0.0.9068

* `pstr_polish_output_at_copmany_level()` is now named `xstr_polish_output_at_copmany_level()` (#383).

# tiltIndicator 0.0.0.9067

* `xstr_prune_companies()` now expects the column `company_id` (#380).

# tiltIndicator 0.0.0.9066

* New helper `xstr_prune_companies()` to drop rows where product info is 'NA' & sector info is duplicated (#379).

# tiltIndicator 0.0.0.9065

* `istr_inputs` now includes columns required in the output (@kalashsinghal #376).

# tiltIndicator 0.0.0.9064

* In XSTR `NA`s in reductions are no longer an error but handled specially (@lindadelacombaz #350).

* In ISTR sample data and code now use the new structure (@kalashsinghal #353).

* In ISTR default thresholds are now the same as in XCTR (@lindadelacombaz #348).

# tiltIndicator 0.0.0.9063

* XXTR functions now stop if `companies` has 0-rows (#340).

# tiltIndicator 0.0.0.9062

* XSTR and XCTR functions now stop if `scenarios` or `co2` has 0-row (#337, #338).

# tiltIndicator 0.0.0.9061

* In PSTR default thresholds are now the  same as in XCTR (@lindadelacombaz #329).

# tiltIndicator 0.0.0.9060

* New `pstr_polish_output_at_company_level()` (#327)

# tiltIndicator 0.0.0.9059

* The article "Handling long runtime" is now updated based on the experience running `pstr*()` (#314).

# tiltIndicator 0.0.0.9058

* Each scenario `type` must have some `sector` and `subsector`, else you
an error (#311).

# tiltIndicator 0.0.0.9057

* `pstr_prepare_scenario()` now handles "weo" data correctly (@kalashsinghal #309).

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

* A company with 3 different products and varying footprints now gets correct value (@Tilmon #248).

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

