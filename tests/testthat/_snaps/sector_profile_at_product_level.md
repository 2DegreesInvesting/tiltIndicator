# outputs expected columns at product level

    Code
      names(out)
    Output
       [1] "companies_id"               "grouped_by"                
       [3] "risk_category"              "profile_ranking"           
       [5] "clustered"                  "activity_uuid_product_uuid"
       [7] "tilt_subsector"             "scenario"                  
       [9] "year"                       "type"                      
      [11] "tilt_sector"               

# with ';' in `*sector` throws an warning

    The `*sector` columns used to match scenarios shouln't have semicolon ';'.
    x Unmatched values of `sector` and `subsector` result in `NA`s.
    i Do you need see the evolution of this issue on GitHub (#448)?

