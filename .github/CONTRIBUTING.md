# Contributing to tiltIndicator

## Build package infrastructure

* Enable developer workflow: `create_package()`.
* Use a license: `use_mit_license()`.
* Enable tests: `use_testthat()`
* Enable CI: `use_github_action_check_standard()`.
* Create a directory for each mvp.Rmd at: inst/extdata/mvp/.
* Avoid leaking private data: In inst/extdata/mvp/.gitignore add:

    ```
    *.*
    !*.Rmd
    ```

* Create a website: `use_pkgdown_github_pages()`

## Refactor each indicator's MVP to production

For each indicator `use_indicator_issue()` on GitHub and do what it says.

## Principles, guides and tools

* [Tidyverse style guide](https://style.tidyverse.org/): `use_tidy_style()`.
* Tidyverse spelling: `use_spell_check()`.
* [Tidyverse design guide](https://design.tidyverse.org/).
* [Tidyverse code review principles](https://davisvaughan.github.io/code-review/).
