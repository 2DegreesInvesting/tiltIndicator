# at product level, Tilman's example yields what he expects

    Code
      product
    Output
      # A tibble: 5 x 11
        companies_id grouped_by risk_category profile_ranking clustered
        <chr>        <chr>      <chr>                   <dbl> <chr>    
      1 a            ipr_a_2050 high                      1   a        
      2 a            weo_a_2050 medium                    0.6 a        
      3 a            <NA>       <NA>                     NA   b        
      4 a            ipr_a_2050 low                       0.3 c        
      5 a            weo_a_2050 <NA>                     NA   c        
      # i 6 more variables: activity_uuid_product_uuid <chr>, tilt_sector <chr>,
      #   scenario <chr>, year <dbl>, type <chr>, tilt_subsector <chr>

# at company level, Tilman's example yields what he expects

    Code
      product
    Output
      # A tibble: 5 x 5
        companies_id grouped_by risk_category profile_ranking clustered
        <chr>        <chr>      <chr>                   <dbl> <chr>    
      1 a            ipr_a_2050 high                      1   a        
      2 a            weo_a_2050 medium                    0.6 a        
      3 a            <NA>       <NA>                     NA   b        
      4 a            ipr_a_2050 low                       0.3 c        
      5 a            weo_a_2050 <NA>                     NA   c        

