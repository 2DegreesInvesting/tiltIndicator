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
      1                 all
      2         isic_4digit
      3      tilt_subsector
      4                unit
      5    unit_isic_4digit
      6 unit_tilt_subsector
      
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
      19 antimonarchy_canine
      20 antimonarchy_canine
      21 antimonarchy_canine
      22 antimonarchy_canine
      23 antimonarchy_canine
      24 antimonarchy_canine
      
      [[2]]
                  grouped_by
      1                  all
      2                  all
      3                  all
      4                  all
      5          isic_4digit
      6          isic_4digit
      7          isic_4digit
      8          isic_4digit
      9       tilt_subsector
      10      tilt_subsector
      11      tilt_subsector
      12      tilt_subsector
      13                unit
      14                unit
      15                unit
      16                unit
      17    unit_isic_4digit
      18    unit_isic_4digit
      19    unit_isic_4digit
      20    unit_isic_4digit
      21 unit_tilt_subsector
      22 unit_tilt_subsector
      23 unit_tilt_subsector
      24 unit_tilt_subsector
      
      [[3]]
         risk_category
      1           high
      2         medium
      3            low
      4           <NA>
      5           high
      6         medium
      7            low
      8           <NA>
      9           high
      10        medium
      11           low
      12          <NA>
      13          high
      14        medium
      15           low
      16          <NA>
      17          high
      18        medium
      19           low
      20          <NA>
      21          high
      22        medium
      23           low
      24          <NA>
      
      [[4]]
         value
      1      1
      2      0
      3      0
      4      0
      5      1
      6      0
      7      0
      8      0
      9      1
      10     0
      11     0
      12     0
      13     1
      14     0
      15     0
      16     0
      17     1
      18     0
      19     0
      20     0
      21     1
      22     0
      23     0
      24     0
      

# at company level, three matched products with different `co2_footprint`, one missing benchmark, and one unmatched product yield the expected output

    Code
      missing_benchmark
    Output
      # A tibble: 8 x 4
        companies_id grouped_by       risk_category value
        <chr>        <chr>            <chr>         <dbl>
      1 a            isic_4digit      high            0.2
      2 a            isic_4digit      medium          0.2
      3 a            isic_4digit      low             0.2
      4 a            isic_4digit      <NA>            0.4
      5 a            unit_isic_4digit high            0.2
      6 a            unit_isic_4digit medium          0.2
      7 a            unit_isic_4digit low             0.2
      8 a            unit_isic_4digit <NA>            0.4

---

    Code
      no_missing_benchmark
    Output
      # A tibble: 16 x 4
         companies_id grouped_by          risk_category value
         <chr>        <chr>               <chr>         <dbl>
       1 a            all                 high            0.4
       2 a            all                 medium          0.2
       3 a            all                 low             0.2
       4 a            all                 <NA>            0.2
       5 a            tilt_subsector      high            0.4
       6 a            tilt_subsector      medium          0.2
       7 a            tilt_subsector      low             0.2
       8 a            tilt_subsector      <NA>            0.2
       9 a            unit                high            0.4
      10 a            unit                medium          0.2
      11 a            unit                low             0.2
      12 a            unit                <NA>            0.2
      13 a            unit_tilt_subsector high            0.4
      14 a            unit_tilt_subsector medium          0.2
      15 a            unit_tilt_subsector low             0.2
      16 a            unit_tilt_subsector <NA>            0.2

