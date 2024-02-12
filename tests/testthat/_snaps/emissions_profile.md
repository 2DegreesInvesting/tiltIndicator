# hasn't change

    Code
      format_robust_snapshot(unnest_product(out))
    Output
      [[1]]
               companies_id
      1 antimonarchy_canine
      2 antimonarchy_canine
      3 antimonarchy_canine
      4 antimonarchy_canine
      5 antimonarchy_canine
      6 antimonarchy_canine
      
      [[2]]
              grouped_by
      1              all
      2      isic_4digit
      3      tilt_sector
      4             unit
      5 unit_isic_4digit
      6 unit_tilt_sector
      
      [[3]]
        risk_category
      1          high
      2          high
      3          high
      4          high
      5          high
      6          high
      
      [[4]]
        profile_ranking
      1               1
      2               1
      3               1
      4               1
      5               1
      6               1
      
      [[5]]
        clustered
      1      tent
      2      tent
      3      tent
      4      tent
      5      tent
      6      tent
      
      [[6]]
                  activity_uuid_product_uuid
      1 76269c17-78d6-420b-991a-aa38c51b45b7
      2 76269c17-78d6-420b-991a-aa38c51b45b7
      3 76269c17-78d6-420b-991a-aa38c51b45b7
      4 76269c17-78d6-420b-991a-aa38c51b45b7
      5 76269c17-78d6-420b-991a-aa38c51b45b7
      6 76269c17-78d6-420b-991a-aa38c51b45b7
      
      [[7]]
        co2_footprint
      1      302.7862
      2      302.7862
      3      302.7862
      4      302.7862
      5      302.7862
      6      302.7862
      

---

    Code
      format_robust_snapshot(unnest_company(out))
    Output
      [[1]]
                companies_id
      1  antimonarchy_canine
      2  antimonarchy_canine
      3  antimonarchy_canine
      4  antimonarchy_canine
      5  antimonarchy_canine
      6  antimonarchy_canine
      7  antimonarchy_canine
      8  antimonarchy_canine
      9  antimonarchy_canine
      10 antimonarchy_canine
      11 antimonarchy_canine
      12 antimonarchy_canine
      13 antimonarchy_canine
      14 antimonarchy_canine
      15 antimonarchy_canine
      16 antimonarchy_canine
      17 antimonarchy_canine
      18 antimonarchy_canine
      
      [[2]]
               grouped_by
      1               all
      2               all
      3               all
      4       isic_4digit
      5       isic_4digit
      6       isic_4digit
      7       tilt_sector
      8       tilt_sector
      9       tilt_sector
      10             unit
      11             unit
      12             unit
      13 unit_isic_4digit
      14 unit_isic_4digit
      15 unit_isic_4digit
      16 unit_tilt_sector
      17 unit_tilt_sector
      18 unit_tilt_sector
      
      [[3]]
         risk_category
      1           high
      2         medium
      3            low
      4           high
      5         medium
      6            low
      7           high
      8         medium
      9            low
      10          high
      11        medium
      12           low
      13          high
      14        medium
      15           low
      16          high
      17        medium
      18           low
      
      [[4]]
         value
      1      1
      2      0
      3      0
      4      1
      5      0
      6      0
      7      1
      8      0
      9      0
      10     1
      11     0
      12     0
      13     1
      14     0
      15     0
      16     1
      17     0
      18     0
      

# FIXME? at company level, `NA` in a benchmark yields the expected `value`s (#638)

    Code
      filter(unnest_company(emissions_profile(companies, co2)), grepl(benchmark,
        grouped_by))
    Output
      # A tibble: 8 x 4
        companies_id grouped_by       risk_category value
        <chr>        <chr>            <chr>         <dbl>
      1 a            isic_4digit      high            0.5
      2 a            isic_4digit      medium          0  
      3 a            isic_4digit      low             0  
      4 a            isic_4digit      <NA>            0.5
      5 a            unit_isic_4digit high            0.5
      6 a            unit_isic_4digit medium          0  
      7 a            unit_isic_4digit low             0  
      8 a            unit_isic_4digit <NA>            0.5

---

    Code
      filter(unnest_company(emissions_profile(companies, co2)), grepl(benchmark,
        grouped_by))
    Output
      # A tibble: 8 x 4
        companies_id grouped_by       risk_category value
        <chr>        <chr>            <chr>         <dbl>
      1 a            tilt_sector      high            0.5
      2 a            tilt_sector      medium          0  
      3 a            tilt_sector      low             0  
      4 a            tilt_sector      <NA>            0.5
      5 a            unit_tilt_sector high            0.5
      6 a            unit_tilt_sector medium          0  
      7 a            unit_tilt_sector low             0  
      8 a            unit_tilt_sector <NA>            0.5

---

    Code
      filter(unnest_company(emissions_profile(companies, co2)), grepl(benchmark,
        grouped_by))
    Output
      # A tibble: 9 x 4
        companies_id grouped_by       risk_category value
        <chr>        <chr>            <chr>         <dbl>
      1 a            unit             high              1
      2 a            unit             medium            0
      3 a            unit             low               0
      4 a            unit_isic_4digit high              1
      5 a            unit_isic_4digit medium            0
      6 a            unit_isic_4digit low               0
      7 a            unit_tilt_sector high              1
      8 a            unit_tilt_sector medium            0
      9 a            unit_tilt_sector low               0

