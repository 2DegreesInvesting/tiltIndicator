# hasn't change

    Code
      format_robust_snapshot(unnest_product(out))
    Output
      [[1]]
                  companies_id
      1 soot_asianpiedstarling
      
      [[2]]
         grouped_by
      1 tilt_sector
      
      [[3]]
        risk_category
      1           low
      
      [[4]]
        profile_ranking
      1       0.1714855
      
      [[5]]
        clustered
      1      tent
      
      [[6]]
                  activity_uuid_product_uuid
      1 76269c17-78d6-420b-991a-aa38c51b45b7
      
      [[7]]
        co2_footprint
      1     0.4045247
      

---

    Code
      format_robust_snapshot(unnest_company(out))
    Output
      [[1]]
                  companies_id
      1 soot_asianpiedstarling
      2 soot_asianpiedstarling
      3 soot_asianpiedstarling
      
      [[2]]
         grouped_by
      1 tilt_sector
      2 tilt_sector
      3 tilt_sector
      
      [[3]]
        risk_category
      1          high
      2        medium
      3           low
      
      [[4]]
        value
      1     0
      2     0
      3     1
      

