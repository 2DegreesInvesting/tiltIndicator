# outputs a multi-line checklist

    Code
      use_refactoring_checklist()
    Output
      - [ ] Add inst/extdata/mvp/indicator.Rmd.
      - [ ] Document authorship in */indicator.Rmd
      - [ ] Document authorship DESCRIPTION.
      - [ ] Redirect inputs to read from private data dir: `here <- i_path`.
      - [ ] Redirect outputs to write to 'obj.csv': `write_csv(obj, 'obj.csv')`.
      - [ ] Confirm rendering */indicator.Rmd doesn't leak private data.
      - [ ] Create `i_obj()` to return 'obj' from `wrap_rmd('*/i.Rmd')`.
      - [ ] Snapshot `i_obj()` via `test_dir('/path/to/private/directory/')`.
      - [ ] Document `i_obj()`.
      - [ ] Refactor `i_obj()`.

