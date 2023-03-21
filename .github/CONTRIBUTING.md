# Contributing to tiltIndicator

This article if for the developer of each indicator, responsible to converting
MVP code into production code. Here you'll find guides and tools to ensure each
indicator is documented and developed consistently with other indicators, and
accordingly to the requirements of the indicator author.

## Meta: Building the infrastructure of this package

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

## Documentation

* Guide to documentation[this article](https://2degreesinvesting.github.io/tiltIndicator/articles/indicator-docs.html).

## Tools

* [Developer-oriented functions](https://2degreesinvesting.github.io/tiltIndicator/reference/index.html#developer-oriented-functions).

## Principles, guides and tools

* [Tidyverse style guide](https://style.tidyverse.org/): `use_tidy_style()`.
* Tidyverse spelling: `use_spell_check()`.
* [Tidyverse design guide](https://design.tidyverse.org/).
* [Tidyverse code review principles](https://davisvaughan.github.io/code-review/).
