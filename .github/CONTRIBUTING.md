# Contributing to tiltIndicator

Checklist to add a new indicator:

Build infrastructure:

- [ ] Enable developer workflow: `usethis::create_package()`.
- [ ] Use a license: `usethis::use_mit_license()`.
- [ ] Enable tests: `usethis::use_testthat()`
- [ ] Enable CI: `use_github_action_check_standard()`.
- [ ] Enable publishing: `usethis::use_pkgdown_github_pages()`.

Refactor prototype to production:

- [ ] Copy prototype code to `data-raw/<prototype-name>/README.md`
- [ ] Document authorship in the prototype directory and in DESCRIPTION.
