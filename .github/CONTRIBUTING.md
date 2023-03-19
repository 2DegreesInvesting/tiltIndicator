# Contributing to tiltIndicator

Checklist to add a new indicator:

Build infrastructure:

- [ ] Enable developer workflow: `usethis::create_package()`.
- [ ] Use a license: `usethis::use_mit_license()`.
- [ ] Enable tests: `usethis::use_testthat()`
- [ ] Enable CI: `use_github_action_check_standard()`.
- [ ] Enable publishing: `usethis::use_pkgdown_github_pages()`.
- [ ] Avoid leaking private data in sensitive directories, e.g.:
```
# data-raw/.gitignore

# Avoid leaking private data that might result from rendering files
*.html
*.md
*_files
```

Refactor prototype to production:

- [ ] Copy prototype code to `data-raw/<prototype-name>/README.md`
- [ ] Document authorship in the prototype directory and in DESCRIPTION.
- [ ] Redirect paths with a helper to `path(data_dir(), "<indicator name>")`.
- [ ] Access outputs with a helper to `path(data_dir(), "<indicator name>")`.
- [ ] Confirm you can knit, and that you won't commit private data!
- [ ] Capture the important outputs for regression tests.

Principles, guides and tools:

* [Tidyverse style guide](https://style.tidyverse.org/): `usethis::use_tidy_style()`.
* Tidyverse spelling: `usethis::use_spell_check()`.
* [Tidyverse design guide](https://design.tidyverse.org/).
* [Tidyverse code review principles](https://davisvaughan.github.io/code-review/).
