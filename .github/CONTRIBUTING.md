# Contributing to tiltIndicator

Checklist to add a new indicator:

Build infrastructure:

- [ ] Enable developer workflow: `create_package()`.
- [ ] Use a license: `use_mit_license()`.
- [ ] Enable tests: `use_testthat()`
- [ ] Enable CI: `use_github_action_check_standard()`.

Refactor indicator code to production:

- [ ] `use_article("ind")`.
- [ ] Avoid leaking private data: In vignettes ignore all files except .Rmd:

    ```
    # vignettes/.gitignore
    *.*
    !*.Rmd
    ```

- [ ] Document authorship in the article and in DESCRIPTION.
- [ ] Redirect inputs to read from private data dir: `here <- indicator_path`.
- [ ] Redirect outputs to write to "obj.csv": `write_csv(obj, "obj.csv")`.
- [ ] Confirm the article doesn't leak private data.
- [ ] Confirm the article is reproducible: `pkgdown::build_articles()`.
- [ ] Create `ind_obj()` to return "obj" from `wrap_rmd(".../ind.Rmd")`.
- [ ] Characterize current behavior with a test.

Principles, guides and tools:

* [Tidyverse style guide](https://style.tidyverse.org/): `use_tidy_style()`.
* Tidyverse spelling: `use_spell_check()`.
* [Tidyverse design guide](https://design.tidyverse.org/).
* [Tidyverse code review principles](https://davisvaughan.github.io/code-review/).
