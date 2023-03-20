# Contributing to tiltIndicator

Checklist to add a new indicator:

Build infrastructure:

- [ ] Enable developer workflow: `create_package()`.
- [ ] Use a license: `use_mit_license()`.
- [ ] Enable tests: `use_testthat()`
- [ ] Enable CI: `use_github_action_check_standard()`.
- [ ] Create a directory for each mvp.Rmd at: inst/extdata/mvp/.
- [ ] Avoid leaking private data: In inst/extdata/mvp/.gitignore add:

    ```
    *.*
    !*.Rmd
    ```

- [ ] Create a website: `use_pkgdown_github_pages()`

Refactor indicator code to production:

- [ ] Add each indicator as inst/extdata/mvp/indicator.Rmd.
- [ ] Document authorship in the indocator.Rmd and in DESCRIPTION.
- [ ] Redirect inputs to read from private data dir: `here <- indicator_path`.
- [ ] Redirect outputs to write to "obj.csv": `write_csv(obj, "obj.csv")`.
- [ ] Confirm rendering the indicator.Rmd doesn't leak private data.
- [ ] Confirm rendering the indicator.Rmd doesn't leak private data.
- [ ] Create `ind_obj()` to return "obj" from `wrap_rmd(".../ind.Rmd")`.
- [ ] Snapshot-test `ind_obj` via `test_dir("/path/to/private/directory/")`.

Principles, guides and tools:

* [Tidyverse style guide](https://style.tidyverse.org/): `use_tidy_style()`.
* Tidyverse spelling: `use_spell_check()`.
* [Tidyverse design guide](https://design.tidyverse.org/).
* [Tidyverse code review principles](https://davisvaughan.github.io/code-review/).
