# document_dataset() outputs the expected text

    Code
      document_dataset()
    Output
      [1] "A dataframe like the dataset with a matching name in tiltToyData (see [Reference](https://2degreesinvesting.github.io/tiltToyData/reference/index.html))"

# document_value() outputs the expected text

    Code
      document_value()
    Output
      [1] "A data frame with the column `companies_id`, and the nested columns`product` and `company` holding the outputs at product and company level. Unnesting `product` yields a data frame with at least columns `companies_id`, `grouped_by`, `risk_category`. Unnesting `company` yields a data frame with at least columns `companies_id`, `grouped_by`, `risk_category`, `value`. Any column in the input datasets ending with `*rowid` is also passed as is to the output at product level. The exception is any column named exactly `rowid` or `co2_rowid` -- which are reserved names and throws an error. Note this feature makes no sense at company level because potentially multiple rows in the input datasets are summarized into a single row in the output at company level."

