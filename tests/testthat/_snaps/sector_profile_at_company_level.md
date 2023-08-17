# still works but warns deprecation

    Code
      product <- spi_product(companies, scenarios)
      out <- spi_company(product)
      expect_named(out, cols_at_company_level())

# hasn't changed

    Code
      format_robust_snapshot(out)
    Output
      [[1]]
                                    companies_id
      1 fleischerei-stiefsohn_00000005219477-001
      2 fleischerei-stiefsohn_00000005219477-001
      3 fleischerei-stiefsohn_00000005219477-001
      4 fleischerei-stiefsohn_00000005219477-001
      5 fleischerei-stiefsohn_00000005219477-001
      6 fleischerei-stiefsohn_00000005219477-001
      
      [[2]]
               grouped_by
      1 ipr_1.5c rps_2030
      2 ipr_1.5c rps_2030
      3 ipr_1.5c rps_2030
      4 ipr_1.5c rps_2050
      5 ipr_1.5c rps_2050
      6 ipr_1.5c rps_2050
      
      [[3]]
        risk_category
      1          high
      2        medium
      3           low
      4          high
      5        medium
      6           low
      
      [[4]]
        value
      1     1
      2     0
      3     0
      4     1
      5     0
      6     0
      

