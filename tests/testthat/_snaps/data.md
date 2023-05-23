# `companies` hasn't changed

    Code
      format_robust_snapshot(tiltIndicator::companies)
    Output
      [[1]]
                                                       activity_uuid_product_uuid
      1 0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      2 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      3 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db4
      4 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      5 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      6 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      7 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      8 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      9                                                                      <NA>
      
      [[2]]
          clustered
      1       stove
      2        oven
      3       steel
      4 aged cheese
      5 aged cheese
      6      cheese
      7       cream
      8      rubber
      9       apple
      
      [[3]]
                                      company_id
      1 fleischerei-stiefsohn_00000005219477-001
      2 fleischerei-stiefsohn_00000005219477-001
      3        pecheries-basques_fra316541-00101
      4    hoche-butter-gmbh_deu422723-693847001
      5  vicquelin-espaces-verts_fra697272-00101
      6   bst-procontrol-gmbh_00000005104947-001
      7           leider-gmbh_00000005064318-001
      8             cheries-baqu_neu316541-00101
      9       ca-coity-trg-aua-gmbh_00000384-001
      
      [[4]]
        unit
      1 unit
      2 unit
      3   kg
      4   kg
      5   kg
      6   kg
      7   kg
      8   kg
      9 <NA>
      

# `inputs` hasn't changed

    Code
      format_robust_snapshot(tiltIndicator::inputs)
    Output
      [[1]]
         input_co2_footprint
      1         7.072358e+00
      2         3.991892e+01
      3         5.118673e-01
      4         1.235611e+00
      5         2.124534e+01
      6         1.240000e-09
      7         7.000000e-09
      8         1.036423e+00
      9         1.120764e+00
      10        3.514822e+00
      11        5.690000e-04
      12        1.155505e-01
      13        5.391936e-02
      14        4.427605e+00
      15        6.001636e-01
      16        4.304207e+00
      17        9.830356e-03
      18        1.024621e-03
      19        3.076822e-02
      20        3.123531e-03
      21       -3.350000e-06
      22       -1.136353e-03
      23        2.601609e-01
      24        2.843441e-01
      25        1.099965e+01
      26        1.006155e-03
      27        3.243020e-02
      28        1.199468e-01
      29        1.868036e+00
      30        4.545829e-03
      31        2.200131e-02
      32        5.292432e-02
      33        4.894748e-03
      
      [[2]]
         input_tilt_sector
      1           Inudstry
      2           Inudstry
      3           Inudstry
      4           Inudstry
      5           Inudstry
      6           Inudstry
      7           Inudstry
      8           Inudstry
      9           Inudstry
      10          Inudstry
      11          Inudstry
      12          Inudstry
      13          Inudstry
      14          Inudstry
      15    Steel & Metals
      16    Steel & Metals
      17    Steel & Metals
      18    Steel & Metals
      19    Steel & Metals
      20    Steel & Metals
      21 Bioenergy & Waste
      22 Bioenergy & Waste
      23 Bioenergy & Waste
      24 Bioenergy & Waste
      25 Bioenergy & Waste
      26 Bioenergy & Waste
      27 Bioenergy & Waste
      28          Inudstry
      29          Inudstry
      30          Inudstry
      31          Inudstry
      32          Inudstry
      33          Inudstry
      
      [[3]]
            input_unit
      1             kg
      2            kwh
      3             kg
      4             kg
      5            kwh
      6             kg
      7             kg
      8             kg
      9             kg
      10            kg
      11            kg
      12           kwh
      13            kg
      14            kg
      15           kwh
      16            kg
      17 metric ton*km
      18 metric ton*km
      19 metric ton*km
      20 metric ton*km
      21            kg
      22            kg
      23           kwh
      24            kg
      25            kg
      26            kg
      27            m3
      28            kg
      29            kg
      30 metric ton*km
      31 metric ton*km
      32 metric ton*km
      33 metric ton*km
      
      [[4]]
         input_isic_4digit
      1               2560
      2               2560
      3               2560
      4               2560
      5               2560
      6               2560
      7               2560
      8               2560
      9               2560
      10              2560
      11              2560
      12              2560
      13              2560
      14              2560
      15              2870
      16              2870
      17              2870
      18              2870
      19              2870
      20              2870
      21              1780
      22              1780
      23              1780
      24              1780
      25              1780
      26              1780
      27              1780
      28              2679
      29              2679
      30              2679
      31              2679
      32              2679
      33              2679
      
      [[5]]
                                             input_activity_uuid_product_uuid
      1  5de8c337-dea9-5c1f-9d90-002de27188be_8911bd8c-a96f-4440-9f8e-a7dacf5
      2  1aeb18b9-8355-560f-82aa-543c771c4d61_a0e53510-b90b-43ba-80cc-7600f5d
      3     22704506-7707-5ae7-990d-ebf01ac04fb5_50c41012-3b00-429d-ace3-40d0
      4  92078219-1ed3-5215-9f70-931cdefad520_5c21b18e-e32d-4c76-8d16-2238632
      5    9d483329-b09a-5513-b1bc-722cb211e928_bd4dca-497e-bdd9-fcd343012087
      6    8709b463-732e-592e-9b88-999ed17af48f_6b6b3a15-e0-baea-cda98afc61c2
      7     d44e7db1-4dda-51ed2929a8f1a2_32e60fbc-4778-470c-9653-feb859a3418f
      8     7c7718bb-2372-5d04-a7ac-1ae5b12b05e3_61396bcb-bf35-411a-a6a6-85e8
      9        f08f52c5-559-92f7-ed216a32eed2_1b30b018-ac39-41f4-a9e0-92057ee
      10          c5f28517-0c26-5746-9afe-3f3a48bfc71c_85a9dda1a-105ab3269262
      11       6737f21a-545-d3e724540ab7_66c93e71-f32b-4591-901c-55395db5c132
      12    582707f4-f961-5779-b1d9-507bdf5624ef_a9007f10-7e39-4d50-8f4a-d6d0
      13          04bc1d7b-4aeb-57ea-b217-9d70048-5f1b-461d-a223-f08025ec51d6
      14         2532d5f6-7cec-5b3d-8b4f-9d19d5fce0c2_d47a4435-308911eed2698c
      15   1a092e74-9095-5393-89f6-6954fb3ed34b_a97e39-4d50-8f4a-d6d03ce3d673
      16            e9afeb6-e0ac327258e0_18eadf40-089b-441a-b868-5d07e9449992
      17            f3aeaa91-d091-57d6-8e88-632e7735b471_a99b6ce9-9c21427d045
      18      088c0a08-55f2-529d-8077-309d5228c5e1_1c5d51e7-9762-5fbb-b707-03
      19           aaacb824-d084b1a7ed0aee_1d32b849-121f-4d23-853c-fa2bf55c42
      20              3d83e6ad-da6e-52cd-b5d5-764749b27b0d-f0ec-42d1-9ec1-f85
      21                   dd836037-c3-8791-29cfb2d98c17_2bf7e6c9-e68a9724d81
      22               b43e277b-fbbc-59ef-b69c-566cc02d3ee4_a9007f6d03ce3d673
      23               f1b81a2c-26ad-56f4-8120-d7affa5ab053_7933f397-3db0ae03
      24                        d1747a2e--0bb44d158a0b_dae141a8-7daa-4f03-a64
      25              c0e9d55b-7a17-5a0a-b67e-517f813c446ed-a120-cc7d35ddac10
      26                       f0d2c218-2b61-55e4-991f-cccc7c168e37_a235b2ff-
      27               86f30e6d-d629-52ed-aeda-68a82ba-485c-a800-b89efdcb0491
      28          e7efa084-9c9c-519c-9c88-a0e43926ef95_61627325--1a9f1d19521f
      29        d9b1a425-7453-562f-802f-e78677f5bd00_a9007f10-7a-d6d03ce3d673
      30      4283166a-347b-5eef-9ab1-fcea0c339bc-f0f3-410e-8bbb-b5cb3e994313
      31            4550d429-b28d-b26c51_66c93e71-f32b-4591-901c-55395db5c132
      32                  6501c38f-4c03-5bda-bf8c-ffe4-4915-a896-9996a014c410
      33              4ba8cd24-2ebb-5c20-86ec-74e10029f21f_f5707bdf-f7e2-479b
      
      [[6]]
                                                        activity_uuid_product_uuid
      1  0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      2  0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      3  0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      4  0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      5  0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      6  0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      7  0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      8  0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      9  be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      10 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      11 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      12 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      13 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      14 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      15 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db4
      16 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db4
      17 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db4
      18 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db4
      19 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db4
      20 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db4
      21 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      22 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      23 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      24 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      25 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      26 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      27 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      28 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      29 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      30 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      31 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      32 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      33 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      

# `products` hasn't changed

    Code
      format_robust_snapshot(tiltIndicator::products)
    Output
      [[1]]
        co2_footprint
      1    175.615478
      2     58.120002
      3      4.949118
      4     12.468865
      5     12.485806
      6      2.072349
      7      1.982112
      
      [[2]]
           tilt_sector
      1       Industry
      2       Industry
      3 Steel & Metals
      4    Agriculture
      5    Agriculture
      6       Industry
      7       Industry
      
      [[3]]
        unit
      1 unit
      2 unit
      3   kg
      4   kg
      5   kg
      6   kg
      7   kg
      
      [[4]]
        isic_4digit
      1        2560
      2        2560
      3        2870
      4        1780
      5        1780
      6        2679
      7        2679
      
      [[5]]
                                                       activity_uuid_product_uuid
      1 0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      2 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      3 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db4
      4 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      5 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      6 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      7 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      
      [[6]]
                              ei_activity_name
      1       cookstove production or electric
      2              microwave oven production
      3       market for steel, chromium steel
      4 cheese production, soft, from cow milk
      5    market for cheese, fresh, unripened
      6  market for seal, natural rubber based
      7  seal production, natural rubber based
      

# `istr_scenarios` hasn't changed

    Code
      format_robust_snapshot(tiltIndicator::istr_scenarios)
    Output
      [[1]]
                                     scenario
      1         1.5c required policy scenario
      2         1.5c required policy scenario
      3         1.5c required policy scenario
      4         1.5c required policy scenario
      5         1.5c required policy scenario
      6         1.5c required policy scenario
      7         1.5c required policy scenario
      8         1.5c required policy scenario
      9         1.5c required policy scenario
      10        1.5c required policy scenario
      11        1.5c required policy scenario
      12        1.5c required policy scenario
      13        1.5c required policy scenario
      14        1.5c required policy scenario
      15        1.5c required policy scenario
      16        1.5c required policy scenario
      17        1.5c required policy scenario
      18        1.5c required policy scenario
      19        1.5c required policy scenario
      20        1.5c required policy scenario
      21        1.5c required policy scenario
      22        1.5c required policy scenario
      23        1.5c required policy scenario
      24        1.5c required policy scenario
      25        1.5c required policy scenario
      26        1.5c required policy scenario
      27        1.5c required policy scenario
      28        1.5c required policy scenario
      29        1.5c required policy scenario
      30        1.5c required policy scenario
      31        1.5c required policy scenario
      32        1.5c required policy scenario
      33        1.5c required policy scenario
      34        1.5c required policy scenario
      35        1.5c required policy scenario
      36        1.5c required policy scenario
      37        1.5c required policy scenario
      38        1.5c required policy scenario
      39        1.5c required policy scenario
      40        1.5c required policy scenario
      41        1.5c required policy scenario
      42        1.5c required policy scenario
      43        1.5c required policy scenario
      44        1.5c required policy scenario
      45        1.5c required policy scenario
      46        1.5c required policy scenario
      47        1.5c required policy scenario
      48        1.5c required policy scenario
      49        1.5c required policy scenario
      50        1.5c required policy scenario
      51        1.5c required policy scenario
      52        1.5c required policy scenario
      53        1.5c required policy scenario
      54        1.5c required policy scenario
      55        1.5c required policy scenario
      56        1.5c required policy scenario
      57        1.5c required policy scenario
      58        1.5c required policy scenario
      59        1.5c required policy scenario
      60        1.5c required policy scenario
      61        1.5c required policy scenario
      62        1.5c required policy scenario
      63        1.5c required policy scenario
      64        1.5c required policy scenario
      65        1.5c required policy scenario
      66        1.5c required policy scenario
      67        1.5c required policy scenario
      68        1.5c required policy scenario
      69        1.5c required policy scenario
      70        1.5c required policy scenario
      71        1.5c required policy scenario
      72        1.5c required policy scenario
      73        1.5c required policy scenario
      74        1.5c required policy scenario
      75        1.5c required policy scenario
      76        1.5c required policy scenario
      77        1.5c required policy scenario
      78        1.5c required policy scenario
      79        1.5c required policy scenario
      80        1.5c required policy scenario
      81        1.5c required policy scenario
      82        1.5c required policy scenario
      83        1.5c required policy scenario
      84        1.5c required policy scenario
      85        1.5c required policy scenario
      86        1.5c required policy scenario
      87        1.5c required policy scenario
      88        1.5c required policy scenario
      89        1.5c required policy scenario
      90        1.5c required policy scenario
      91        1.5c required policy scenario
      92        1.5c required policy scenario
      93        1.5c required policy scenario
      94        1.5c required policy scenario
      95        1.5c required policy scenario
      96        1.5c required policy scenario
      97        1.5c required policy scenario
      98        1.5c required policy scenario
      99        1.5c required policy scenario
      100       1.5c required policy scenario
      101       1.5c required policy scenario
      102       1.5c required policy scenario
      103       1.5c required policy scenario
      104       1.5c required policy scenario
      105       1.5c required policy scenario
      106       1.5c required policy scenario
      107       1.5c required policy scenario
      108       1.5c required policy scenario
      109       1.5c required policy scenario
      110       1.5c required policy scenario
      111       1.5c required policy scenario
      112       1.5c required policy scenario
      113            stated policies scenario
      114            stated policies scenario
      115            stated policies scenario
      116            stated policies scenario
      117            stated policies scenario
      118            stated policies scenario
      119            stated policies scenario
      120            stated policies scenario
      121            stated policies scenario
      122            stated policies scenario
      123            stated policies scenario
      124            stated policies scenario
      125            stated policies scenario
      126            stated policies scenario
      127            stated policies scenario
      128            stated policies scenario
      129            stated policies scenario
      130            stated policies scenario
      131            stated policies scenario
      132            stated policies scenario
      133            stated policies scenario
      134            stated policies scenario
      135            stated policies scenario
      136            stated policies scenario
      137            stated policies scenario
      138            stated policies scenario
      139            stated policies scenario
      140            stated policies scenario
      141            stated policies scenario
      142            stated policies scenario
      143            stated policies scenario
      144            stated policies scenario
      145            stated policies scenario
      146            stated policies scenario
      147            stated policies scenario
      148            stated policies scenario
      149            stated policies scenario
      150            stated policies scenario
      151            stated policies scenario
      152            stated policies scenario
      153            stated policies scenario
      154            stated policies scenario
      155            stated policies scenario
      156            stated policies scenario
      157            stated policies scenario
      158            stated policies scenario
      159            stated policies scenario
      160            stated policies scenario
      161            stated policies scenario
      162            stated policies scenario
      163            stated policies scenario
      164            stated policies scenario
      165            stated policies scenario
      166            stated policies scenario
      167            stated policies scenario
      168            stated policies scenario
      169            stated policies scenario
      170            stated policies scenario
      171            stated policies scenario
      172            stated policies scenario
      173            stated policies scenario
      174            stated policies scenario
      175            stated policies scenario
      176            stated policies scenario
      177            stated policies scenario
      178            stated policies scenario
      179            stated policies scenario
      180            stated policies scenario
      181            stated policies scenario
      182            stated policies scenario
      183            stated policies scenario
      184            stated policies scenario
      185            stated policies scenario
      186            stated policies scenario
      187            stated policies scenario
      188            stated policies scenario
      189            stated policies scenario
      190            stated policies scenario
      191            stated policies scenario
      192            stated policies scenario
      193            stated policies scenario
      194            stated policies scenario
      195            stated policies scenario
      196            stated policies scenario
      197            stated policies scenario
      198            stated policies scenario
      199            stated policies scenario
      200            stated policies scenario
      201            stated policies scenario
      202            stated policies scenario
      203            stated policies scenario
      204            stated policies scenario
      205            stated policies scenario
      206            stated policies scenario
      207            stated policies scenario
      208            stated policies scenario
      209            stated policies scenario
      210            stated policies scenario
      211            stated policies scenario
      212            stated policies scenario
      213            stated policies scenario
      214            stated policies scenario
      215            stated policies scenario
      216            stated policies scenario
      217            stated policies scenario
      218            stated policies scenario
      219            stated policies scenario
      220            stated policies scenario
      221            stated policies scenario
      222            stated policies scenario
      223            stated policies scenario
      224            stated policies scenario
      225            stated policies scenario
      226            stated policies scenario
      227            stated policies scenario
      228            stated policies scenario
      229            stated policies scenario
      230            stated policies scenario
      231            stated policies scenario
      232            stated policies scenario
      233            stated policies scenario
      234            stated policies scenario
      235            stated policies scenario
      236            stated policies scenario
      237          announced pledges scenario
      238          announced pledges scenario
      239          announced pledges scenario
      240          announced pledges scenario
      241          announced pledges scenario
      242          announced pledges scenario
      243          announced pledges scenario
      244          announced pledges scenario
      245          announced pledges scenario
      246          announced pledges scenario
      247          announced pledges scenario
      248          announced pledges scenario
      249          announced pledges scenario
      250          announced pledges scenario
      251          announced pledges scenario
      252          announced pledges scenario
      253          announced pledges scenario
      254          announced pledges scenario
      255          announced pledges scenario
      256          announced pledges scenario
      257          announced pledges scenario
      258          announced pledges scenario
      259          announced pledges scenario
      260          announced pledges scenario
      261          announced pledges scenario
      262          announced pledges scenario
      263          announced pledges scenario
      264          announced pledges scenario
      265          announced pledges scenario
      266          announced pledges scenario
      267          announced pledges scenario
      268          announced pledges scenario
      269          announced pledges scenario
      270          announced pledges scenario
      271          announced pledges scenario
      272          announced pledges scenario
      273          announced pledges scenario
      274          announced pledges scenario
      275          announced pledges scenario
      276          announced pledges scenario
      277          announced pledges scenario
      278          announced pledges scenario
      279          announced pledges scenario
      280          announced pledges scenario
      281          announced pledges scenario
      282          announced pledges scenario
      283          announced pledges scenario
      284          announced pledges scenario
      285          announced pledges scenario
      286          announced pledges scenario
      287          announced pledges scenario
      288          announced pledges scenario
      289          announced pledges scenario
      290          announced pledges scenario
      291          announced pledges scenario
      292          announced pledges scenario
      293          announced pledges scenario
      294          announced pledges scenario
      295          announced pledges scenario
      296          announced pledges scenario
      297          announced pledges scenario
      298          announced pledges scenario
      299          announced pledges scenario
      300          announced pledges scenario
      301          announced pledges scenario
      302          announced pledges scenario
      303          announced pledges scenario
      304          announced pledges scenario
      305          announced pledges scenario
      306          announced pledges scenario
      307          announced pledges scenario
      308          announced pledges scenario
      309          announced pledges scenario
      310          announced pledges scenario
      311          announced pledges scenario
      312          announced pledges scenario
      313          announced pledges scenario
      314          announced pledges scenario
      315          announced pledges scenario
      316          announced pledges scenario
      317          announced pledges scenario
      318          announced pledges scenario
      319          announced pledges scenario
      320          announced pledges scenario
      321          announced pledges scenario
      322          announced pledges scenario
      323          announced pledges scenario
      324          announced pledges scenario
      325          announced pledges scenario
      326          announced pledges scenario
      327          announced pledges scenario
      328          announced pledges scenario
      329          announced pledges scenario
      330          announced pledges scenario
      331          announced pledges scenario
      332          announced pledges scenario
      333          announced pledges scenario
      334          announced pledges scenario
      335          announced pledges scenario
      336          announced pledges scenario
      337          announced pledges scenario
      338          announced pledges scenario
      339          announced pledges scenario
      340          announced pledges scenario
      341          announced pledges scenario
      342          announced pledges scenario
      343          announced pledges scenario
      344          announced pledges scenario
      345          announced pledges scenario
      346          announced pledges scenario
      347          announced pledges scenario
      348          announced pledges scenario
      349          announced pledges scenario
      350          announced pledges scenario
      351          announced pledges scenario
      352          announced pledges scenario
      353          announced pledges scenario
      354          announced pledges scenario
      355          announced pledges scenario
      356          announced pledges scenario
      357          announced pledges scenario
      358          announced pledges scenario
      359          announced pledges scenario
      360          announced pledges scenario
      361 net zero emissions by 2050 scenario
      362 net zero emissions by 2050 scenario
      363 net zero emissions by 2050 scenario
      364 net zero emissions by 2050 scenario
      365 net zero emissions by 2050 scenario
      366 net zero emissions by 2050 scenario
      367 net zero emissions by 2050 scenario
      368 net zero emissions by 2050 scenario
      369 net zero emissions by 2050 scenario
      370 net zero emissions by 2050 scenario
      371 net zero emissions by 2050 scenario
      372 net zero emissions by 2050 scenario
      373 net zero emissions by 2050 scenario
      374 net zero emissions by 2050 scenario
      375 net zero emissions by 2050 scenario
      376 net zero emissions by 2050 scenario
      377 net zero emissions by 2050 scenario
      378 net zero emissions by 2050 scenario
      379 net zero emissions by 2050 scenario
      380 net zero emissions by 2050 scenario
      381 net zero emissions by 2050 scenario
      382 net zero emissions by 2050 scenario
      383 net zero emissions by 2050 scenario
      384 net zero emissions by 2050 scenario
      385 net zero emissions by 2050 scenario
      386 net zero emissions by 2050 scenario
      387 net zero emissions by 2050 scenario
      388 net zero emissions by 2050 scenario
      389 net zero emissions by 2050 scenario
      390 net zero emissions by 2050 scenario
      391 net zero emissions by 2050 scenario
      392 net zero emissions by 2050 scenario
      393 net zero emissions by 2050 scenario
      394 net zero emissions by 2050 scenario
      395 net zero emissions by 2050 scenario
      396 net zero emissions by 2050 scenario
      397 net zero emissions by 2050 scenario
      398 net zero emissions by 2050 scenario
      399 net zero emissions by 2050 scenario
      400 net zero emissions by 2050 scenario
      401 net zero emissions by 2050 scenario
      402 net zero emissions by 2050 scenario
      403 net zero emissions by 2050 scenario
      404 net zero emissions by 2050 scenario
      405 net zero emissions by 2050 scenario
      406 net zero emissions by 2050 scenario
      407 net zero emissions by 2050 scenario
      408 net zero emissions by 2050 scenario
      409 net zero emissions by 2050 scenario
      410 net zero emissions by 2050 scenario
      411 net zero emissions by 2050 scenario
      412 net zero emissions by 2050 scenario
      413 net zero emissions by 2050 scenario
      414 net zero emissions by 2050 scenario
      415 net zero emissions by 2050 scenario
      416 net zero emissions by 2050 scenario
      417 net zero emissions by 2050 scenario
      418 net zero emissions by 2050 scenario
      419 net zero emissions by 2050 scenario
      420 net zero emissions by 2050 scenario
      421 net zero emissions by 2050 scenario
      422 net zero emissions by 2050 scenario
      423 net zero emissions by 2050 scenario
      424 net zero emissions by 2050 scenario
      425 net zero emissions by 2050 scenario
      426 net zero emissions by 2050 scenario
      427 net zero emissions by 2050 scenario
      428 net zero emissions by 2050 scenario
      429 net zero emissions by 2050 scenario
      430 net zero emissions by 2050 scenario
      431 net zero emissions by 2050 scenario
      432 net zero emissions by 2050 scenario
      433 net zero emissions by 2050 scenario
      434 net zero emissions by 2050 scenario
      435 net zero emissions by 2050 scenario
      436 net zero emissions by 2050 scenario
      437 net zero emissions by 2050 scenario
      438 net zero emissions by 2050 scenario
      439 net zero emissions by 2050 scenario
      440 net zero emissions by 2050 scenario
      441 net zero emissions by 2050 scenario
      442 net zero emissions by 2050 scenario
      443 net zero emissions by 2050 scenario
      444 net zero emissions by 2050 scenario
      445 net zero emissions by 2050 scenario
      446 net zero emissions by 2050 scenario
      447 net zero emissions by 2050 scenario
      448 net zero emissions by 2050 scenario
      449 net zero emissions by 2050 scenario
      450 net zero emissions by 2050 scenario
      451 net zero emissions by 2050 scenario
      452 net zero emissions by 2050 scenario
      453 net zero emissions by 2050 scenario
      454 net zero emissions by 2050 scenario
      455 net zero emissions by 2050 scenario
      456 net zero emissions by 2050 scenario
      457 net zero emissions by 2050 scenario
      458 net zero emissions by 2050 scenario
      459 net zero emissions by 2050 scenario
      460 net zero emissions by 2050 scenario
      461 net zero emissions by 2050 scenario
      462 net zero emissions by 2050 scenario
      463 net zero emissions by 2050 scenario
      464 net zero emissions by 2050 scenario
      465 net zero emissions by 2050 scenario
      466 net zero emissions by 2050 scenario
      467 net zero emissions by 2050 scenario
      468 net zero emissions by 2050 scenario
      469 net zero emissions by 2050 scenario
      470 net zero emissions by 2050 scenario
      471 net zero emissions by 2050 scenario
      472 net zero emissions by 2050 scenario
      473 net zero emissions by 2050 scenario
      474 net zero emissions by 2050 scenario
      475 net zero emissions by 2050 scenario
      476 net zero emissions by 2050 scenario
      477 net zero emissions by 2050 scenario
      478 net zero emissions by 2050 scenario
      479 net zero emissions by 2050 scenario
      480 net zero emissions by 2050 scenario
      481 net zero emissions by 2050 scenario
      482 net zero emissions by 2050 scenario
      483 net zero emissions by 2050 scenario
      484 net zero emissions by 2050 scenario
      
      [[2]]
                        region
      1   western europe (weu)
      2   western europe (weu)
      3   western europe (weu)
      4   western europe (weu)
      5   western europe (weu)
      6   western europe (weu)
      7   western europe (weu)
      8   western europe (weu)
      9   western europe (weu)
      10  western europe (weu)
      11  western europe (weu)
      12  western europe (weu)
      13  western europe (weu)
      14  western europe (weu)
      15  western europe (weu)
      16  western europe (weu)
      17  western europe (weu)
      18  western europe (weu)
      19  western europe (weu)
      20  western europe (weu)
      21  western europe (weu)
      22  western europe (weu)
      23  western europe (weu)
      24  western europe (weu)
      25  western europe (weu)
      26  western europe (weu)
      27  western europe (weu)
      28  western europe (weu)
      29  western europe (weu)
      30  western europe (weu)
      31  western europe (weu)
      32  western europe (weu)
      33  western europe (weu)
      34  western europe (weu)
      35  western europe (weu)
      36  western europe (weu)
      37  western europe (weu)
      38  western europe (weu)
      39  western europe (weu)
      40  western europe (weu)
      41  western europe (weu)
      42  western europe (weu)
      43  western europe (weu)
      44  western europe (weu)
      45  western europe (weu)
      46  western europe (weu)
      47  western europe (weu)
      48  western europe (weu)
      49  western europe (weu)
      50  western europe (weu)
      51  western europe (weu)
      52  western europe (weu)
      53                 world
      54                 world
      55                 world
      56                 world
      57                 world
      58                 world
      59                 world
      60                 world
      61                 world
      62                 world
      63                 world
      64                 world
      65                 world
      66                 world
      67                 world
      68                 world
      69                 world
      70                 world
      71                 world
      72                 world
      73                 world
      74                 world
      75                 world
      76                 world
      77                 world
      78                 world
      79                 world
      80                 world
      81                 world
      82                 world
      83                 world
      84                 world
      85                 world
      86                 world
      87                 world
      88                 world
      89                 world
      90                 world
      91                 world
      92                 world
      93                 world
      94                 world
      95                 world
      96                 world
      97                 world
      98                 world
      99                 world
      100                world
      101                world
      102                world
      103                world
      104                world
      105                world
      106                world
      107                world
      108                world
      109                world
      110                world
      111                world
      112                world
      113                world
      114                world
      115                world
      116                world
      117                world
      118                world
      119                world
      120                world
      121                world
      122                world
      123                world
      124                world
      125                world
      126                world
      127                world
      128                world
      129                world
      130                world
      131                world
      132                world
      133                world
      134                world
      135                world
      136                world
      137                world
      138                world
      139                world
      140                world
      141                world
      142                world
      143                world
      144                world
      145                world
      146                world
      147                world
      148                world
      149                world
      150                world
      151                world
      152                world
      153                world
      154                world
      155                world
      156                world
      157                world
      158                world
      159                world
      160                world
      161                world
      162                world
      163                world
      164                world
      165                world
      166                world
      167                world
      168                world
      169                world
      170                world
      171                world
      172                world
      173                world
      174                world
      175                world
      176                world
      177                world
      178                world
      179                world
      180                world
      181                world
      182                world
      183                world
      184                world
      185                world
      186                world
      187                world
      188                world
      189                world
      190                world
      191                world
      192                world
      193                world
      194                world
      195                world
      196                world
      197                world
      198                world
      199                world
      200                world
      201                world
      202                world
      203                world
      204                world
      205                world
      206                world
      207                world
      208                world
      209                world
      210                world
      211                world
      212                world
      213                world
      214                world
      215                world
      216                world
      217                world
      218                world
      219                world
      220                world
      221                world
      222                world
      223                world
      224                world
      225                world
      226                world
      227                world
      228                world
      229                world
      230                world
      231                world
      232                world
      233                world
      234                world
      235                world
      236                world
      237                world
      238                world
      239                world
      240                world
      241                world
      242                world
      243                world
      244                world
      245                world
      246                world
      247                world
      248                world
      249                world
      250                world
      251                world
      252                world
      253                world
      254                world
      255                world
      256                world
      257                world
      258                world
      259                world
      260                world
      261                world
      262                world
      263                world
      264                world
      265                world
      266                world
      267                world
      268                world
      269                world
      270                world
      271                world
      272                world
      273                world
      274                world
      275                world
      276                world
      277                world
      278                world
      279                world
      280                world
      281                world
      282                world
      283                world
      284                world
      285                world
      286                world
      287                world
      288                world
      289                world
      290                world
      291                world
      292                world
      293                world
      294                world
      295                world
      296                world
      297                world
      298                world
      299                world
      300                world
      301                world
      302                world
      303                world
      304                world
      305                world
      306                world
      307                world
      308                world
      309                world
      310                world
      311                world
      312                world
      313                world
      314                world
      315                world
      316                world
      317                world
      318                world
      319                world
      320                world
      321                world
      322                world
      323                world
      324                world
      325                world
      326                world
      327                world
      328                world
      329                world
      330                world
      331                world
      332                world
      333                world
      334                world
      335                world
      336                world
      337                world
      338                world
      339                world
      340                world
      341                world
      342                world
      343                world
      344                world
      345                world
      346                world
      347                world
      348                world
      349                world
      350                world
      351                world
      352                world
      353                world
      354                world
      355                world
      356                world
      357                world
      358                world
      359                world
      360                world
      361                world
      362                world
      363                world
      364                world
      365                world
      366                world
      367                world
      368                world
      369                world
      370                world
      371                world
      372                world
      373                world
      374                world
      375                world
      376                world
      377                world
      378                world
      379                world
      380                world
      381                world
      382                world
      383                world
      384                world
      385                world
      386                world
      387                world
      388                world
      389                world
      390                world
      391                world
      392                world
      393                world
      394                world
      395                world
      396                world
      397                world
      398                world
      399                world
      400                world
      401                world
      402                world
      403                world
      404                world
      405                world
      406                world
      407                world
      408                world
      409                world
      410                world
      411                world
      412                world
      413                world
      414                world
      415                world
      416                world
      417                world
      418                world
      419                world
      420                world
      421                world
      422                world
      423                world
      424                world
      425                world
      426                world
      427                world
      428                world
      429                world
      430                world
      431                world
      432                world
      433                world
      434                world
      435                world
      436                world
      437                world
      438                world
      439                world
      440                world
      441                world
      442                world
      443                world
      444                world
      445                world
      446                world
      447                world
      448                world
      449                world
      450                world
      451                world
      452                world
      453                world
      454                world
      455                world
      456                world
      457                world
      458                world
      459                world
      460                world
      461                world
      462                world
      463                world
      464                world
      465                world
      466                world
      467                world
      468                world
      469                world
      470                world
      471                world
      472                world
      473                world
      474                world
      475                world
      476                world
      477                world
      478                world
      479                world
      480                world
      481                world
      482                world
      483                world
      484                world
      
      [[3]]
                       sector
      1                 power
      2                 power
      3                 power
      4                 power
      5             buildings
      6             buildings
      7             buildings
      8             buildings
      9              industry
      10             industry
      11             industry
      12             industry
      13             industry
      14             industry
      15             industry
      16             industry
      17             industry
      18             industry
      19             industry
      20             industry
      21             industry
      22             industry
      23             industry
      24             industry
      25            transport
      26            transport
      27            transport
      28            transport
      29            transport
      30            transport
      31            transport
      32            transport
      33            transport
      34            transport
      35            transport
      36            transport
      37            transport
      38            transport
      39            transport
      40            transport
      41            transport
      42            transport
      43            transport
      44            transport
      45         other energy
      46         other energy
      47         other energy
      48         other energy
      49                total
      50                total
      51                total
      52                total
      53                 <NA>
      54                 <NA>
      55                 <NA>
      56                 <NA>
      57                power
      58                power
      59                power
      60                power
      61            buildings
      62            buildings
      63            buildings
      64            buildings
      65             industry
      66             industry
      67             industry
      68             industry
      69             industry
      70             industry
      71             industry
      72             industry
      73             industry
      74             industry
      75             industry
      76             industry
      77             industry
      78             industry
      79             industry
      80             industry
      81            transport
      82            transport
      83            transport
      84            transport
      85            transport
      86            transport
      87            transport
      88            transport
      89            transport
      90            transport
      91            transport
      92            transport
      93            transport
      94            transport
      95            transport
      96            transport
      97            transport
      98            transport
      99            transport
      100           transport
      101        other energy
      102        other energy
      103        other energy
      104        other energy
      105               total
      106               total
      107               total
      108               total
      109                <NA>
      110                <NA>
      111                <NA>
      112                <NA>
      113               total
      114               total
      115               total
      116               total
      117                coal
      118                coal
      119                coal
      120                coal
      121                 oil
      122                 oil
      123                 oil
      124                 oil
      125         natural gas
      126         natural gas
      127         natural gas
      128         natural gas
      129 bioenergy and waste
      130 bioenergy and waste
      131 bioenergy and waste
      132 bioenergy and waste
      133               total
      134               total
      135               total
      136               total
      137               total
      138               total
      139               total
      140               total
      141                coal
      142                coal
      143                coal
      144                coal
      145                 oil
      146                 oil
      147                 oil
      148                 oil
      149         natural gas
      150         natural gas
      151         natural gas
      152         natural gas
      153 bioenergy and waste
      154 bioenergy and waste
      155 bioenergy and waste
      156 bioenergy and waste
      157               total
      158               total
      159               total
      160               total
      161               total
      162               total
      163               total
      164               total
      165                coal
      166                coal
      167                coal
      168                coal
      169                 oil
      170                 oil
      171                 oil
      172                 oil
      173         natural gas
      174         natural gas
      175         natural gas
      176         natural gas
      177 bioenergy and waste
      178 bioenergy and waste
      179 bioenergy and waste
      180 bioenergy and waste
      181               total
      182               total
      183               total
      184               total
      185               total
      186               total
      187               total
      188               total
      189               total
      190               total
      191               total
      192               total
      193               total
      194               total
      195               total
      196               total
      197               total
      198               total
      199               total
      200               total
      201               total
      202               total
      203               total
      204               total
      205               total
      206               total
      207               total
      208               total
      209               total
      210               total
      211               total
      212               total
      213               total
      214               total
      215               total
      216               total
      217               total
      218               total
      219               total
      220               total
      221               total
      222               total
      223               total
      224               total
      225               total
      226               total
      227               total
      228               total
      229               total
      230               total
      231               total
      232               total
      233               total
      234               total
      235               total
      236               total
      237               total
      238               total
      239               total
      240               total
      241                coal
      242                coal
      243                coal
      244                coal
      245                 oil
      246                 oil
      247                 oil
      248                 oil
      249         natural gas
      250         natural gas
      251         natural gas
      252         natural gas
      253 bioenergy and waste
      254 bioenergy and waste
      255 bioenergy and waste
      256 bioenergy and waste
      257               total
      258               total
      259               total
      260               total
      261               total
      262               total
      263               total
      264               total
      265                coal
      266                coal
      267                coal
      268                coal
      269                 oil
      270                 oil
      271                 oil
      272                 oil
      273         natural gas
      274         natural gas
      275         natural gas
      276         natural gas
      277 bioenergy and waste
      278 bioenergy and waste
      279 bioenergy and waste
      280 bioenergy and waste
      281               total
      282               total
      283               total
      284               total
      285               total
      286               total
      287               total
      288               total
      289                coal
      290                coal
      291                coal
      292                coal
      293                 oil
      294                 oil
      295                 oil
      296                 oil
      297         natural gas
      298         natural gas
      299         natural gas
      300         natural gas
      301 bioenergy and waste
      302 bioenergy and waste
      303 bioenergy and waste
      304 bioenergy and waste
      305               total
      306               total
      307               total
      308               total
      309               total
      310               total
      311               total
      312               total
      313               total
      314               total
      315               total
      316               total
      317               total
      318               total
      319               total
      320               total
      321               total
      322               total
      323               total
      324               total
      325               total
      326               total
      327               total
      328               total
      329               total
      330               total
      331               total
      332               total
      333               total
      334               total
      335               total
      336               total
      337               total
      338               total
      339               total
      340               total
      341               total
      342               total
      343               total
      344               total
      345               total
      346               total
      347               total
      348               total
      349               total
      350               total
      351               total
      352               total
      353               total
      354               total
      355               total
      356               total
      357               total
      358               total
      359               total
      360               total
      361               total
      362               total
      363               total
      364               total
      365                coal
      366                coal
      367                coal
      368                coal
      369                 oil
      370                 oil
      371                 oil
      372                 oil
      373         natural gas
      374         natural gas
      375         natural gas
      376         natural gas
      377 bioenergy and waste
      378 bioenergy and waste
      379 bioenergy and waste
      380 bioenergy and waste
      381               total
      382               total
      383               total
      384               total
      385               total
      386               total
      387               total
      388               total
      389                coal
      390                coal
      391                coal
      392                coal
      393                 oil
      394                 oil
      395                 oil
      396                 oil
      397         natural gas
      398         natural gas
      399         natural gas
      400         natural gas
      401 bioenergy and waste
      402 bioenergy and waste
      403 bioenergy and waste
      404 bioenergy and waste
      405               total
      406               total
      407               total
      408               total
      409               total
      410               total
      411               total
      412               total
      413                coal
      414                coal
      415                coal
      416                coal
      417                 oil
      418                 oil
      419                 oil
      420                 oil
      421         natural gas
      422         natural gas
      423         natural gas
      424         natural gas
      425 bioenergy and waste
      426 bioenergy and waste
      427 bioenergy and waste
      428 bioenergy and waste
      429               total
      430               total
      431               total
      432               total
      433               total
      434               total
      435               total
      436               total
      437               total
      438               total
      439               total
      440               total
      441               total
      442               total
      443               total
      444               total
      445               total
      446               total
      447               total
      448               total
      449               total
      450               total
      451               total
      452               total
      453               total
      454               total
      455               total
      456               total
      457               total
      458               total
      459               total
      460               total
      461               total
      462               total
      463               total
      464               total
      465               total
      466               total
      467               total
      468               total
      469               total
      470               total
      471               total
      472               total
      473               total
      474               total
      475               total
      476               total
      477               total
      478               total
      479               total
      480               total
      481               total
      482               total
      483               total
      484               total
      
      [[4]]
                                           subsector
      1                                         <NA>
      2                                         <NA>
      3                                         <NA>
      4                                         <NA>
      5                                         <NA>
      6                                         <NA>
      7                                         <NA>
      8                                         <NA>
      9                               iron and steel
      10                              iron and steel
      11                              iron and steel
      12                              iron and steel
      13                       non-metallic minerals
      14                       non-metallic minerals
      15                       non-metallic minerals
      16                       non-metallic minerals
      17                                   chemicals
      18                                   chemicals
      19                                   chemicals
      20                                   chemicals
      21                              other industry
      22                              other industry
      23                              other industry
      24                              other industry
      25                                        cars
      26                                        cars
      27                                        cars
      28                                        cars
      29                                      trucks
      30                                      trucks
      31                                      trucks
      32                                      trucks
      33                                    aviation
      34                                    aviation
      35                                    aviation
      36                                    aviation
      37                                    shipping
      38                                    shipping
      39                                    shipping
      40                                    shipping
      41                             other transport
      42                             other transport
      43                             other transport
      44                             other transport
      45                                        <NA>
      46                                        <NA>
      47                                        <NA>
      48                                        <NA>
      49                                      energy
      50                                      energy
      51                                      energy
      52                                      energy
      53                                    land use
      54                                    land use
      55                                    land use
      56                                    land use
      57                                        <NA>
      58                                        <NA>
      59                                        <NA>
      60                                        <NA>
      61                                        <NA>
      62                                        <NA>
      63                                        <NA>
      64                                        <NA>
      65                              iron and steel
      66                              iron and steel
      67                              iron and steel
      68                              iron and steel
      69                       non-metallic minerals
      70                       non-metallic minerals
      71                       non-metallic minerals
      72                       non-metallic minerals
      73                                   chemicals
      74                                   chemicals
      75                                   chemicals
      76                                   chemicals
      77                              other industry
      78                              other industry
      79                              other industry
      80                              other industry
      81                                        cars
      82                                        cars
      83                                        cars
      84                                        cars
      85                                      trucks
      86                                      trucks
      87                                      trucks
      88                                      trucks
      89                                    aviation
      90                                    aviation
      91                                    aviation
      92                                    aviation
      93                                    shipping
      94                                    shipping
      95                                    shipping
      96                                    shipping
      97                             other transport
      98                             other transport
      99                             other transport
      100                            other transport
      101                                       <NA>
      102                                       <NA>
      103                                       <NA>
      104                                       <NA>
      105                                     energy
      106                                     energy
      107                                     energy
      108                                     energy
      109                                   land use
      110                                   land use
      111                                   land use
      112                                   land use
      113                        total energy supply
      114                        total energy supply
      115                        total energy supply
      116                        total energy supply
      117                        total energy supply
      118                        total energy supply
      119                        total energy supply
      120                        total energy supply
      121                        total energy supply
      122                        total energy supply
      123                        total energy supply
      124                        total energy supply
      125                        total energy supply
      126                        total energy supply
      127                        total energy supply
      128                        total energy supply
      129                        total energy supply
      130                        total energy supply
      131                        total energy supply
      132                        total energy supply
      133 biofuels production and direct air capture
      134 biofuels production and direct air capture
      135 biofuels production and direct air capture
      136 biofuels production and direct air capture
      137                        power sector inputs
      138                        power sector inputs
      139                        power sector inputs
      140                        power sector inputs
      141                        power sector inputs
      142                        power sector inputs
      143                        power sector inputs
      144                        power sector inputs
      145                        power sector inputs
      146                        power sector inputs
      147                        power sector inputs
      148                        power sector inputs
      149                        power sector inputs
      150                        power sector inputs
      151                        power sector inputs
      152                        power sector inputs
      153                        power sector inputs
      154                        power sector inputs
      155                        power sector inputs
      156                        power sector inputs
      157                        other energy sector
      158                        other energy sector
      159                        other energy sector
      160                        other energy sector
      161                    total final consumption
      162                    total final consumption
      163                    total final consumption
      164                    total final consumption
      165                    total final consumption
      166                    total final consumption
      167                    total final consumption
      168                    total final consumption
      169                    total final consumption
      170                    total final consumption
      171                    total final consumption
      172                    total final consumption
      173                    total final consumption
      174                    total final consumption
      175                    total final consumption
      176                    total final consumption
      177                    total final consumption
      178                    total final consumption
      179                    total final consumption
      180                    total final consumption
      181                                   industry
      182                                   industry
      183                                   industry
      184                                   industry
      185                             iron and steel
      186                             iron and steel
      187                             iron and steel
      188                             iron and steel
      189                                  chemicals
      190                                  chemicals
      191                                  chemicals
      192                                  chemicals
      193              non-metallic minerals: cement
      194              non-metallic minerals: cement
      195              non-metallic minerals: cement
      196              non-metallic minerals: cement
      197                                  transport
      198                                  transport
      199                                  transport
      200                                  transport
      201                                       road
      202                                       road
      203                                       road
      204                                       road
      205          road passenger light duty vehicle
      206          road passenger light duty vehicle
      207          road passenger light duty vehicle
      208          road passenger light duty vehicle
      209                     road heavy-duty trucks
      210                     road heavy-duty trucks
      211                     road heavy-duty trucks
      212                     road heavy-duty trucks
      213      total aviation (domestic and bunkers)
      214      total aviation (domestic and bunkers)
      215      total aviation (domestic and bunkers)
      216      total aviation (domestic and bunkers)
      217    total navigation (domestic and bunkers)
      218    total navigation (domestic and bunkers)
      219    total navigation (domestic and bunkers)
      220    total navigation (domestic and bunkers)
      221                                  buildings
      222                                  buildings
      223                                  buildings
      224                                  buildings
      225                                residential
      226                                residential
      227                                residential
      228                                residential
      229                                   services
      230                                   services
      231                                   services
      232                                   services
      233                        total energy supply
      234                        total energy supply
      235                        total energy supply
      236                        total energy supply
      237                        total energy supply
      238                        total energy supply
      239                        total energy supply
      240                        total energy supply
      241                        total energy supply
      242                        total energy supply
      243                        total energy supply
      244                        total energy supply
      245                        total energy supply
      246                        total energy supply
      247                        total energy supply
      248                        total energy supply
      249                        total energy supply
      250                        total energy supply
      251                        total energy supply
      252                        total energy supply
      253                        total energy supply
      254                        total energy supply
      255                        total energy supply
      256                        total energy supply
      257 biofuels production and direct air capture
      258 biofuels production and direct air capture
      259 biofuels production and direct air capture
      260 biofuels production and direct air capture
      261                        power sector inputs
      262                        power sector inputs
      263                        power sector inputs
      264                        power sector inputs
      265                        power sector inputs
      266                        power sector inputs
      267                        power sector inputs
      268                        power sector inputs
      269                        power sector inputs
      270                        power sector inputs
      271                        power sector inputs
      272                        power sector inputs
      273                        power sector inputs
      274                        power sector inputs
      275                        power sector inputs
      276                        power sector inputs
      277                        power sector inputs
      278                        power sector inputs
      279                        power sector inputs
      280                        power sector inputs
      281                        other energy sector
      282                        other energy sector
      283                        other energy sector
      284                        other energy sector
      285                    total final consumption
      286                    total final consumption
      287                    total final consumption
      288                    total final consumption
      289                    total final consumption
      290                    total final consumption
      291                    total final consumption
      292                    total final consumption
      293                    total final consumption
      294                    total final consumption
      295                    total final consumption
      296                    total final consumption
      297                    total final consumption
      298                    total final consumption
      299                    total final consumption
      300                    total final consumption
      301                    total final consumption
      302                    total final consumption
      303                    total final consumption
      304                    total final consumption
      305                                   industry
      306                                   industry
      307                                   industry
      308                                   industry
      309                             iron and steel
      310                             iron and steel
      311                             iron and steel
      312                             iron and steel
      313                                  chemicals
      314                                  chemicals
      315                                  chemicals
      316                                  chemicals
      317              non-metallic minerals: cement
      318              non-metallic minerals: cement
      319              non-metallic minerals: cement
      320              non-metallic minerals: cement
      321                                  transport
      322                                  transport
      323                                  transport
      324                                  transport
      325                                       road
      326                                       road
      327                                       road
      328                                       road
      329          road passenger light duty vehicle
      330          road passenger light duty vehicle
      331          road passenger light duty vehicle
      332          road passenger light duty vehicle
      333                     road heavy-duty trucks
      334                     road heavy-duty trucks
      335                     road heavy-duty trucks
      336                     road heavy-duty trucks
      337      total aviation (domestic and bunkers)
      338      total aviation (domestic and bunkers)
      339      total aviation (domestic and bunkers)
      340      total aviation (domestic and bunkers)
      341    total navigation (domestic and bunkers)
      342    total navigation (domestic and bunkers)
      343    total navigation (domestic and bunkers)
      344    total navigation (domestic and bunkers)
      345                                  buildings
      346                                  buildings
      347                                  buildings
      348                                  buildings
      349                                residential
      350                                residential
      351                                residential
      352                                residential
      353                                   services
      354                                   services
      355                                   services
      356                                   services
      357                        total energy supply
      358                        total energy supply
      359                        total energy supply
      360                        total energy supply
      361                        total energy supply
      362                        total energy supply
      363                        total energy supply
      364                        total energy supply
      365                        total energy supply
      366                        total energy supply
      367                        total energy supply
      368                        total energy supply
      369                        total energy supply
      370                        total energy supply
      371                        total energy supply
      372                        total energy supply
      373                        total energy supply
      374                        total energy supply
      375                        total energy supply
      376                        total energy supply
      377                        total energy supply
      378                        total energy supply
      379                        total energy supply
      380                        total energy supply
      381 biofuels production and direct air capture
      382 biofuels production and direct air capture
      383 biofuels production and direct air capture
      384 biofuels production and direct air capture
      385                        power sector inputs
      386                        power sector inputs
      387                        power sector inputs
      388                        power sector inputs
      389                        power sector inputs
      390                        power sector inputs
      391                        power sector inputs
      392                        power sector inputs
      393                        power sector inputs
      394                        power sector inputs
      395                        power sector inputs
      396                        power sector inputs
      397                        power sector inputs
      398                        power sector inputs
      399                        power sector inputs
      400                        power sector inputs
      401                        power sector inputs
      402                        power sector inputs
      403                        power sector inputs
      404                        power sector inputs
      405                        other energy sector
      406                        other energy sector
      407                        other energy sector
      408                        other energy sector
      409                    total final consumption
      410                    total final consumption
      411                    total final consumption
      412                    total final consumption
      413                    total final consumption
      414                    total final consumption
      415                    total final consumption
      416                    total final consumption
      417                    total final consumption
      418                    total final consumption
      419                    total final consumption
      420                    total final consumption
      421                    total final consumption
      422                    total final consumption
      423                    total final consumption
      424                    total final consumption
      425                    total final consumption
      426                    total final consumption
      427                    total final consumption
      428                    total final consumption
      429                                   industry
      430                                   industry
      431                                   industry
      432                                   industry
      433                             iron and steel
      434                             iron and steel
      435                             iron and steel
      436                             iron and steel
      437                                  chemicals
      438                                  chemicals
      439                                  chemicals
      440                                  chemicals
      441              non-metallic minerals: cement
      442              non-metallic minerals: cement
      443              non-metallic minerals: cement
      444              non-metallic minerals: cement
      445                                  transport
      446                                  transport
      447                                  transport
      448                                  transport
      449                                       road
      450                                       road
      451                                       road
      452                                       road
      453          road passenger light duty vehicle
      454          road passenger light duty vehicle
      455          road passenger light duty vehicle
      456          road passenger light duty vehicle
      457                     road heavy-duty trucks
      458                     road heavy-duty trucks
      459                     road heavy-duty trucks
      460                     road heavy-duty trucks
      461      total aviation (domestic and bunkers)
      462      total aviation (domestic and bunkers)
      463      total aviation (domestic and bunkers)
      464      total aviation (domestic and bunkers)
      465    total navigation (domestic and bunkers)
      466    total navigation (domestic and bunkers)
      467    total navigation (domestic and bunkers)
      468    total navigation (domestic and bunkers)
      469                                  buildings
      470                                  buildings
      471                                  buildings
      472                                  buildings
      473                                residential
      474                                residential
      475                                residential
      476                                residential
      477                                   services
      478                                   services
      479                                   services
      480                                   services
      481                        total energy supply
      482                        total energy supply
      483                        total energy supply
      484                        total energy supply
      
      [[5]]
          year
      1   2020
      2   2030
      3   2040
      4   2050
      5   2020
      6   2030
      7   2040
      8   2050
      9   2020
      10  2030
      11  2040
      12  2050
      13  2020
      14  2030
      15  2040
      16  2050
      17  2020
      18  2030
      19  2040
      20  2050
      21  2020
      22  2030
      23  2040
      24  2050
      25  2020
      26  2030
      27  2040
      28  2050
      29  2020
      30  2030
      31  2040
      32  2050
      33  2020
      34  2030
      35  2040
      36  2050
      37  2020
      38  2030
      39  2040
      40  2050
      41  2020
      42  2030
      43  2040
      44  2050
      45  2020
      46  2030
      47  2040
      48  2050
      49  2020
      50  2030
      51  2040
      52  2050
      53  2020
      54  2030
      55  2040
      56  2050
      57  2020
      58  2030
      59  2040
      60  2050
      61  2020
      62  2030
      63  2040
      64  2050
      65  2020
      66  2030
      67  2040
      68  2050
      69  2020
      70  2030
      71  2040
      72  2050
      73  2020
      74  2030
      75  2040
      76  2050
      77  2020
      78  2030
      79  2040
      80  2050
      81  2020
      82  2030
      83  2040
      84  2050
      85  2020
      86  2030
      87  2040
      88  2050
      89  2020
      90  2030
      91  2040
      92  2050
      93  2020
      94  2030
      95  2040
      96  2050
      97  2020
      98  2030
      99  2040
      100 2050
      101 2020
      102 2030
      103 2040
      104 2050
      105 2020
      106 2030
      107 2040
      108 2050
      109 2020
      110 2030
      111 2040
      112 2050
      113 2020
      114 2030
      115 2040
      116 2050
      117 2020
      118 2030
      119 2040
      120 2050
      121 2020
      122 2030
      123 2040
      124 2050
      125 2020
      126 2030
      127 2040
      128 2050
      129 2020
      130 2030
      131 2040
      132 2050
      133 2020
      134 2030
      135 2040
      136 2050
      137 2020
      138 2030
      139 2040
      140 2050
      141 2020
      142 2030
      143 2040
      144 2050
      145 2020
      146 2030
      147 2040
      148 2050
      149 2020
      150 2030
      151 2040
      152 2050
      153 2020
      154 2030
      155 2040
      156 2050
      157 2020
      158 2030
      159 2040
      160 2050
      161 2020
      162 2030
      163 2040
      164 2050
      165 2020
      166 2030
      167 2040
      168 2050
      169 2020
      170 2030
      171 2040
      172 2050
      173 2020
      174 2030
      175 2040
      176 2050
      177 2020
      178 2030
      179 2040
      180 2050
      181 2020
      182 2030
      183 2040
      184 2050
      185 2020
      186 2030
      187 2040
      188 2050
      189 2020
      190 2030
      191 2040
      192 2050
      193 2020
      194 2030
      195 2040
      196 2050
      197 2020
      198 2030
      199 2040
      200 2050
      201 2020
      202 2030
      203 2040
      204 2050
      205 2020
      206 2030
      207 2040
      208 2050
      209 2020
      210 2030
      211 2040
      212 2050
      213 2020
      214 2030
      215 2040
      216 2050
      217 2020
      218 2030
      219 2040
      220 2050
      221 2020
      222 2030
      223 2040
      224 2050
      225 2020
      226 2030
      227 2040
      228 2050
      229 2020
      230 2030
      231 2040
      232 2050
      233 2020
      234 2030
      235 2040
      236 2050
      237 2020
      238 2030
      239 2040
      240 2050
      241 2020
      242 2030
      243 2040
      244 2050
      245 2020
      246 2030
      247 2040
      248 2050
      249 2020
      250 2030
      251 2040
      252 2050
      253 2020
      254 2030
      255 2040
      256 2050
      257 2020
      258 2030
      259 2040
      260 2050
      261 2020
      262 2030
      263 2040
      264 2050
      265 2020
      266 2030
      267 2040
      268 2050
      269 2020
      270 2030
      271 2040
      272 2050
      273 2020
      274 2030
      275 2040
      276 2050
      277 2020
      278 2030
      279 2040
      280 2050
      281 2020
      282 2030
      283 2040
      284 2050
      285 2020
      286 2030
      287 2040
      288 2050
      289 2020
      290 2030
      291 2040
      292 2050
      293 2020
      294 2030
      295 2040
      296 2050
      297 2020
      298 2030
      299 2040
      300 2050
      301 2020
      302 2030
      303 2040
      304 2050
      305 2020
      306 2030
      307 2040
      308 2050
      309 2020
      310 2030
      311 2040
      312 2050
      313 2020
      314 2030
      315 2040
      316 2050
      317 2020
      318 2030
      319 2040
      320 2050
      321 2020
      322 2030
      323 2040
      324 2050
      325 2020
      326 2030
      327 2040
      328 2050
      329 2020
      330 2030
      331 2040
      332 2050
      333 2020
      334 2030
      335 2040
      336 2050
      337 2020
      338 2030
      339 2040
      340 2050
      341 2020
      342 2030
      343 2040
      344 2050
      345 2020
      346 2030
      347 2040
      348 2050
      349 2020
      350 2030
      351 2040
      352 2050
      353 2020
      354 2030
      355 2040
      356 2050
      357 2020
      358 2030
      359 2040
      360 2050
      361 2020
      362 2030
      363 2040
      364 2050
      365 2020
      366 2030
      367 2040
      368 2050
      369 2020
      370 2030
      371 2040
      372 2050
      373 2020
      374 2030
      375 2040
      376 2050
      377 2020
      378 2030
      379 2040
      380 2050
      381 2020
      382 2030
      383 2040
      384 2050
      385 2020
      386 2030
      387 2040
      388 2050
      389 2020
      390 2030
      391 2040
      392 2050
      393 2020
      394 2030
      395 2040
      396 2050
      397 2020
      398 2030
      399 2040
      400 2050
      401 2020
      402 2030
      403 2040
      404 2050
      405 2020
      406 2030
      407 2040
      408 2050
      409 2020
      410 2030
      411 2040
      412 2050
      413 2020
      414 2030
      415 2040
      416 2050
      417 2020
      418 2030
      419 2040
      420 2050
      421 2020
      422 2030
      423 2040
      424 2050
      425 2020
      426 2030
      427 2040
      428 2050
      429 2020
      430 2030
      431 2040
      432 2050
      433 2020
      434 2030
      435 2040
      436 2050
      437 2020
      438 2030
      439 2040
      440 2050
      441 2020
      442 2030
      443 2040
      444 2050
      445 2020
      446 2030
      447 2040
      448 2050
      449 2020
      450 2030
      451 2040
      452 2050
      453 2020
      454 2030
      455 2040
      456 2050
      457 2020
      458 2030
      459 2040
      460 2050
      461 2020
      462 2030
      463 2040
      464 2050
      465 2020
      466 2030
      467 2040
      468 2050
      469 2020
      470 2030
      471 2040
      472 2050
      473 2020
      474 2030
      475 2040
      476 2050
      477 2020
      478 2030
      479 2040
      480 2050
      481 2020
      482 2030
      483 2040
      484 2050
      
      [[6]]
                  value
      1     550.4698707
      2      47.3894183
      3     -60.5859092
      4    -175.4472297
      5     397.4480543
      6     188.7143975
      7      13.0514154
      8       0.0000000
      9      70.2111974
      10     30.5464284
      11     12.7604793
      12      0.5758578
      13    174.7404202
      14    116.1271626
      15     53.1712805
      16     36.7285568
      17     82.6013642
      18     55.5660312
      19     22.5908163
      20      1.1956011
      21    113.1381332
      22     82.1050219
      23     31.6630277
      24      0.0000000
      25    398.3744906
      26    225.3184274
      27      0.7532166
      28      0.0000000
      29     93.6058766
      30     80.6176133
      31      5.0496159
      32      0.0000000
      33     88.7888100
      34    147.1479930
      35     98.3098637
      36     36.2081966
      37    142.7172828
      38    150.8653940
      39    100.0609150
      40     27.1827463
      41     74.5956583
      42     36.2747815
      43      1.3909859
      44      0.0000000
      45    182.1050792
      46    159.6979268
      47     89.0766102
      48     44.1177254
      49   2368.7962376
      50   1320.3705960
      51    367.2923172
      52    -29.4385458
      53    150.0000000
      54     60.0000000
      55    -60.0000000
      56   -110.0000000
      57  12763.4611034
      58   5359.1821086
      59    392.3527007
      60   -807.1288825
      61   3009.1959615
      62   2454.2085893
      63   1027.6093147
      64     61.3004139
      65   2415.2129421
      66   1871.8160764
      67    778.2053491
      68     88.2921727
      69   3021.2168930
      70   2641.4669656
      71   1573.8208497
      72    591.8072198
      73   1385.3870012
      74   1217.9542991
      75    690.3366346
      76    101.7648171
      77   1920.9290456
      78   1747.6443868
      79    920.5647911
      80     91.9987471
      81   2761.6498757
      82   2341.5314912
      83    362.4314112
      84     24.9521077
      85   1831.8762496
      86   2087.3268579
      87    524.4611018
      88     33.0920023
      89    656.1545517
      90   1211.4726177
      91    891.4865957
      92    362.5932179
      93    807.8559071
      94   1042.7729587
      95    771.1215247
      96    223.5124311
      97   1278.4655499
      98    993.9080975
      99    234.5592598
      100    96.9414688
      101  2912.3385587
      102  2742.6176155
      103  1571.3675932
      104   699.2068147
      105 34763.7436395
      106 25711.9020643
      107  9738.3171260
      108  1568.3325306
      109  5860.0000000
      110  2250.0000000
      111   570.0000000
      112 -1870.0000000
      113 31904.0000000
      114 33134.7000000
      115 30799.9000000
      116 28946.4000000
      117 14335.2000000
      118 13695.0000000
      119 11553.4000000
      120  9863.0400000
      121 10193.7000000
      122 11411.5000000
      123 11247.9000000
      124 11094.2000000
      125  7161.5100000
      126  7773.6900000
      127  7674.7400000
      128  7628.5300000
      129   213.4100000
      130   254.3700000
      131   323.6500000
      132   360.3800000
      133     0.8100000
      134     8.7400000
      135    27.7900000
      136    59.2800000
      137 13502.0000000
      138 12758.6000000
      139 10676.3000000
      140  9307.7400000
      141  9750.4000000
      142  9127.9800000
      143  7281.7900000
      144  5938.4400000
      145   557.3000000
      146   371.5600000
      147   308.5200000
      148   260.2900000
      149  3095.2400000
      150  3104.6600000
      151  2863.2600000
      152  2842.1000000
      153    99.1000000
      154   154.4400000
      155   222.7700000
      156   266.9100000
      157  1487.1800000
      158  1698.3700000
      159  1695.4900000
      160  1659.1000000
      161 19521.6000000
      162 21627.0000000
      163 21501.3000000
      164 21056.1000000
      165  4474.2800000
      166  4458.2400000
      167  4170.3700000
      168  3829.9800000
      169  9080.0600000
      170 10455.5000000
      171 10388.4000000
      172 10331.1000000
      173  3320.8500000
      174  3800.0100000
      175  3929.0500000
      176  3904.1200000
      177   113.5000000
      178   100.0400000
      179   101.0000000
      180    93.6500000
      181  9132.2200000
      182 10036.5000000
      183 10060.7000000
      184  9669.4400000
      185  2724.2600000
      186  2929.0000000
      187  2797.7000000
      188  2652.9700000
      189  1286.7900000
      190  1492.1900000
      191  1492.0000000
      192  1429.1300000
      193  2458.3300000
      194  2648.1700000
      195  2699.1400000
      196  2585.3000000
      197  7112.9500000
      198  8471.7600000
      199  8570.5700000
      200  8699.6600000
      201  5484.7800000
      202  6064.5200000
      203  5925.1000000
      204  5666.9000000
      205  2803.0500000
      206  2961.6000000
      207  2760.5500000
      208  2470.3400000
      209  1688.1000000
      210  2069.7900000
      211  2274.1600000
      212  2435.0400000
      213   586.3100000
      214  1259.4900000
      215  1439.5700000
      216  1675.4500000
      217   795.8500000
      218   904.9800000
      219   978.6400000
      220  1144.9400000
      221  2850.6500000
      222  2680.3300000
      223  2446.3600000
      224  2293.4100000
      225  1982.9400000
      226  1746.6000000
      227  1527.8200000
      228  1415.0800000
      229   867.7100000
      230   933.7300000
      231   918.5400000
      232   878.3300000
      233     0.9700000
      234    11.2700000
      235    35.1500000
      236    69.5900000
      237 31904.0000000
      238 28803.0000000
      239 18554.4000000
      240 11346.5000000
      241 14335.2000000
      242 11881.3000000
      243  6594.4600000
      244  2973.1500000
      245 10193.7000000
      246 10092.6000000
      247  7169.4100000
      248  5077.7700000
      249  7161.5100000
      250  6679.8600000
      251  4966.9500000
      252  3758.4700000
      253   213.4100000
      254   149.1900000
      255  -176.4600000
      256  -462.9100000
      257     0.8100000
      258    49.9700000
      259   163.5300000
      260   405.9600000
      261 13502.0000000
      262 11329.9000000
      263  6389.1300000
      264  3137.6700000
      265  9750.4000000
      266  8163.4300000
      267  4291.9500000
      268  1712.5900000
      269   557.3000000
      270   322.0800000
      271   230.3500000
      272   155.8600000
      273  3095.2400000
      274  2759.4100000
      275  2021.7300000
      276  1597.9300000
      277    99.1000000
      278    84.9300000
      279  -154.9100000
      280  -328.7100000
      281  1487.1800000
      282  1334.0900000
      283   730.2900000
      284   191.2000000
      285 19521.6000000
      286 18784.8000000
      287 13438.2000000
      288  9123.8900000
      289  4474.2800000
      290  3621.1400000
      291  2239.1500000
      292  1238.7800000
      293  9080.0600000
      294  9302.2300000
      295  6669.6300000
      296  4754.8800000
      297  3320.8500000
      298  3225.1700000
      299  2464.8800000
      300  1803.3600000
      301   113.5000000
      302    64.4300000
      303   -21.0300000
      304  -124.9300000
      305  9132.2200000
      306  8569.2900000
      307  6233.7000000
      308  3946.0300000
      309  2724.2600000
      310  2511.5200000
      311  1807.7500000
      312  1119.8400000
      313  1286.7900000
      314  1314.6200000
      315   925.0400000
      316   547.9700000
      317  2458.3300000
      318  2328.6300000
      319  1758.4100000
      320  1084.1000000
      321  7112.9500000
      322  7616.0700000
      323  5556.6100000
      324  4024.7600000
      325  5484.7800000
      326  5458.5500000
      327  3772.6800000
      328  2508.6100000
      329  2803.0500000
      330  2588.6000000
      331  1597.8200000
      332   996.8700000
      333  1688.1000000
      334  1909.4700000
      335  1548.7500000
      336  1137.4500000
      337   586.3100000
      338  1196.8900000
      339  1135.7500000
      340  1073.7600000
      341   795.8500000
      342   778.3300000
      343   524.7500000
      344   361.8900000
      345  2850.6500000
      346  2266.8200000
      347  1434.3800000
      348  1029.4900000
      349  1982.9400000
      350  1558.5700000
      351  1002.2300000
      352   747.7300000
      353   867.7100000
      354   708.2500000
      355   432.1500000
      356   281.7700000
      357     0.9700000
      358    86.4700000
      359   430.8500000
      360   917.8200000
      361 31904.0000000
      362 20590.4000000
      363  5103.2700000
      364   509.6300000
      365 14335.2000000
      366  7578.3200000
      367  1140.4400000
      368   114.2700000
      369 10193.7000000
      370  7710.4400000
      371  3029.6100000
      372   722.1500000
      373  7161.5100000
      374  5282.3300000
      375  1390.9100000
      376   404.6700000
      377   213.4100000
      378    19.3400000
      379  -457.6800000
      380  -731.4600000
      381     0.8100000
      382   155.8700000
      383   530.3000000
      384   786.8500000
      385 13502.0000000
      386  7076.4700000
      387  -188.6100000
      388  -350.7800000
      389  9750.4000000
      390  4653.4800000
      391    48.7300000
      392    26.6500000
      393   557.3000000
      394   167.3900000
      395    17.8000000
      396     2.3400000
      397  3095.2400000
      398  2264.1800000
      399    79.9900000
      400    41.6900000
      401    99.1000000
      402    -8.5800000
      403  -335.1300000
      404  -421.4600000
      405  1487.1800000
      406   965.6200000
      407   112.3300000
      408  -266.4500000
      409 19521.6000000
      410 14765.0000000
      411  6092.0700000
      412  1004.6800000
      413  4474.2800000
      414  2835.2300000
      415  1043.4500000
      416    72.9200000
      417  9080.0600000
      418  7162.0500000
      419  2864.5000000
      420   650.7900000
      421  3320.8500000
      422  2490.7300000
      423  1094.3000000
      424   213.2300000
      425   113.5000000
      426    28.8900000
      427   -96.1800000
      428  -204.8200000
      429  9132.2200000
      430  7167.7100000
      431  3246.0500000
      432   395.7800000
      433  2724.2600000
      434  2090.5400000
      435   965.0500000
      436   176.8800000
      437  1286.7900000
      438  1137.2400000
      439   545.8300000
      440    38.4800000
      441  2458.3300000
      442  1910.4600000
      443   869.0200000
      444    75.5000000
      445  7112.9500000
      446  5687.0100000
      447  2258.2000000
      448   535.1600000
      449  5484.7800000
      450  3987.8400000
      451  1369.9700000
      452   195.0300000
      453  2803.0500000
      454  1690.9900000
      455   421.6600000
      456    45.3400000
      457  1688.1000000
      458  1574.2600000
      459   745.5800000
      460   136.1200000
      461   586.3100000
      462   884.2100000
      463   511.0200000
      464   199.4400000
      465   795.8500000
      466   673.3700000
      467   303.7800000
      468   107.1000000
      469  2850.6500000
      470  1631.9100000
      471   474.5800000
      472    55.3600000
      473  1982.9400000
      474  1197.4000000
      475   368.8800000
      476    54.6100000
      477   867.7100000
      478   434.5100000
      479   105.7000000
      480     0.7500000
      481     0.9700000
      482   234.1100000
      483  1008.2400000
      484  1525.9100000
      
      [[7]]
             reductions
      1    0.000000e+00
      2    9.139110e-01
      3    1.110062e+00
      4    1.318723e+00
      5    0.000000e+00
      6    5.251847e-01
      7    9.671620e-01
      8    1.000000e+00
      9    0.000000e+00
      10   5.649351e-01
      11   8.182558e-01
      12   9.917982e-01
      13   0.000000e+00
      14   3.354304e-01
      15   6.957128e-01
      16   7.898108e-01
      17   0.000000e+00
      18   3.272989e-01
      19   7.265080e-01
      20   9.855256e-01
      21   0.000000e+00
      22   2.742940e-01
      23   7.201383e-01
      24   1.000000e+00
      25   0.000000e+00
      26   4.344055e-01
      27   9.981093e-01
      28   1.000000e+00
      29   0.000000e+00
      30   1.387548e-01
      31   9.460545e-01
      32   1.000000e+00
      33   0.000000e+00
      34  -6.572808e-01
      35  -1.072326e-01
      36   5.921987e-01
      37   0.000000e+00
      38  -5.709267e-02
      39   2.988872e-01
      40   8.095343e-01
      41   0.000000e+00
      42   5.137146e-01
      43   9.813530e-01
      44   1.000000e+00
      45   0.000000e+00
      46   1.230452e-01
      47   5.108505e-01
      48   7.577348e-01
      49   0.000000e+00
      50   4.425985e-01
      51   8.449456e-01
      52   1.012428e+00
      53   0.000000e+00
      54   6.000000e-01
      55   1.400000e+00
      56   1.733333e+00
      57   0.000000e+00
      58   5.801153e-01
      59   9.692597e-01
      60   1.063237e+00
      61   0.000000e+00
      62   1.844305e-01
      63   6.585103e-01
      64   9.796290e-01
      65   0.000000e+00
      66   2.249892e-01
      67   6.777902e-01
      68   9.634433e-01
      69   0.000000e+00
      70   1.256944e-01
      71   4.790772e-01
      72   8.041163e-01
      73   0.000000e+00
      74   1.208563e-01
      75   5.017012e-01
      76   9.265441e-01
      77   0.000000e+00
      78   9.020878e-02
      79   5.207711e-01
      80   9.521072e-01
      81   0.000000e+00
      82   1.521259e-01
      83   8.687627e-01
      84   9.909648e-01
      85   0.000000e+00
      86  -1.394475e-01
      87   7.137028e-01
      88   9.819355e-01
      89   0.000000e+00
      90  -8.463221e-01
      91  -3.586534e-01
      92   4.473966e-01
      93   0.000000e+00
      94  -2.907908e-01
      95   4.547145e-02
      96   7.233264e-01
      97   0.000000e+00
      98   2.225773e-01
      99   8.165306e-01
      100  9.241736e-01
      101  0.000000e+00
      102  5.827652e-02
      103  4.604447e-01
      104  7.599157e-01
      105  0.000000e+00
      106  2.603817e-01
      107  7.198714e-01
      108  9.548860e-01
      109  1.000000e+00
      110  6.160410e-01
      111  9.027304e-01
      112  1.319113e+00
      113  0.000000e+00
      114 -3.857510e-02
      115  3.460695e-02
      116  9.270311e-02
      117  0.000000e+00
      118  4.465930e-02
      119  1.940538e-01
      120  3.119705e-01
      121  0.000000e+00
      122 -1.194659e-01
      123 -1.034168e-01
      124 -8.833888e-02
      125  0.000000e+00
      126 -8.548197e-02
      127 -7.166505e-02
      128 -6.521250e-02
      129  0.000000e+00
      130 -1.919310e-01
      131 -5.165644e-01
      132 -6.886744e-01
      133  0.000000e+00
      134 -9.790123e+00
      135 -3.330864e+01
      136 -7.218519e+01
      137  0.000000e+00
      138  5.505851e-02
      139  2.092801e-01
      140  3.106399e-01
      141  0.000000e+00
      142  6.383533e-02
      143  2.531804e-01
      144  3.909542e-01
      145  0.000000e+00
      146  3.332855e-01
      147  4.464023e-01
      148  5.329446e-01
      149  0.000000e+00
      150 -3.043383e-03
      151  7.494734e-02
      152  8.178364e-02
      153  0.000000e+00
      154 -5.584258e-01
      155 -1.247931e+00
      156 -1.693340e+00
      157  0.000000e+00
      158 -1.420070e-01
      159 -1.400705e-01
      160 -1.156013e-01
      161  0.000000e+00
      162 -1.078498e-01
      163 -1.014107e-01
      164 -7.860524e-02
      165  0.000000e+00
      166  3.584934e-03
      167  6.792378e-02
      168  1.440008e-01
      169  0.000000e+00
      170 -1.514792e-01
      171 -1.440894e-01
      172 -1.377788e-01
      173  0.000000e+00
      174 -1.442884e-01
      175 -1.831459e-01
      176 -1.756388e-01
      177  0.000000e+00
      178  1.185903e-01
      179  1.101322e-01
      180  1.748899e-01
      181  0.000000e+00
      182 -9.902083e-02
      183 -1.016708e-01
      184 -5.882688e-02
      185  0.000000e+00
      186 -7.515435e-02
      187 -2.695778e-02
      188  2.616857e-02
      189  0.000000e+00
      190 -1.596220e-01
      191 -1.594744e-01
      192 -1.106163e-01
      193  0.000000e+00
      194 -7.722316e-02
      195 -9.795674e-02
      196 -5.164888e-02
      197  0.000000e+00
      198 -1.910333e-01
      199 -2.049248e-01
      200 -2.230734e-01
      201  0.000000e+00
      202 -1.056998e-01
      203 -8.028034e-02
      204 -3.320461e-02
      205  0.000000e+00
      206 -5.656339e-02
      207  1.516206e-02
      208  1.186957e-01
      209  0.000000e+00
      210 -2.261063e-01
      211 -3.471714e-01
      212 -4.424738e-01
      213  0.000000e+00
      214 -1.148164e+00
      215 -1.455305e+00
      216 -1.857618e+00
      217  0.000000e+00
      218 -1.371238e-01
      219 -2.296790e-01
      220 -4.386379e-01
      221  0.000000e+00
      222  5.974778e-02
      223  1.418238e-01
      224  1.954782e-01
      225  0.000000e+00
      226  1.191867e-01
      227  2.295178e-01
      228  2.863728e-01
      229  0.000000e+00
      230 -7.608533e-02
      231 -5.857948e-02
      232 -1.223911e-02
      233  0.000000e+00
      234 -1.061856e+01
      235 -3.523711e+01
      236 -7.074227e+01
      237  0.000000e+00
      238  9.719784e-02
      239  4.184303e-01
      240  6.443549e-01
      241  0.000000e+00
      242  1.711800e-01
      243  5.399813e-01
      244  7.925979e-01
      245  0.000000e+00
      246  9.917890e-03
      247  2.966823e-01
      248  5.018717e-01
      249  0.000000e+00
      250  6.725537e-02
      251  3.064382e-01
      252  4.751847e-01
      253  0.000000e+00
      254  3.009231e-01
      255  1.826859e+00
      256  3.169111e+00
      257  0.000000e+00
      258 -6.069136e+01
      259 -2.008889e+02
      260 -5.001852e+02
      261  0.000000e+00
      262  1.608725e-01
      263  5.268012e-01
      264  7.676144e-01
      265  0.000000e+00
      266  1.627595e-01
      267  5.598181e-01
      268  8.243569e-01
      269  0.000000e+00
      270  4.220707e-01
      271  5.866679e-01
      272  7.203302e-01
      273  0.000000e+00
      274  1.084989e-01
      275  3.468261e-01
      276  4.837460e-01
      277  0.000000e+00
      278  1.429869e-01
      279  2.563169e+00
      280  4.316953e+00
      281  0.000000e+00
      282  1.029398e-01
      283  5.089431e-01
      284  8.714345e-01
      285  0.000000e+00
      286  3.774281e-02
      287  3.116240e-01
      288  5.326259e-01
      289  0.000000e+00
      290  1.906765e-01
      291  4.995508e-01
      292  7.231331e-01
      293  0.000000e+00
      294 -2.446790e-02
      295  2.654641e-01
      296  4.763383e-01
      297  0.000000e+00
      298  2.881190e-02
      299  2.577563e-01
      300  4.569583e-01
      301  0.000000e+00
      302  4.323348e-01
      303  1.185286e+00
      304  2.100705e+00
      305  0.000000e+00
      306  6.164219e-02
      307  3.173949e-01
      308  5.679002e-01
      309  0.000000e+00
      310  7.809093e-02
      311  3.364253e-01
      312  5.889379e-01
      313  0.000000e+00
      314 -2.162746e-02
      315  2.811259e-01
      316  5.741574e-01
      317  0.000000e+00
      318  5.275939e-02
      319  2.847136e-01
      320  5.590096e-01
      321  0.000000e+00
      322 -7.073296e-02
      323  2.188037e-01
      324  4.341644e-01
      325  0.000000e+00
      326  4.782325e-03
      327  3.121547e-01
      328  5.426234e-01
      329  0.000000e+00
      330  7.650595e-02
      331  4.299709e-01
      332  6.443624e-01
      333  0.000000e+00
      334 -1.311356e-01
      335  8.254843e-02
      336  3.261951e-01
      337  0.000000e+00
      338 -1.041394e+00
      339 -9.371152e-01
      340 -8.313861e-01
      341  0.000000e+00
      342  2.201420e-02
      343  3.406421e-01
      344  5.452786e-01
      345  0.000000e+00
      346  2.048059e-01
      347  4.968235e-01
      348  6.388578e-01
      349  0.000000e+00
      350  2.140105e-01
      351  4.945737e-01
      352  6.229185e-01
      353  0.000000e+00
      354  1.837711e-01
      355  5.019649e-01
      356  6.752717e-01
      357  0.000000e+00
      358 -8.814433e+01
      359 -4.431753e+02
      360 -9.452062e+02
      361  0.000000e+00
      362  3.546138e-01
      363  8.400429e-01
      364  9.840261e-01
      365  0.000000e+00
      366  4.713488e-01
      367  9.204448e-01
      368  9.920287e-01
      369  0.000000e+00
      370  2.436073e-01
      371  7.027958e-01
      372  9.291572e-01
      373  0.000000e+00
      374  2.624000e-01
      375  8.057798e-01
      376  9.434938e-01
      377  0.000000e+00
      378  9.093763e-01
      379  3.144604e+00
      380  4.427487e+00
      381  0.000000e+00
      382 -1.914321e+02
      383 -6.536914e+02
      384 -9.704198e+02
      385  0.000000e+00
      386  4.758947e-01
      387  1.013969e+00
      388  1.025980e+00
      389  0.000000e+00
      390  5.227396e-01
      391  9.950023e-01
      392  9.972668e-01
      393  0.000000e+00
      394  6.996411e-01
      395  9.680603e-01
      396  9.958012e-01
      397  0.000000e+00
      398  2.684961e-01
      399  9.741571e-01
      400  9.865309e-01
      401  0.000000e+00
      402  1.086579e+00
      403  4.381736e+00
      404  5.252876e+00
      405  0.000000e+00
      406  3.507040e-01
      407  9.244678e-01
      408  1.179165e+00
      409  0.000000e+00
      410  2.436583e-01
      411  6.879318e-01
      412  9.485350e-01
      413  0.000000e+00
      414  3.663271e-01
      415  7.667893e-01
      416  9.837024e-01
      417  0.000000e+00
      418  2.112332e-01
      419  6.845285e-01
      420  9.283276e-01
      421  0.000000e+00
      422  2.499721e-01
      423  6.704759e-01
      424  9.357905e-01
      425  0.000000e+00
      426  7.454626e-01
      427  1.847401e+00
      428  2.804581e+00
      429  0.000000e+00
      430  2.151186e-01
      431  6.445497e-01
      432  9.566611e-01
      433  0.000000e+00
      434  2.326210e-01
      435  6.457570e-01
      436  9.350723e-01
      437  0.000000e+00
      438  1.162194e-01
      439  5.758205e-01
      440  9.700961e-01
      441  0.000000e+00
      442  2.228627e-01
      443  6.464999e-01
      444  9.692881e-01
      445  0.000000e+00
      446  2.004710e-01
      447  6.825227e-01
      448  9.247626e-01
      449  0.000000e+00
      450  2.729262e-01
      451  7.502233e-01
      452  9.644416e-01
      453  0.000000e+00
      454  3.967321e-01
      455  8.495710e-01
      456  9.838248e-01
      457  0.000000e+00
      458  6.743676e-02
      459  5.583319e-01
      460  9.193650e-01
      461  0.000000e+00
      462 -5.080930e-01
      463  1.284133e-01
      464  6.598387e-01
      465  0.000000e+00
      466  1.538983e-01
      467  6.182949e-01
      468  8.654269e-01
      469  0.000000e+00
      470  4.275306e-01
      471  8.335187e-01
      472  9.805799e-01
      473  0.000000e+00
      474  3.961492e-01
      475  8.139732e-01
      476  9.724601e-01
      477  0.000000e+00
      478  4.992451e-01
      479  8.781851e-01
      480  9.991357e-01
      481  0.000000e+00
      482 -2.403505e+02
      483 -1.038423e+03
      484 -1.572103e+03
      
      [[8]]
          type
      1    ipr
      2    ipr
      3    ipr
      4    ipr
      5    ipr
      6    ipr
      7    ipr
      8    ipr
      9    ipr
      10   ipr
      11   ipr
      12   ipr
      13   ipr
      14   ipr
      15   ipr
      16   ipr
      17   ipr
      18   ipr
      19   ipr
      20   ipr
      21   ipr
      22   ipr
      23   ipr
      24   ipr
      25   ipr
      26   ipr
      27   ipr
      28   ipr
      29   ipr
      30   ipr
      31   ipr
      32   ipr
      33   ipr
      34   ipr
      35   ipr
      36   ipr
      37   ipr
      38   ipr
      39   ipr
      40   ipr
      41   ipr
      42   ipr
      43   ipr
      44   ipr
      45   ipr
      46   ipr
      47   ipr
      48   ipr
      49   ipr
      50   ipr
      51   ipr
      52   ipr
      53   ipr
      54   ipr
      55   ipr
      56   ipr
      57   ipr
      58   ipr
      59   ipr
      60   ipr
      61   ipr
      62   ipr
      63   ipr
      64   ipr
      65   ipr
      66   ipr
      67   ipr
      68   ipr
      69   ipr
      70   ipr
      71   ipr
      72   ipr
      73   ipr
      74   ipr
      75   ipr
      76   ipr
      77   ipr
      78   ipr
      79   ipr
      80   ipr
      81   ipr
      82   ipr
      83   ipr
      84   ipr
      85   ipr
      86   ipr
      87   ipr
      88   ipr
      89   ipr
      90   ipr
      91   ipr
      92   ipr
      93   ipr
      94   ipr
      95   ipr
      96   ipr
      97   ipr
      98   ipr
      99   ipr
      100  ipr
      101  ipr
      102  ipr
      103  ipr
      104  ipr
      105  ipr
      106  ipr
      107  ipr
      108  ipr
      109  ipr
      110  ipr
      111  ipr
      112  ipr
      113  weo
      114  weo
      115  weo
      116  weo
      117  weo
      118  weo
      119  weo
      120  weo
      121  weo
      122  weo
      123  weo
      124  weo
      125  weo
      126  weo
      127  weo
      128  weo
      129  weo
      130  weo
      131  weo
      132  weo
      133  weo
      134  weo
      135  weo
      136  weo
      137  weo
      138  weo
      139  weo
      140  weo
      141  weo
      142  weo
      143  weo
      144  weo
      145  weo
      146  weo
      147  weo
      148  weo
      149  weo
      150  weo
      151  weo
      152  weo
      153  weo
      154  weo
      155  weo
      156  weo
      157  weo
      158  weo
      159  weo
      160  weo
      161  weo
      162  weo
      163  weo
      164  weo
      165  weo
      166  weo
      167  weo
      168  weo
      169  weo
      170  weo
      171  weo
      172  weo
      173  weo
      174  weo
      175  weo
      176  weo
      177  weo
      178  weo
      179  weo
      180  weo
      181  weo
      182  weo
      183  weo
      184  weo
      185  weo
      186  weo
      187  weo
      188  weo
      189  weo
      190  weo
      191  weo
      192  weo
      193  weo
      194  weo
      195  weo
      196  weo
      197  weo
      198  weo
      199  weo
      200  weo
      201  weo
      202  weo
      203  weo
      204  weo
      205  weo
      206  weo
      207  weo
      208  weo
      209  weo
      210  weo
      211  weo
      212  weo
      213  weo
      214  weo
      215  weo
      216  weo
      217  weo
      218  weo
      219  weo
      220  weo
      221  weo
      222  weo
      223  weo
      224  weo
      225  weo
      226  weo
      227  weo
      228  weo
      229  weo
      230  weo
      231  weo
      232  weo
      233  weo
      234  weo
      235  weo
      236  weo
      237  weo
      238  weo
      239  weo
      240  weo
      241  weo
      242  weo
      243  weo
      244  weo
      245  weo
      246  weo
      247  weo
      248  weo
      249  weo
      250  weo
      251  weo
      252  weo
      253  weo
      254  weo
      255  weo
      256  weo
      257  weo
      258  weo
      259  weo
      260  weo
      261  weo
      262  weo
      263  weo
      264  weo
      265  weo
      266  weo
      267  weo
      268  weo
      269  weo
      270  weo
      271  weo
      272  weo
      273  weo
      274  weo
      275  weo
      276  weo
      277  weo
      278  weo
      279  weo
      280  weo
      281  weo
      282  weo
      283  weo
      284  weo
      285  weo
      286  weo
      287  weo
      288  weo
      289  weo
      290  weo
      291  weo
      292  weo
      293  weo
      294  weo
      295  weo
      296  weo
      297  weo
      298  weo
      299  weo
      300  weo
      301  weo
      302  weo
      303  weo
      304  weo
      305  weo
      306  weo
      307  weo
      308  weo
      309  weo
      310  weo
      311  weo
      312  weo
      313  weo
      314  weo
      315  weo
      316  weo
      317  weo
      318  weo
      319  weo
      320  weo
      321  weo
      322  weo
      323  weo
      324  weo
      325  weo
      326  weo
      327  weo
      328  weo
      329  weo
      330  weo
      331  weo
      332  weo
      333  weo
      334  weo
      335  weo
      336  weo
      337  weo
      338  weo
      339  weo
      340  weo
      341  weo
      342  weo
      343  weo
      344  weo
      345  weo
      346  weo
      347  weo
      348  weo
      349  weo
      350  weo
      351  weo
      352  weo
      353  weo
      354  weo
      355  weo
      356  weo
      357  weo
      358  weo
      359  weo
      360  weo
      361  weo
      362  weo
      363  weo
      364  weo
      365  weo
      366  weo
      367  weo
      368  weo
      369  weo
      370  weo
      371  weo
      372  weo
      373  weo
      374  weo
      375  weo
      376  weo
      377  weo
      378  weo
      379  weo
      380  weo
      381  weo
      382  weo
      383  weo
      384  weo
      385  weo
      386  weo
      387  weo
      388  weo
      389  weo
      390  weo
      391  weo
      392  weo
      393  weo
      394  weo
      395  weo
      396  weo
      397  weo
      398  weo
      399  weo
      400  weo
      401  weo
      402  weo
      403  weo
      404  weo
      405  weo
      406  weo
      407  weo
      408  weo
      409  weo
      410  weo
      411  weo
      412  weo
      413  weo
      414  weo
      415  weo
      416  weo
      417  weo
      418  weo
      419  weo
      420  weo
      421  weo
      422  weo
      423  weo
      424  weo
      425  weo
      426  weo
      427  weo
      428  weo
      429  weo
      430  weo
      431  weo
      432  weo
      433  weo
      434  weo
      435  weo
      436  weo
      437  weo
      438  weo
      439  weo
      440  weo
      441  weo
      442  weo
      443  weo
      444  weo
      445  weo
      446  weo
      447  weo
      448  weo
      449  weo
      450  weo
      451  weo
      452  weo
      453  weo
      454  weo
      455  weo
      456  weo
      457  weo
      458  weo
      459  weo
      460  weo
      461  weo
      462  weo
      463  weo
      464  weo
      465  weo
      466  weo
      467  weo
      468  weo
      469  weo
      470  weo
      471  weo
      472  weo
      473  weo
      474  weo
      475  weo
      476  weo
      477  weo
      478  weo
      479  weo
      480  weo
      481  weo
      482  weo
      483  weo
      484  weo
      

# `istr_inputs` hasn't changed

    Code
      format_robust_snapshot(tiltIndicator::istr_inputs)
    Output
      [[1]]
                                                        activity_uuid_product_uuid
      1  0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      2  0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      3  0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      4  0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      5  0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      6  0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      7  0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      8  0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      9  0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      10 0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      11 0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      12 0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      13 0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      14 0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      15 0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      16 0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      17 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      18 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      19 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      20 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      21 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      22 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      23 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      24 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      25 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      26 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      27 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      28 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      29 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      30 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      31 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db4
      32 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db4
      33 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db5
      34 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db5
      35 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db6
      36 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db6
      37 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db7
      38 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db7
      39 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db8
      40 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db8
      41 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db9
      42 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db9
      43 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      44 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      45 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      46 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      47 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      48 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      49 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      50 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      51 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      52 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      53 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      54 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      55 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      56 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      57 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      58 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      59 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      60 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      61 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      62 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      63 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      64 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      65 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      66 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      67 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      68 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      69 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      70 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      71 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      72 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      73 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      74 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      
      [[2]]
                                                  input_activity_uuid_product_uuid
      1  5de8c337-dea9-5c1f-9d90-002de27188be_8911bd8c-a96f-4440-9f8e-a7dacf5e79de
      2  5de8c337-dea9-5c1f-9d90-002de27188be_8911bd8c-a96f-4440-9f8e-a7dacf5e79de
      3  1aeb18b9-8355-560f-82aa-543c771c4d61_a0e53510-b90b-43ba-80cc-7600f5da004f
      4  1aeb18b9-8355-560f-82aa-543c771c4d61_a0e53510-b90b-43ba-80cc-7600f5da004f
      5  22704506-7707-5ae7-990d-ebf01ac04fb5_50c41012-3b00-429d-ace3-40d0afb69746
      6  22704506-7707-5ae7-990d-ebf01ac04fb5_50c41012-3b00-429d-ace3-40d0afb69746
      7  92078219-1ed3-5215-9f70-931cdefad520_5c21b18e-e32d-4c76-8d16-2238632163c2
      8  92078219-1ed3-5215-9f70-931cdefad520_5c21b18e-e32d-4c76-8d16-2238632163c2
      9  9d483329-b09a-5513-b1bc-722cb211e928_bded6c5a-4dca-497e-bdd9-fcd343012087
      10 9d483329-b09a-5513-b1bc-722cb211e928_bded6c5a-4dca-497e-bdd9-fcd343012087
      11 8709b463-732e-592e-9b88-999ed17af48f_6b6b3a15-e640-5730-baea-cda98afc61c2
      12 8709b463-732e-592e-9b88-999ed17af48f_6b6b3a15-e640-5730-baea-cda98afc61c2
      13 d44e7db1-4dda-5139-8a86-ed2929a8f1a2_32e60fbc-4778-470c-9653-feb859a3418f
      14 d44e7db1-4dda-5139-8a86-ed2929a8f1a2_32e60fbc-4778-470c-9653-feb859a3418f
      15 7c7718bb-2372-5d04-a7ac-1ae5b12b05e3_61396bcb-bf35-411a-a6a6-8543ccef83e8
      16 7c7718bb-2372-5d04-a7ac-1ae5b12b05e3_61396bcb-bf35-411a-a6a6-8543ccef83e8
      17 529b4dd4-77bc-5ec7-8fa4-608073c719d0_66c93e71-f32b-4591-901c-55395db5c132
      18 529b4dd4-77bc-5ec7-8fa4-608073c719d0_66c93e71-f32b-4591-901c-55395db5c132
      19 2f749904-d216-59b5-b1b3-57a23f37b274_6a1374ce-3966-46e5-b189-6209e31de5b5
      20 2f749904-d216-59b5-b1b3-57a23f37b274_6a1374ce-3966-46e5-b189-6209e31de5b5
      21 65c5c7c5-8839-596c-9259-6c9e085498a7_759b89bd-3aa6-42ad-b767-5bb9ef5d331d
      22 65c5c7c5-8839-596c-9259-6c9e085498a7_759b89bd-3aa6-42ad-b767-5bb9ef5d331d
      23 2b68c964-42d3-576f-9710-ef9fa5d0d27d_bf0425ee-99c2-488e-9056-3495e9f4e9cb
      24 2b68c964-42d3-576f-9710-ef9fa5d0d27d_bf0425ee-99c2-488e-9056-3495e9f4e9cb
      25 562d638a-1d13-5e98-88d3-acd7d32431d3_2da20646-8adf-460b-bd65-c9fc35494b66
      26 562d638a-1d13-5e98-88d3-acd7d32431d3_2da20646-8adf-460b-bd65-c9fc35494b66
      27 a2c5638c-dc3e-5a87-97b1-77a982439045_adb8247d-8bbd-45aa-b111-289d0e5e2307
      28 a2c5638c-dc3e-5a87-97b1-77a982439045_adb8247d-8bbd-45aa-b111-289d0e5e2307
      29 7f8f858d-2dc1-5e72-9c43-5a1bb22ace8c_66c93e71-f32b-4591-901c-55395db5c132
      30 7f8f858d-2dc1-5e72-9c43-5a1bb22ace8c_66c93e71-f32b-4591-901c-55395db5c132
      31 36ca833f-9fa8-57e3-8685-3d1305c13d84_66c93e71-f32b-4591-901c-55395db5c132
      32 36ca833f-9fa8-57e3-8685-3d1305c13d84_66c93e71-f32b-4591-901c-55395db5c132
      33 5715f39f-04ca-5a76-bd2c-d24bf8f384dd_fbb039f7-f9cc-46d2-b631-313ddb125c1a
      34 5715f39f-04ca-5a76-bd2c-d24bf8f384dd_fbb039f7-f9cc-46d2-b631-313ddb125c1a
      35 4c0298db-adbe-5cef-8d1f-417873c2b1d1_66c93e71-f32b-4591-901c-55395db5c132
      36 4c0298db-adbe-5cef-8d1f-417873c2b1d1_66c93e71-f32b-4591-901c-55395db5c132
      37 eafc47dd-72a9-5acc-935f-c953ce042126_cf47d9e8-58e4-41f9-bde9-4f938fdc8c7b
      38 eafc47dd-72a9-5acc-935f-c953ce042126_cf47d9e8-58e4-41f9-bde9-4f938fdc8c7b
      39 84d234b1-b50a-5759-a247-a88d96e09409_db66eb0b-7b48-4300-8134-2c851292cc14
      40 84d234b1-b50a-5759-a247-a88d96e09409_db66eb0b-7b48-4300-8134-2c851292cc14
      41 38891f7a-6f3f-5b0b-8348-acbf17332e62_4bc66efe-f91b-48e5-9a26-07e383d47e80
      42 38891f7a-6f3f-5b0b-8348-acbf17332e62_4bc66efe-f91b-48e5-9a26-07e383d47e80
      43 87f0a9b4-a63b-5d96-be53-ae33c5bf1f65_66c93e71-f32b-4591-901c-55395db5c132
      44 87f0a9b4-a63b-5d96-be53-ae33c5bf1f65_66c93e71-f32b-4591-901c-55395db5c132
      45 27379124-a824-5560-a5dd-806a73b017e1_d69294d7-8d64-4915-a896-9996a014c410
      46 27379124-a824-5560-a5dd-806a73b017e1_d69294d7-8d64-4915-a896-9996a014c410
      47 6773fc9d-4cb0-5208-a360-d13a806372c8_66c93e71-f32b-4591-901c-55395db5c132
      48 6773fc9d-4cb0-5208-a360-d13a806372c8_66c93e71-f32b-4591-901c-55395db5c132
      49 f08f52c5-583d-5459-92f7-ed216a32eed2_1b30b018-ac39-41f4-a9e0-92057eef8bb8
      50 f08f52c5-583d-5459-92f7-ed216a32eed2_1b30b018-ac39-41f4-a9e0-92057eef8bb8
      51 c5f28517-0c26-5746-9afe-3f3a48bfc71c_85a9dd8c-769e-4528-9a1a-105ab3269262
      52 c5f28517-0c26-5746-9afe-3f3a48bfc71c_85a9dd8c-769e-4528-9a1a-105ab3269262
      53 6737f21a-54a8-58d5-a695-d3e724540ab7_66c93e71-f32b-4591-901c-55395db5c132
      54 6737f21a-54a8-58d5-a695-d3e724540ab7_66c93e71-f32b-4591-901c-55395db5c132
      55 582707f4-f961-5779-b1d9-507bdf5624ef_a9007f10-7e39-4d50-8f4a-d6d03ce3d673
      56 582707f4-f961-5779-b1d9-507bdf5624ef_a9007f10-7e39-4d50-8f4a-d6d03ce3d673
      57 e88cfd36-6260-50a9-9de2-02dc80b99a89_aa447135-9cc5-4f34-9385-ca2a0ae70d3c
      58 e88cfd36-6260-50a9-9de2-02dc80b99a89_aa447135-9cc5-4f34-9385-ca2a0ae70d3c
      59 145b98e6-9f47-58dd-8464-e2f066fa4a4c_7c0ab4ca-e778-44c1-a33d-c26466d32c1a
      60 145b98e6-9f47-58dd-8464-e2f066fa4a4c_7c0ab4ca-e778-44c1-a33d-c26466d32c1a
      61 3bfd4c62-f01f-5cd1-9c80-30742f937963_00478901-732f-4bf4-81cc-2255f9874512
      62 3bfd4c62-f01f-5cd1-9c80-30742f937963_00478901-732f-4bf4-81cc-2255f9874512
      63 7ba4b1a6-0e8f-5fb2-b429-f9c085fbab3c_d3e019ee-edbe-4774-a4a6-9701cf293d05
      64 7ba4b1a6-0e8f-5fb2-b429-f9c085fbab3c_d3e019ee-edbe-4774-a4a6-9701cf293d05
      65 95884d02-3ac6-5327-a7c2-fb6fb86a3946_1570a766-fe08-427f-94cb-6947995117ec
      66 95884d02-3ac6-5327-a7c2-fb6fb86a3946_1570a766-fe08-427f-94cb-6947995117ec
      67 df576113-6029-5f97-a051-2972803313de_0bddecfa-a3d2-46fe-b31e-f794ff258621
      68 df576113-6029-5f97-a051-2972803313de_0bddecfa-a3d2-46fe-b31e-f794ff258621
      69 c773f451-37ac-50b3-9a3c-47d25480e048_66c93e71-f32b-4591-901c-55395db5c132
      70 c773f451-37ac-50b3-9a3c-47d25480e048_66c93e71-f32b-4591-901c-55395db5c132
      71 3c080c8f-7c27-5453-9043-e2cfe14e198e_9b9edcf3-0539-4642-9516-0df642a5c41a
      72 3c080c8f-7c27-5453-9043-e2cfe14e198e_9b9edcf3-0539-4642-9516-0df642a5c41a
      73 1ba65a3e-3e14-5238-a95a-5bec05f9b1ff_bd20be8e-9b7a-4391-980f-4ecf8f2867be
      74 1ba65a3e-3e14-5238-a95a-5bec05f9b1ff_bd20be8e-9b7a-4391-980f-4ecf8f2867be
      
      [[3]]
                                       input_reference_product_name
      1                                                    biowaste
      2                                                    biowaste
      3                                         chemical, inorganic
      4                                         chemical, inorganic
      5                                           chemical, organic
      6                                           chemical, organic
      7                                                    cow milk
      8                                                    cow milk
      9                                        cream, from cow milk
      10                                       cream, from cow milk
      11                                                      dairy
      12                                                      dairy
      13                                electricity, medium voltage
      14                                electricity, medium voltage
      15                  heat, district or industrial, natural gas
      16                  heat, district or industrial, natural gas
      17 alkyd paint, white, without solvent, in 60% solution state
      18 alkyd paint, white, without solvent, in 60% solution state
      19                                      aluminium, cast alloy
      20                                      aluminium, cast alloy
      21                                            copper, cathode
      22                                            copper, cathode
      23                                electricity, medium voltage
      24                                electricity, medium voltage
      25        energy and auxilliary inputs, metal working factory
      26        energy and auxilliary inputs, metal working factory
      27                                       flat glass, uncoated
      28                                       flat glass, uncoated
      29                                         waste mineral wool
      30                                         waste mineral wool
      31                                 seal, natural rubber based
      32                                 seal, natural rubber based
      33                                   transport, freight train
      34                                   transport, freight train
      35               transport, freight, light commercial vehicle
      36               transport, freight, light commercial vehicle
      37                     transport, freight, lorry, unspecified
      38                     transport, freight, lorry, unspecified
      39                    transport, freight, sea, container ship
      40                    transport, freight, sea, container ship
      41                                 chemical factory, organics
      42                                 chemical factory, organics
      43                                 steel, chromium steel 18/8
      44                                 steel, chromium steel 18/8
      45                                   transport, freight train
      46                                   transport, freight train
      47                transport, freight, inland waterways, barge
      48                transport, freight, inland waterways, barge
      49                     transport, freight, lorry, unspecified
      50                     transport, freight, lorry, unspecified
      51        transport, freight, sea, bulk carrier for dry goods
      52        transport, freight, sea, bulk carrier for dry goods
      53                  acrylonitrile-butadiene-styrene copolymer
      54                  acrylonitrile-butadiene-styrene copolymer
      55                                      aluminium, cast alloy
      56                                      aluminium, cast alloy
      57                                  electricity, high voltage
      58                                  electricity, high voltage
      59        energy and auxilliary inputs, metal working factory
      60        energy and auxilliary inputs, metal working factory
      61       heat, central or small-scale, other than natural gas
      62       heat, central or small-scale, other than natural gas
      63                                                inert waste
      64                                                inert waste
      65                                                       lead
      66                                                       lead
      67                                      metal working factory
      68                                      metal working factory
      69                                                  tap water
      70                                                  tap water
      71                                                        tin
      72                                                        tin
      73                                                waste glass
      74                                                waste glass
      
      [[4]]
            input_unit
      1             kg
      2             kg
      3             kg
      4             kg
      5             kg
      6             kg
      7             kg
      8             kg
      9             kg
      10            kg
      11            m3
      12            m3
      13           kwh
      14           kwh
      15            mj
      16            mj
      17            kg
      18            kg
      19            kg
      20            kg
      21            kg
      22            kg
      23           kwh
      24           kwh
      25            kg
      26            kg
      27            kg
      28            kg
      29            kg
      30            kg
      31            kg
      32            kg
      33 metric ton*km
      34 metric ton*km
      35 metric ton*km
      36 metric ton*km
      37 metric ton*km
      38 metric ton*km
      39 metric ton*km
      40 metric ton*km
      41          unit
      42          unit
      43            kg
      44            kg
      45 metric ton*km
      46 metric ton*km
      47 metric ton*km
      48 metric ton*km
      49 metric ton*km
      50 metric ton*km
      51 metric ton*km
      52 metric ton*km
      53            kg
      54            kg
      55            kg
      56            kg
      57           kwh
      58           kwh
      59            kg
      60            kg
      61            mj
      62            mj
      63            kg
      64            kg
      65            kg
      66            kg
      67          unit
      68          unit
      69            kg
      70            kg
      71            kg
      72            kg
      73            kg
      74            kg
      
      [[5]]
         input_isic_4digit
      1               3821
      2               3821
      3               2011
      4               2011
      5               1201
      6               1201
      7               4141
      8               4141
      9               1050
      10              1050
      11              4100
      12              4100
      13              3510
      14              3510
      15              3530
      16              3530
      17              2022
      18              2022
      19              2420
      20              2420
      21              2420
      22              2420
      23              3510
      24              3510
      25              6259
      26              6259
      27              2310
      28              2310
      29              3830
      30              3830
      31              2029
      32              2029
      33              4912
      34              4912
      35              4923
      36              4923
      37              4923
      38              4923
      39              5012
      40              5012
      41              4290
      42              4290
      43              2410
      44              2410
      45              4912
      46              4912
      47              5022
      48              5022
      49              4923
      50              4923
      51              5012
      52              5012
      53              2013
      54              2013
      55              2420
      56              2420
      57              3510
      58              3510
      59              7259
      60              7259
      61              3530
      62              3530
      63              2394
      64              2394
      65              2420
      66              2420
      67              4100
      68              4100
      69              3600
      70              3600
      71              2432
      72              2432
      73              3821
      74              3821
      
      [[6]]
         type
      1   ipr
      2   weo
      3   ipr
      4   weo
      5   ipr
      6   weo
      7   ipr
      8   weo
      9   ipr
      10  weo
      11  ipr
      12  weo
      13  ipr
      14  weo
      15  ipr
      16  weo
      17  ipr
      18  weo
      19  ipr
      20  weo
      21  ipr
      22  weo
      23  ipr
      24  weo
      25  ipr
      26  weo
      27  ipr
      28  weo
      29  ipr
      30  weo
      31  ipr
      32  weo
      33  ipr
      34  weo
      35  ipr
      36  weo
      37  ipr
      38  weo
      39  ipr
      40  weo
      41  ipr
      42  weo
      43  ipr
      44  weo
      45  ipr
      46  weo
      47  ipr
      48  weo
      49  ipr
      50  weo
      51  ipr
      52  weo
      53  ipr
      54  weo
      55  ipr
      56  weo
      57  ipr
      58  weo
      59  ipr
      60  weo
      61  ipr
      62  weo
      63  ipr
      64  weo
      65  ipr
      66  weo
      67  ipr
      68  weo
      69  ipr
      70  weo
      71  ipr
      72  weo
      73  ipr
      74  weo
      
      [[7]]
                      sector
      1             no_match
      2  bioenergy and waste
      3             industry
      4                total
      5             industry
      6                total
      7             land use
      8             no_match
      9             industry
      10               total
      11           buildings
      12               total
      13               power
      14               total
      15               total
      16               total
      17            industry
      18               total
      19            industry
      20               total
      21            industry
      22               total
      23               power
      24               total
      25            industry
      26               total
      27            industry
      28               total
      29            no_match
      30            no_match
      31            industry
      32               total
      33           transport
      34               total
      35           transport
      36               total
      37           transport
      38               total
      39           transport
      40               total
      41           buildings
      42               total
      43            industry
      44               total
      45           transport
      46               total
      47           transport
      48               total
      49           transport
      50               total
      51           transport
      52               total
      53            industry
      54               total
      55            industry
      56               total
      57               power
      58               total
      59            industry
      60               total
      61               total
      62               total
      63            industry
      64               total
      65            industry
      66               total
      67           buildings
      68               total
      69            no_match
      70 bioenergy and waste
      71            industry
      72               total
      73            no_match
      74 bioenergy and waste
      
      [[8]]
                                       subsector
      1                                 no_match
      2                      total energy supply
      3                                chemicals
      4                                chemicals
      5                                chemicals
      6                                chemicals
      7                                     <NA>
      8                                 no_match
      9                           other industry
      10                                industry
      11                                    <NA>
      12                               buildings
      13                                    <NA>
      14                     power sector inputs
      15                                  energy
      16                     total energy supply
      17                               chemicals
      18                               chemicals
      19                   non-metallic minerals
      20                                industry
      21                   non-metallic minerals
      22                                industry
      23                                    <NA>
      24                     power sector inputs
      25                          iron and steel
      26                          iron and steel
      27                   non-metallic minerals
      28                                industry
      29                                no_match
      30                                no_match
      31                               chemicals
      32                               chemicals
      33                         other transport
      34                               transport
      35                                  trucks
      36                                    road
      37                                  trucks
      38                                    road
      39                                shipping
      40 total navigation (domestic and bunkers)
      41                                    <NA>
      42                               buildings
      43                          iron and steel
      44                          iron and steel
      45                         other transport
      46                               transport
      47                                shipping
      48 total navigation (domestic and bunkers)
      49                                  trucks
      50                                    road
      51                                shipping
      52 total navigation (domestic and bunkers)
      53                          other industry
      54                               chemicals
      55                   non-metallic minerals
      56                                industry
      57                                    <NA>
      58                     power sector inputs
      59                          iron and steel
      60                          iron and steel
      61                                  energy
      62                     total energy supply
      63                   non-metallic minerals
      64           non-metallic minerals: cement
      65                   non-metallic minerals
      66                                industry
      67                                    <NA>
      68                               buildings
      69                                no_match
      70                     total energy supply
      71                   non-metallic minerals
      72                                industry
      73                                no_match
      74                     total energy supply
      

# `istr_companies` hasn't changed

    Code
      format_robust_snapshot(tiltIndicator::istr_companies)
    Output
      [[1]]
                                      company_id
      1 fleischerei-stiefsohn_00000005219477-001
      2 fleischerei-stiefsohn_00000005219477-001
      3        pecheries-basques_fra316541-00101
      4    hoche-butter-gmbh_deu422723-693847001
      5  vicquelin-espaces-verts_fra697272-00101
      6   bst-procontrol-gmbh_00000005104947-001
      7           leider-gmbh_00000005064318-001
      8             cheries-baqu_neu316541-00101
      
      [[2]]
          clustered
      1       stove
      2        oven
      3       steel
      4 aged cheese
      5 aged cheese
      6      cheese
      7       cream
      8      rubber
      
      [[3]]
                                                       activity_uuid_product_uuid
      1 0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa
      2 be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc
      3 977d997e-c257-5033-ba39-d0edeeef4ba2_0ace02fa-eca5-482d-a829-c18e46a52db4
      4 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      5 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      6 ebb8475e-ff57-5e4e-937b-b5788186a5ca_ccee034c-8b6c-40d6-ac36-4c70c4623efa
      7 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      8 2f7b77a7-1556-5c1b-b0aa-c4534ddc8885_38d493e9-6feb-4c66-86eb-2253ef8ee54d
      
      [[4]]
                              ei_activity_name
      1       cookstove production or electric
      2              microwave oven production
      3       market for steel, chromium steel
      4 cheese production, soft, from cow milk
      5 cheese production, soft, from cow milk
      6    market for cheese, fresh, unripened
      7  market for seal, natural rubber based
      8  seal production, natural rubber based
      
      [[5]]
        unit
      1 unit
      2 unit
      3   kg
      4   kg
      5   kg
      6   kg
      7   kg
      8   kg
      

# `pstr_companies` hasn't changed

    Code
      format_robust_snapshot(tiltIndicator::pstr_companies)
    Output
      [[1]]
                                       company_id
      1  fleischerei-stiefsohn_00000005219477-001
      2  fleischerei-stiefsohn_00000005219477-001
      3         pecheries-basques_fra316541-00101
      4         pecheries-basques_fra316541-00101
      5     hoche-butter-gmbh_deu422723-693847001
      6     hoche-butter-gmbh_deu422723-693847001
      7     hoche-butter-gmbh_deu422723-693847002
      8     hoche-butter-gmbh_deu422723-693847002
      9     hoche-butter-gmbh_deu422723-693847003
      10    hoche-butter-gmbh_deu422723-693847003
      11  vicquelin-espaces-verts_fra697272-00101
      12  vicquelin-espaces-verts_fra697272-00101
      13  vicquelin-espaces-verts_fra697272-00102
      14  vicquelin-espaces-verts_fra697272-00102
      15  vicquelin-espaces-verts_fra697272-00103
      16  vicquelin-espaces-verts_fra697272-00103
      17                  fleisohn_0000000492-001
      18                  fleisohn_0000000492-001
      19   bst-procontrol-gmbh_00000005104947-001
      20   bst-procontrol-gmbh_00000005104947-001
      21           leider-gmbh_00000005064318-001
      22           leider-gmbh_00000005064318-001
      23           leider-gmbh_00000005064318-002
      24           leider-gmbh_00000005064318-002
      25             cheries-baqu_neu316541-00101
      26             cheries-baqu_neu316541-00101
      27       ca-coity-trg-aua-gmbh_00000384-001
      28       ca-coity-trg-aua-gmbh_00000384-001
      
      [[2]]
                  company_name
      1  fleischerei-stiefsohn
      2  fleischerei-stiefsohn
      3      pecheries-basques
      4      pecheries-basques
      5      hoche-butter-gmbh
      6      hoche-butter-gmbh
      7      hoche-butter-gmbh
      8      hoche-butter-gmbh
      9      hoche-butter-gmbh
      10     hoche-butter-gmbh
      11     vicquelin-espaces
      12     vicquelin-espaces
      13     vicquelin-espaces
      14     vicquelin-espaces
      15     vicquelin-espaces
      16     vicquelin-espaces
      17              fleisohn
      18              fleisohn
      19   bst-procontrol-gmbh
      20   bst-procontrol-gmbh
      21                leider
      22                leider
      23                leider
      24                leider
      25          cheries-baqu
      26          cheries-baqu
      27              ca-coity
      28              ca-coity
      
      [[3]]
                   clustered
      1                steel
      2                steel
      3             nitrogen
      4             nitrogen
      5                waste
      6                waste
      7                  car
      8                  car
      9               heater
      10              heater
      11              biogas
      12              biogas
      13          ice engine
      14          ice engine
      15              bricks
      16              bricks
      17                beer
      18                beer
      19              rubber
      20              rubber
      21 alcoholic aperitifs
      22 alcoholic aperitifs
      23           aperitifs
      24           aperitifs
      25        fresh cheese
      26        fresh cheese
      27               shoes
      28               shoes
      
      [[4]]
                                             activity_uuid_product_uuid
      1    0faa7ecb-fef2-5117-8993-387c1236-001e-49b5-aa3d-810c0214f9ce
      2    0faa7ecb-fef2-5117-8993-387c1236-001e-49b5-aa3d-810c0214f9ce
      3  03fbf989-9a1a-5e3d-a5bd-15f36f89b3-af52-4826-97f7-cc35f80f226f
      4  03fbf989-9a1a-5e3d-a5bd-15f36f89b3-af52-4826-97f7-cc35f80f226f
      5                                                            <NA>
      6                                                            <NA>
      7                                                            <NA>
      8                                                            <NA>
      9                                                            <NA>
      10                                                           <NA>
      11                                                           <NA>
      12                                                           <NA>
      13                                                           <NA>
      14                                                           <NA>
      15                                                           <NA>
      16                                                           <NA>
      17  011da854-af42-5570-a4506_136f89b3-af52-4826-97f7-cc35f80f226f
      18  011da854-af42-5570-a4506_136f89b3-af52-4826-97f7-cc35f80f226f
      19     a6478da4-5cd6-5c9e-a00e35863ed-da3f-4255-a90d-623066f43fd3
      20     a6478da4-5cd6-5c9e-a00e35863ed-da3f-4255-a90d-623066f43fd3
      21 063e488f-803a-5d13-af19-c_cf47d9e8-58e4-41f9-bde9-4f938fdc8c7b
      22 063e488f-803a-5d13-af19-c_cf47d9e8-58e4-41f9-bde9-4f938fdc8c7b
      23      61d00580-6742-5050-91e90c5322-b943-44d1-8f95-bc7e31a72990
      24      61d00580-6742-5050-91e90c5322-b943-44d1-8f95-bc7e31a72990
      25  6e2f5d7d-37d0-5548-a38c-1535863ed-da3f-4255-a90d-623066f43fd3
      26  6e2f5d7d-37d0-5548-a38c-1535863ed-da3f-4255-a90d-623066f43fd3
      27  6e2f5d7d-37d0-5548-a38c-1535863ed-da3f-4255-a90d-623066f43fd3
      28  6e2f5d7d-37d0-5548-a38c-1535863ed-da3f-4255-a90d-623066f43fd3
      
      [[5]]
         isic_4digit
      1         2410
      2         2410
      3         2029
      4         2029
      5         <NA>
      6         <NA>
      7         <NA>
      8         <NA>
      9         <NA>
      10        <NA>
      11        <NA>
      12        <NA>
      13        <NA>
      14        <NA>
      15        <NA>
      16        <NA>
      17        2029
      18        2029
      19        1050
      20        1050
      21        6758
      22        6758
      23        6758
      24        6758
      25        1050
      26        1050
      27        1050
      28        1050
      
      [[6]]
                   tilt_sector
      1                   <NA>
      2                   <NA>
      3                   <NA>
      4                   <NA>
      5                 energy
      6                 energy
      7         transportation
      8         transportation
      9  construction industry
      10 construction industry
      11                energy
      12                energy
      13        transportation
      14        transportation
      15 construction industry
      16 construction industry
      17                  <NA>
      18                  <NA>
      19                  <NA>
      20                  <NA>
      21                  <NA>
      22                  <NA>
      23                  <NA>
      24                  <NA>
      25                  <NA>
      26                  <NA>
      27                  <NA>
      28                  <NA>
      
      [[7]]
                 tilt_subsector
      1                    <NA>
      2                    <NA>
      3                    <NA>
      4                    <NA>
      5       bioenergy & waste
      6       bioenergy & waste
      7          transportation
      8          transportation
      9  construction buildings
      10 construction buildings
      11      bioenergy & waste
      12      bioenergy & waste
      13         transportation
      14         transportation
      15 construction buildings
      16 construction buildings
      17                   <NA>
      18                   <NA>
      19                   <NA>
      20                   <NA>
      21                   <NA>
      22                   <NA>
      23                   <NA>
      24                   <NA>
      25                   <NA>
      26                   <NA>
      27                   <NA>
      28                   <NA>
      
      [[8]]
         type
      1   ipr
      2   weo
      3   ipr
      4   weo
      5   ipr
      6   weo
      7   ipr
      8   weo
      9   ipr
      10  weo
      11  ipr
      12  weo
      13  ipr
      14  weo
      15  ipr
      16  weo
      17  ipr
      18  weo
      19  ipr
      20  weo
      21  ipr
      22  weo
      23  ipr
      24  weo
      25  ipr
      26  weo
      27  ipr
      28  weo
      
      [[9]]
                      sector
      1             industry
      2                total
      3             industry
      4                total
      5                total
      6  bioenergy and waste
      7            transport
      8                total
      9            buildings
      10               total
      11               total
      12 bioenergy and waste
      13           transport
      14               total
      15           buildings
      16               total
      17            industry
      18               total
      19            industry
      20               total
      21            industry
      22               total
      23            industry
      24               total
      25            industry
      26               total
      27            industry
      28               total
      
      [[10]]
                   subsector
      1       iron and steel
      2       iron and steel
      3            chemicals
      4            chemicals
      5               energy
      6  total energy supply
      7      other transport
      8            transport
      9                 <NA>
      10           buildings
      11              energy
      12 total energy supply
      13     other transport
      14           transport
      15                <NA>
      16           buildings
      17           chemicals
      18           chemicals
      19      other industry
      20            industry
      21      other industry
      22            industry
      23      other industry
      24            industry
      25      other industry
      26            industry
      27      other industry
      28            industry
      

# `pstr_scenarios` hasn't changed

    Code
      format_robust_snapshot(tiltIndicator::pstr_scenarios)
    Output
      [[1]]
                                     scenario
      1         1.5c required policy scenario
      2         1.5c required policy scenario
      3         1.5c required policy scenario
      4         1.5c required policy scenario
      5         1.5c required policy scenario
      6         1.5c required policy scenario
      7         1.5c required policy scenario
      8         1.5c required policy scenario
      9         1.5c required policy scenario
      10        1.5c required policy scenario
      11        1.5c required policy scenario
      12        1.5c required policy scenario
      13        1.5c required policy scenario
      14        1.5c required policy scenario
      15        1.5c required policy scenario
      16        1.5c required policy scenario
      17        1.5c required policy scenario
      18        1.5c required policy scenario
      19        1.5c required policy scenario
      20        1.5c required policy scenario
      21        1.5c required policy scenario
      22        1.5c required policy scenario
      23        1.5c required policy scenario
      24        1.5c required policy scenario
      25        1.5c required policy scenario
      26        1.5c required policy scenario
      27        1.5c required policy scenario
      28        1.5c required policy scenario
      29        1.5c required policy scenario
      30        1.5c required policy scenario
      31        1.5c required policy scenario
      32        1.5c required policy scenario
      33        1.5c required policy scenario
      34        1.5c required policy scenario
      35        1.5c required policy scenario
      36        1.5c required policy scenario
      37        1.5c required policy scenario
      38        1.5c required policy scenario
      39        1.5c required policy scenario
      40        1.5c required policy scenario
      41        1.5c required policy scenario
      42        1.5c required policy scenario
      43        1.5c required policy scenario
      44        1.5c required policy scenario
      45        1.5c required policy scenario
      46        1.5c required policy scenario
      47        1.5c required policy scenario
      48        1.5c required policy scenario
      49        1.5c required policy scenario
      50        1.5c required policy scenario
      51        1.5c required policy scenario
      52        1.5c required policy scenario
      53        1.5c required policy scenario
      54        1.5c required policy scenario
      55        1.5c required policy scenario
      56        1.5c required policy scenario
      57        1.5c required policy scenario
      58        1.5c required policy scenario
      59        1.5c required policy scenario
      60        1.5c required policy scenario
      61        1.5c required policy scenario
      62        1.5c required policy scenario
      63        1.5c required policy scenario
      64        1.5c required policy scenario
      65        1.5c required policy scenario
      66        1.5c required policy scenario
      67        1.5c required policy scenario
      68        1.5c required policy scenario
      69        1.5c required policy scenario
      70        1.5c required policy scenario
      71        1.5c required policy scenario
      72        1.5c required policy scenario
      73        1.5c required policy scenario
      74        1.5c required policy scenario
      75        1.5c required policy scenario
      76        1.5c required policy scenario
      77        1.5c required policy scenario
      78        1.5c required policy scenario
      79        1.5c required policy scenario
      80        1.5c required policy scenario
      81        1.5c required policy scenario
      82        1.5c required policy scenario
      83        1.5c required policy scenario
      84        1.5c required policy scenario
      85        1.5c required policy scenario
      86        1.5c required policy scenario
      87        1.5c required policy scenario
      88        1.5c required policy scenario
      89        1.5c required policy scenario
      90        1.5c required policy scenario
      91        1.5c required policy scenario
      92        1.5c required policy scenario
      93        1.5c required policy scenario
      94        1.5c required policy scenario
      95        1.5c required policy scenario
      96        1.5c required policy scenario
      97        1.5c required policy scenario
      98        1.5c required policy scenario
      99        1.5c required policy scenario
      100       1.5c required policy scenario
      101       1.5c required policy scenario
      102       1.5c required policy scenario
      103       1.5c required policy scenario
      104       1.5c required policy scenario
      105       1.5c required policy scenario
      106       1.5c required policy scenario
      107       1.5c required policy scenario
      108       1.5c required policy scenario
      109       1.5c required policy scenario
      110       1.5c required policy scenario
      111       1.5c required policy scenario
      112       1.5c required policy scenario
      113            stated policies scenario
      114            stated policies scenario
      115            stated policies scenario
      116            stated policies scenario
      117            stated policies scenario
      118            stated policies scenario
      119            stated policies scenario
      120            stated policies scenario
      121            stated policies scenario
      122            stated policies scenario
      123            stated policies scenario
      124            stated policies scenario
      125            stated policies scenario
      126            stated policies scenario
      127            stated policies scenario
      128            stated policies scenario
      129            stated policies scenario
      130            stated policies scenario
      131            stated policies scenario
      132            stated policies scenario
      133            stated policies scenario
      134            stated policies scenario
      135            stated policies scenario
      136            stated policies scenario
      137            stated policies scenario
      138            stated policies scenario
      139            stated policies scenario
      140            stated policies scenario
      141            stated policies scenario
      142            stated policies scenario
      143            stated policies scenario
      144            stated policies scenario
      145            stated policies scenario
      146            stated policies scenario
      147            stated policies scenario
      148            stated policies scenario
      149            stated policies scenario
      150            stated policies scenario
      151            stated policies scenario
      152            stated policies scenario
      153            stated policies scenario
      154            stated policies scenario
      155            stated policies scenario
      156            stated policies scenario
      157            stated policies scenario
      158            stated policies scenario
      159            stated policies scenario
      160            stated policies scenario
      161            stated policies scenario
      162            stated policies scenario
      163            stated policies scenario
      164            stated policies scenario
      165            stated policies scenario
      166            stated policies scenario
      167            stated policies scenario
      168            stated policies scenario
      169            stated policies scenario
      170            stated policies scenario
      171            stated policies scenario
      172            stated policies scenario
      173            stated policies scenario
      174            stated policies scenario
      175            stated policies scenario
      176            stated policies scenario
      177            stated policies scenario
      178            stated policies scenario
      179            stated policies scenario
      180            stated policies scenario
      181            stated policies scenario
      182            stated policies scenario
      183            stated policies scenario
      184            stated policies scenario
      185            stated policies scenario
      186            stated policies scenario
      187            stated policies scenario
      188            stated policies scenario
      189            stated policies scenario
      190            stated policies scenario
      191            stated policies scenario
      192            stated policies scenario
      193            stated policies scenario
      194            stated policies scenario
      195            stated policies scenario
      196            stated policies scenario
      197            stated policies scenario
      198            stated policies scenario
      199            stated policies scenario
      200            stated policies scenario
      201            stated policies scenario
      202            stated policies scenario
      203            stated policies scenario
      204            stated policies scenario
      205            stated policies scenario
      206            stated policies scenario
      207            stated policies scenario
      208            stated policies scenario
      209            stated policies scenario
      210            stated policies scenario
      211            stated policies scenario
      212            stated policies scenario
      213            stated policies scenario
      214            stated policies scenario
      215            stated policies scenario
      216            stated policies scenario
      217            stated policies scenario
      218            stated policies scenario
      219            stated policies scenario
      220            stated policies scenario
      221            stated policies scenario
      222            stated policies scenario
      223            stated policies scenario
      224            stated policies scenario
      225            stated policies scenario
      226            stated policies scenario
      227            stated policies scenario
      228            stated policies scenario
      229            stated policies scenario
      230            stated policies scenario
      231            stated policies scenario
      232            stated policies scenario
      233            stated policies scenario
      234            stated policies scenario
      235            stated policies scenario
      236            stated policies scenario
      237          announced pledges scenario
      238          announced pledges scenario
      239          announced pledges scenario
      240          announced pledges scenario
      241          announced pledges scenario
      242          announced pledges scenario
      243          announced pledges scenario
      244          announced pledges scenario
      245          announced pledges scenario
      246          announced pledges scenario
      247          announced pledges scenario
      248          announced pledges scenario
      249          announced pledges scenario
      250          announced pledges scenario
      251          announced pledges scenario
      252          announced pledges scenario
      253          announced pledges scenario
      254          announced pledges scenario
      255          announced pledges scenario
      256          announced pledges scenario
      257          announced pledges scenario
      258          announced pledges scenario
      259          announced pledges scenario
      260          announced pledges scenario
      261          announced pledges scenario
      262          announced pledges scenario
      263          announced pledges scenario
      264          announced pledges scenario
      265          announced pledges scenario
      266          announced pledges scenario
      267          announced pledges scenario
      268          announced pledges scenario
      269          announced pledges scenario
      270          announced pledges scenario
      271          announced pledges scenario
      272          announced pledges scenario
      273          announced pledges scenario
      274          announced pledges scenario
      275          announced pledges scenario
      276          announced pledges scenario
      277          announced pledges scenario
      278          announced pledges scenario
      279          announced pledges scenario
      280          announced pledges scenario
      281          announced pledges scenario
      282          announced pledges scenario
      283          announced pledges scenario
      284          announced pledges scenario
      285          announced pledges scenario
      286          announced pledges scenario
      287          announced pledges scenario
      288          announced pledges scenario
      289          announced pledges scenario
      290          announced pledges scenario
      291          announced pledges scenario
      292          announced pledges scenario
      293          announced pledges scenario
      294          announced pledges scenario
      295          announced pledges scenario
      296          announced pledges scenario
      297          announced pledges scenario
      298          announced pledges scenario
      299          announced pledges scenario
      300          announced pledges scenario
      301          announced pledges scenario
      302          announced pledges scenario
      303          announced pledges scenario
      304          announced pledges scenario
      305          announced pledges scenario
      306          announced pledges scenario
      307          announced pledges scenario
      308          announced pledges scenario
      309          announced pledges scenario
      310          announced pledges scenario
      311          announced pledges scenario
      312          announced pledges scenario
      313          announced pledges scenario
      314          announced pledges scenario
      315          announced pledges scenario
      316          announced pledges scenario
      317          announced pledges scenario
      318          announced pledges scenario
      319          announced pledges scenario
      320          announced pledges scenario
      321          announced pledges scenario
      322          announced pledges scenario
      323          announced pledges scenario
      324          announced pledges scenario
      325          announced pledges scenario
      326          announced pledges scenario
      327          announced pledges scenario
      328          announced pledges scenario
      329          announced pledges scenario
      330          announced pledges scenario
      331          announced pledges scenario
      332          announced pledges scenario
      333          announced pledges scenario
      334          announced pledges scenario
      335          announced pledges scenario
      336          announced pledges scenario
      337          announced pledges scenario
      338          announced pledges scenario
      339          announced pledges scenario
      340          announced pledges scenario
      341          announced pledges scenario
      342          announced pledges scenario
      343          announced pledges scenario
      344          announced pledges scenario
      345          announced pledges scenario
      346          announced pledges scenario
      347          announced pledges scenario
      348          announced pledges scenario
      349          announced pledges scenario
      350          announced pledges scenario
      351          announced pledges scenario
      352          announced pledges scenario
      353          announced pledges scenario
      354          announced pledges scenario
      355          announced pledges scenario
      356          announced pledges scenario
      357          announced pledges scenario
      358          announced pledges scenario
      359          announced pledges scenario
      360          announced pledges scenario
      361 net zero emissions by 2050 scenario
      362 net zero emissions by 2050 scenario
      363 net zero emissions by 2050 scenario
      364 net zero emissions by 2050 scenario
      365 net zero emissions by 2050 scenario
      366 net zero emissions by 2050 scenario
      367 net zero emissions by 2050 scenario
      368 net zero emissions by 2050 scenario
      369 net zero emissions by 2050 scenario
      370 net zero emissions by 2050 scenario
      371 net zero emissions by 2050 scenario
      372 net zero emissions by 2050 scenario
      373 net zero emissions by 2050 scenario
      374 net zero emissions by 2050 scenario
      375 net zero emissions by 2050 scenario
      376 net zero emissions by 2050 scenario
      377 net zero emissions by 2050 scenario
      378 net zero emissions by 2050 scenario
      379 net zero emissions by 2050 scenario
      380 net zero emissions by 2050 scenario
      381 net zero emissions by 2050 scenario
      382 net zero emissions by 2050 scenario
      383 net zero emissions by 2050 scenario
      384 net zero emissions by 2050 scenario
      385 net zero emissions by 2050 scenario
      386 net zero emissions by 2050 scenario
      387 net zero emissions by 2050 scenario
      388 net zero emissions by 2050 scenario
      389 net zero emissions by 2050 scenario
      390 net zero emissions by 2050 scenario
      391 net zero emissions by 2050 scenario
      392 net zero emissions by 2050 scenario
      393 net zero emissions by 2050 scenario
      394 net zero emissions by 2050 scenario
      395 net zero emissions by 2050 scenario
      396 net zero emissions by 2050 scenario
      397 net zero emissions by 2050 scenario
      398 net zero emissions by 2050 scenario
      399 net zero emissions by 2050 scenario
      400 net zero emissions by 2050 scenario
      401 net zero emissions by 2050 scenario
      402 net zero emissions by 2050 scenario
      403 net zero emissions by 2050 scenario
      404 net zero emissions by 2050 scenario
      405 net zero emissions by 2050 scenario
      406 net zero emissions by 2050 scenario
      407 net zero emissions by 2050 scenario
      408 net zero emissions by 2050 scenario
      409 net zero emissions by 2050 scenario
      410 net zero emissions by 2050 scenario
      411 net zero emissions by 2050 scenario
      412 net zero emissions by 2050 scenario
      413 net zero emissions by 2050 scenario
      414 net zero emissions by 2050 scenario
      415 net zero emissions by 2050 scenario
      416 net zero emissions by 2050 scenario
      417 net zero emissions by 2050 scenario
      418 net zero emissions by 2050 scenario
      419 net zero emissions by 2050 scenario
      420 net zero emissions by 2050 scenario
      421 net zero emissions by 2050 scenario
      422 net zero emissions by 2050 scenario
      423 net zero emissions by 2050 scenario
      424 net zero emissions by 2050 scenario
      425 net zero emissions by 2050 scenario
      426 net zero emissions by 2050 scenario
      427 net zero emissions by 2050 scenario
      428 net zero emissions by 2050 scenario
      429 net zero emissions by 2050 scenario
      430 net zero emissions by 2050 scenario
      431 net zero emissions by 2050 scenario
      432 net zero emissions by 2050 scenario
      433 net zero emissions by 2050 scenario
      434 net zero emissions by 2050 scenario
      435 net zero emissions by 2050 scenario
      436 net zero emissions by 2050 scenario
      437 net zero emissions by 2050 scenario
      438 net zero emissions by 2050 scenario
      439 net zero emissions by 2050 scenario
      440 net zero emissions by 2050 scenario
      441 net zero emissions by 2050 scenario
      442 net zero emissions by 2050 scenario
      443 net zero emissions by 2050 scenario
      444 net zero emissions by 2050 scenario
      445 net zero emissions by 2050 scenario
      446 net zero emissions by 2050 scenario
      447 net zero emissions by 2050 scenario
      448 net zero emissions by 2050 scenario
      449 net zero emissions by 2050 scenario
      450 net zero emissions by 2050 scenario
      451 net zero emissions by 2050 scenario
      452 net zero emissions by 2050 scenario
      453 net zero emissions by 2050 scenario
      454 net zero emissions by 2050 scenario
      455 net zero emissions by 2050 scenario
      456 net zero emissions by 2050 scenario
      457 net zero emissions by 2050 scenario
      458 net zero emissions by 2050 scenario
      459 net zero emissions by 2050 scenario
      460 net zero emissions by 2050 scenario
      461 net zero emissions by 2050 scenario
      462 net zero emissions by 2050 scenario
      463 net zero emissions by 2050 scenario
      464 net zero emissions by 2050 scenario
      465 net zero emissions by 2050 scenario
      466 net zero emissions by 2050 scenario
      467 net zero emissions by 2050 scenario
      468 net zero emissions by 2050 scenario
      469 net zero emissions by 2050 scenario
      470 net zero emissions by 2050 scenario
      471 net zero emissions by 2050 scenario
      472 net zero emissions by 2050 scenario
      473 net zero emissions by 2050 scenario
      474 net zero emissions by 2050 scenario
      475 net zero emissions by 2050 scenario
      476 net zero emissions by 2050 scenario
      477 net zero emissions by 2050 scenario
      478 net zero emissions by 2050 scenario
      479 net zero emissions by 2050 scenario
      480 net zero emissions by 2050 scenario
      481 net zero emissions by 2050 scenario
      482 net zero emissions by 2050 scenario
      483 net zero emissions by 2050 scenario
      484 net zero emissions by 2050 scenario
      
      [[2]]
                        region
      1   western europe (weu)
      2   western europe (weu)
      3   western europe (weu)
      4   western europe (weu)
      5   western europe (weu)
      6   western europe (weu)
      7   western europe (weu)
      8   western europe (weu)
      9   western europe (weu)
      10  western europe (weu)
      11  western europe (weu)
      12  western europe (weu)
      13  western europe (weu)
      14  western europe (weu)
      15  western europe (weu)
      16  western europe (weu)
      17  western europe (weu)
      18  western europe (weu)
      19  western europe (weu)
      20  western europe (weu)
      21  western europe (weu)
      22  western europe (weu)
      23  western europe (weu)
      24  western europe (weu)
      25  western europe (weu)
      26  western europe (weu)
      27  western europe (weu)
      28  western europe (weu)
      29  western europe (weu)
      30  western europe (weu)
      31  western europe (weu)
      32  western europe (weu)
      33  western europe (weu)
      34  western europe (weu)
      35  western europe (weu)
      36  western europe (weu)
      37  western europe (weu)
      38  western europe (weu)
      39  western europe (weu)
      40  western europe (weu)
      41  western europe (weu)
      42  western europe (weu)
      43  western europe (weu)
      44  western europe (weu)
      45  western europe (weu)
      46  western europe (weu)
      47  western europe (weu)
      48  western europe (weu)
      49  western europe (weu)
      50  western europe (weu)
      51  western europe (weu)
      52  western europe (weu)
      53                 world
      54                 world
      55                 world
      56                 world
      57                 world
      58                 world
      59                 world
      60                 world
      61                 world
      62                 world
      63                 world
      64                 world
      65                 world
      66                 world
      67                 world
      68                 world
      69                 world
      70                 world
      71                 world
      72                 world
      73                 world
      74                 world
      75                 world
      76                 world
      77                 world
      78                 world
      79                 world
      80                 world
      81                 world
      82                 world
      83                 world
      84                 world
      85                 world
      86                 world
      87                 world
      88                 world
      89                 world
      90                 world
      91                 world
      92                 world
      93                 world
      94                 world
      95                 world
      96                 world
      97                 world
      98                 world
      99                 world
      100                world
      101                world
      102                world
      103                world
      104                world
      105                world
      106                world
      107                world
      108                world
      109                world
      110                world
      111                world
      112                world
      113                world
      114                world
      115                world
      116                world
      117                world
      118                world
      119                world
      120                world
      121                world
      122                world
      123                world
      124                world
      125                world
      126                world
      127                world
      128                world
      129                world
      130                world
      131                world
      132                world
      133                world
      134                world
      135                world
      136                world
      137                world
      138                world
      139                world
      140                world
      141                world
      142                world
      143                world
      144                world
      145                world
      146                world
      147                world
      148                world
      149                world
      150                world
      151                world
      152                world
      153                world
      154                world
      155                world
      156                world
      157                world
      158                world
      159                world
      160                world
      161                world
      162                world
      163                world
      164                world
      165                world
      166                world
      167                world
      168                world
      169                world
      170                world
      171                world
      172                world
      173                world
      174                world
      175                world
      176                world
      177                world
      178                world
      179                world
      180                world
      181                world
      182                world
      183                world
      184                world
      185                world
      186                world
      187                world
      188                world
      189                world
      190                world
      191                world
      192                world
      193                world
      194                world
      195                world
      196                world
      197                world
      198                world
      199                world
      200                world
      201                world
      202                world
      203                world
      204                world
      205                world
      206                world
      207                world
      208                world
      209                world
      210                world
      211                world
      212                world
      213                world
      214                world
      215                world
      216                world
      217                world
      218                world
      219                world
      220                world
      221                world
      222                world
      223                world
      224                world
      225                world
      226                world
      227                world
      228                world
      229                world
      230                world
      231                world
      232                world
      233                world
      234                world
      235                world
      236                world
      237                world
      238                world
      239                world
      240                world
      241                world
      242                world
      243                world
      244                world
      245                world
      246                world
      247                world
      248                world
      249                world
      250                world
      251                world
      252                world
      253                world
      254                world
      255                world
      256                world
      257                world
      258                world
      259                world
      260                world
      261                world
      262                world
      263                world
      264                world
      265                world
      266                world
      267                world
      268                world
      269                world
      270                world
      271                world
      272                world
      273                world
      274                world
      275                world
      276                world
      277                world
      278                world
      279                world
      280                world
      281                world
      282                world
      283                world
      284                world
      285                world
      286                world
      287                world
      288                world
      289                world
      290                world
      291                world
      292                world
      293                world
      294                world
      295                world
      296                world
      297                world
      298                world
      299                world
      300                world
      301                world
      302                world
      303                world
      304                world
      305                world
      306                world
      307                world
      308                world
      309                world
      310                world
      311                world
      312                world
      313                world
      314                world
      315                world
      316                world
      317                world
      318                world
      319                world
      320                world
      321                world
      322                world
      323                world
      324                world
      325                world
      326                world
      327                world
      328                world
      329                world
      330                world
      331                world
      332                world
      333                world
      334                world
      335                world
      336                world
      337                world
      338                world
      339                world
      340                world
      341                world
      342                world
      343                world
      344                world
      345                world
      346                world
      347                world
      348                world
      349                world
      350                world
      351                world
      352                world
      353                world
      354                world
      355                world
      356                world
      357                world
      358                world
      359                world
      360                world
      361                world
      362                world
      363                world
      364                world
      365                world
      366                world
      367                world
      368                world
      369                world
      370                world
      371                world
      372                world
      373                world
      374                world
      375                world
      376                world
      377                world
      378                world
      379                world
      380                world
      381                world
      382                world
      383                world
      384                world
      385                world
      386                world
      387                world
      388                world
      389                world
      390                world
      391                world
      392                world
      393                world
      394                world
      395                world
      396                world
      397                world
      398                world
      399                world
      400                world
      401                world
      402                world
      403                world
      404                world
      405                world
      406                world
      407                world
      408                world
      409                world
      410                world
      411                world
      412                world
      413                world
      414                world
      415                world
      416                world
      417                world
      418                world
      419                world
      420                world
      421                world
      422                world
      423                world
      424                world
      425                world
      426                world
      427                world
      428                world
      429                world
      430                world
      431                world
      432                world
      433                world
      434                world
      435                world
      436                world
      437                world
      438                world
      439                world
      440                world
      441                world
      442                world
      443                world
      444                world
      445                world
      446                world
      447                world
      448                world
      449                world
      450                world
      451                world
      452                world
      453                world
      454                world
      455                world
      456                world
      457                world
      458                world
      459                world
      460                world
      461                world
      462                world
      463                world
      464                world
      465                world
      466                world
      467                world
      468                world
      469                world
      470                world
      471                world
      472                world
      473                world
      474                world
      475                world
      476                world
      477                world
      478                world
      479                world
      480                world
      481                world
      482                world
      483                world
      484                world
      
      [[3]]
                       sector
      1                 power
      2                 power
      3                 power
      4                 power
      5             buildings
      6             buildings
      7             buildings
      8             buildings
      9              industry
      10             industry
      11             industry
      12             industry
      13             industry
      14             industry
      15             industry
      16             industry
      17             industry
      18             industry
      19             industry
      20             industry
      21             industry
      22             industry
      23             industry
      24             industry
      25            transport
      26            transport
      27            transport
      28            transport
      29            transport
      30            transport
      31            transport
      32            transport
      33            transport
      34            transport
      35            transport
      36            transport
      37            transport
      38            transport
      39            transport
      40            transport
      41            transport
      42            transport
      43            transport
      44            transport
      45         other energy
      46         other energy
      47         other energy
      48         other energy
      49                total
      50                total
      51                total
      52                total
      53                 <NA>
      54                 <NA>
      55                 <NA>
      56                 <NA>
      57                power
      58                power
      59                power
      60                power
      61            buildings
      62            buildings
      63            buildings
      64            buildings
      65             industry
      66             industry
      67             industry
      68             industry
      69             industry
      70             industry
      71             industry
      72             industry
      73             industry
      74             industry
      75             industry
      76             industry
      77             industry
      78             industry
      79             industry
      80             industry
      81            transport
      82            transport
      83            transport
      84            transport
      85            transport
      86            transport
      87            transport
      88            transport
      89            transport
      90            transport
      91            transport
      92            transport
      93            transport
      94            transport
      95            transport
      96            transport
      97            transport
      98            transport
      99            transport
      100           transport
      101        other energy
      102        other energy
      103        other energy
      104        other energy
      105               total
      106               total
      107               total
      108               total
      109                <NA>
      110                <NA>
      111                <NA>
      112                <NA>
      113               total
      114               total
      115               total
      116               total
      117                coal
      118                coal
      119                coal
      120                coal
      121                 oil
      122                 oil
      123                 oil
      124                 oil
      125         natural gas
      126         natural gas
      127         natural gas
      128         natural gas
      129 bioenergy and waste
      130 bioenergy and waste
      131 bioenergy and waste
      132 bioenergy and waste
      133               total
      134               total
      135               total
      136               total
      137               total
      138               total
      139               total
      140               total
      141                coal
      142                coal
      143                coal
      144                coal
      145                 oil
      146                 oil
      147                 oil
      148                 oil
      149         natural gas
      150         natural gas
      151         natural gas
      152         natural gas
      153 bioenergy and waste
      154 bioenergy and waste
      155 bioenergy and waste
      156 bioenergy and waste
      157               total
      158               total
      159               total
      160               total
      161               total
      162               total
      163               total
      164               total
      165                coal
      166                coal
      167                coal
      168                coal
      169                 oil
      170                 oil
      171                 oil
      172                 oil
      173         natural gas
      174         natural gas
      175         natural gas
      176         natural gas
      177 bioenergy and waste
      178 bioenergy and waste
      179 bioenergy and waste
      180 bioenergy and waste
      181               total
      182               total
      183               total
      184               total
      185               total
      186               total
      187               total
      188               total
      189               total
      190               total
      191               total
      192               total
      193               total
      194               total
      195               total
      196               total
      197               total
      198               total
      199               total
      200               total
      201               total
      202               total
      203               total
      204               total
      205               total
      206               total
      207               total
      208               total
      209               total
      210               total
      211               total
      212               total
      213               total
      214               total
      215               total
      216               total
      217               total
      218               total
      219               total
      220               total
      221               total
      222               total
      223               total
      224               total
      225               total
      226               total
      227               total
      228               total
      229               total
      230               total
      231               total
      232               total
      233               total
      234               total
      235               total
      236               total
      237               total
      238               total
      239               total
      240               total
      241                coal
      242                coal
      243                coal
      244                coal
      245                 oil
      246                 oil
      247                 oil
      248                 oil
      249         natural gas
      250         natural gas
      251         natural gas
      252         natural gas
      253 bioenergy and waste
      254 bioenergy and waste
      255 bioenergy and waste
      256 bioenergy and waste
      257               total
      258               total
      259               total
      260               total
      261               total
      262               total
      263               total
      264               total
      265                coal
      266                coal
      267                coal
      268                coal
      269                 oil
      270                 oil
      271                 oil
      272                 oil
      273         natural gas
      274         natural gas
      275         natural gas
      276         natural gas
      277 bioenergy and waste
      278 bioenergy and waste
      279 bioenergy and waste
      280 bioenergy and waste
      281               total
      282               total
      283               total
      284               total
      285               total
      286               total
      287               total
      288               total
      289                coal
      290                coal
      291                coal
      292                coal
      293                 oil
      294                 oil
      295                 oil
      296                 oil
      297         natural gas
      298         natural gas
      299         natural gas
      300         natural gas
      301 bioenergy and waste
      302 bioenergy and waste
      303 bioenergy and waste
      304 bioenergy and waste
      305               total
      306               total
      307               total
      308               total
      309               total
      310               total
      311               total
      312               total
      313               total
      314               total
      315               total
      316               total
      317               total
      318               total
      319               total
      320               total
      321               total
      322               total
      323               total
      324               total
      325               total
      326               total
      327               total
      328               total
      329               total
      330               total
      331               total
      332               total
      333               total
      334               total
      335               total
      336               total
      337               total
      338               total
      339               total
      340               total
      341               total
      342               total
      343               total
      344               total
      345               total
      346               total
      347               total
      348               total
      349               total
      350               total
      351               total
      352               total
      353               total
      354               total
      355               total
      356               total
      357               total
      358               total
      359               total
      360               total
      361               total
      362               total
      363               total
      364               total
      365                coal
      366                coal
      367                coal
      368                coal
      369                 oil
      370                 oil
      371                 oil
      372                 oil
      373         natural gas
      374         natural gas
      375         natural gas
      376         natural gas
      377 bioenergy and waste
      378 bioenergy and waste
      379 bioenergy and waste
      380 bioenergy and waste
      381               total
      382               total
      383               total
      384               total
      385               total
      386               total
      387               total
      388               total
      389                coal
      390                coal
      391                coal
      392                coal
      393                 oil
      394                 oil
      395                 oil
      396                 oil
      397         natural gas
      398         natural gas
      399         natural gas
      400         natural gas
      401 bioenergy and waste
      402 bioenergy and waste
      403 bioenergy and waste
      404 bioenergy and waste
      405               total
      406               total
      407               total
      408               total
      409               total
      410               total
      411               total
      412               total
      413                coal
      414                coal
      415                coal
      416                coal
      417                 oil
      418                 oil
      419                 oil
      420                 oil
      421         natural gas
      422         natural gas
      423         natural gas
      424         natural gas
      425 bioenergy and waste
      426 bioenergy and waste
      427 bioenergy and waste
      428 bioenergy and waste
      429               total
      430               total
      431               total
      432               total
      433               total
      434               total
      435               total
      436               total
      437               total
      438               total
      439               total
      440               total
      441               total
      442               total
      443               total
      444               total
      445               total
      446               total
      447               total
      448               total
      449               total
      450               total
      451               total
      452               total
      453               total
      454               total
      455               total
      456               total
      457               total
      458               total
      459               total
      460               total
      461               total
      462               total
      463               total
      464               total
      465               total
      466               total
      467               total
      468               total
      469               total
      470               total
      471               total
      472               total
      473               total
      474               total
      475               total
      476               total
      477               total
      478               total
      479               total
      480               total
      481               total
      482               total
      483               total
      484               total
      
      [[4]]
                                           subsector
      1                                         <NA>
      2                                         <NA>
      3                                         <NA>
      4                                         <NA>
      5                                         <NA>
      6                                         <NA>
      7                                         <NA>
      8                                         <NA>
      9                               iron and steel
      10                              iron and steel
      11                              iron and steel
      12                              iron and steel
      13                       non-metallic minerals
      14                       non-metallic minerals
      15                       non-metallic minerals
      16                       non-metallic minerals
      17                                   chemicals
      18                                   chemicals
      19                                   chemicals
      20                                   chemicals
      21                              other industry
      22                              other industry
      23                              other industry
      24                              other industry
      25                                        cars
      26                                        cars
      27                                        cars
      28                                        cars
      29                                      trucks
      30                                      trucks
      31                                      trucks
      32                                      trucks
      33                                    aviation
      34                                    aviation
      35                                    aviation
      36                                    aviation
      37                                    shipping
      38                                    shipping
      39                                    shipping
      40                                    shipping
      41                             other transport
      42                             other transport
      43                             other transport
      44                             other transport
      45                                        <NA>
      46                                        <NA>
      47                                        <NA>
      48                                        <NA>
      49                                      energy
      50                                      energy
      51                                      energy
      52                                      energy
      53                                    land use
      54                                    land use
      55                                    land use
      56                                    land use
      57                                        <NA>
      58                                        <NA>
      59                                        <NA>
      60                                        <NA>
      61                                        <NA>
      62                                        <NA>
      63                                        <NA>
      64                                        <NA>
      65                              iron and steel
      66                              iron and steel
      67                              iron and steel
      68                              iron and steel
      69                       non-metallic minerals
      70                       non-metallic minerals
      71                       non-metallic minerals
      72                       non-metallic minerals
      73                                   chemicals
      74                                   chemicals
      75                                   chemicals
      76                                   chemicals
      77                              other industry
      78                              other industry
      79                              other industry
      80                              other industry
      81                                        cars
      82                                        cars
      83                                        cars
      84                                        cars
      85                                      trucks
      86                                      trucks
      87                                      trucks
      88                                      trucks
      89                                    aviation
      90                                    aviation
      91                                    aviation
      92                                    aviation
      93                                    shipping
      94                                    shipping
      95                                    shipping
      96                                    shipping
      97                             other transport
      98                             other transport
      99                             other transport
      100                            other transport
      101                                       <NA>
      102                                       <NA>
      103                                       <NA>
      104                                       <NA>
      105                                     energy
      106                                     energy
      107                                     energy
      108                                     energy
      109                                   land use
      110                                   land use
      111                                   land use
      112                                   land use
      113                        total energy supply
      114                        total energy supply
      115                        total energy supply
      116                        total energy supply
      117                        total energy supply
      118                        total energy supply
      119                        total energy supply
      120                        total energy supply
      121                        total energy supply
      122                        total energy supply
      123                        total energy supply
      124                        total energy supply
      125                        total energy supply
      126                        total energy supply
      127                        total energy supply
      128                        total energy supply
      129                        total energy supply
      130                        total energy supply
      131                        total energy supply
      132                        total energy supply
      133 biofuels production and direct air capture
      134 biofuels production and direct air capture
      135 biofuels production and direct air capture
      136 biofuels production and direct air capture
      137                        power sector inputs
      138                        power sector inputs
      139                        power sector inputs
      140                        power sector inputs
      141                        power sector inputs
      142                        power sector inputs
      143                        power sector inputs
      144                        power sector inputs
      145                        power sector inputs
      146                        power sector inputs
      147                        power sector inputs
      148                        power sector inputs
      149                        power sector inputs
      150                        power sector inputs
      151                        power sector inputs
      152                        power sector inputs
      153                        power sector inputs
      154                        power sector inputs
      155                        power sector inputs
      156                        power sector inputs
      157                        other energy sector
      158                        other energy sector
      159                        other energy sector
      160                        other energy sector
      161                    total final consumption
      162                    total final consumption
      163                    total final consumption
      164                    total final consumption
      165                    total final consumption
      166                    total final consumption
      167                    total final consumption
      168                    total final consumption
      169                    total final consumption
      170                    total final consumption
      171                    total final consumption
      172                    total final consumption
      173                    total final consumption
      174                    total final consumption
      175                    total final consumption
      176                    total final consumption
      177                    total final consumption
      178                    total final consumption
      179                    total final consumption
      180                    total final consumption
      181                                   industry
      182                                   industry
      183                                   industry
      184                                   industry
      185                             iron and steel
      186                             iron and steel
      187                             iron and steel
      188                             iron and steel
      189                                  chemicals
      190                                  chemicals
      191                                  chemicals
      192                                  chemicals
      193              non-metallic minerals: cement
      194              non-metallic minerals: cement
      195              non-metallic minerals: cement
      196              non-metallic minerals: cement
      197                                  transport
      198                                  transport
      199                                  transport
      200                                  transport
      201                                       road
      202                                       road
      203                                       road
      204                                       road
      205          road passenger light duty vehicle
      206          road passenger light duty vehicle
      207          road passenger light duty vehicle
      208          road passenger light duty vehicle
      209                     road heavy-duty trucks
      210                     road heavy-duty trucks
      211                     road heavy-duty trucks
      212                     road heavy-duty trucks
      213      total aviation (domestic and bunkers)
      214      total aviation (domestic and bunkers)
      215      total aviation (domestic and bunkers)
      216      total aviation (domestic and bunkers)
      217    total navigation (domestic and bunkers)
      218    total navigation (domestic and bunkers)
      219    total navigation (domestic and bunkers)
      220    total navigation (domestic and bunkers)
      221                                  buildings
      222                                  buildings
      223                                  buildings
      224                                  buildings
      225                                residential
      226                                residential
      227                                residential
      228                                residential
      229                                   services
      230                                   services
      231                                   services
      232                                   services
      233                        total energy supply
      234                        total energy supply
      235                        total energy supply
      236                        total energy supply
      237                        total energy supply
      238                        total energy supply
      239                        total energy supply
      240                        total energy supply
      241                        total energy supply
      242                        total energy supply
      243                        total energy supply
      244                        total energy supply
      245                        total energy supply
      246                        total energy supply
      247                        total energy supply
      248                        total energy supply
      249                        total energy supply
      250                        total energy supply
      251                        total energy supply
      252                        total energy supply
      253                        total energy supply
      254                        total energy supply
      255                        total energy supply
      256                        total energy supply
      257 biofuels production and direct air capture
      258 biofuels production and direct air capture
      259 biofuels production and direct air capture
      260 biofuels production and direct air capture
      261                        power sector inputs
      262                        power sector inputs
      263                        power sector inputs
      264                        power sector inputs
      265                        power sector inputs
      266                        power sector inputs
      267                        power sector inputs
      268                        power sector inputs
      269                        power sector inputs
      270                        power sector inputs
      271                        power sector inputs
      272                        power sector inputs
      273                        power sector inputs
      274                        power sector inputs
      275                        power sector inputs
      276                        power sector inputs
      277                        power sector inputs
      278                        power sector inputs
      279                        power sector inputs
      280                        power sector inputs
      281                        other energy sector
      282                        other energy sector
      283                        other energy sector
      284                        other energy sector
      285                    total final consumption
      286                    total final consumption
      287                    total final consumption
      288                    total final consumption
      289                    total final consumption
      290                    total final consumption
      291                    total final consumption
      292                    total final consumption
      293                    total final consumption
      294                    total final consumption
      295                    total final consumption
      296                    total final consumption
      297                    total final consumption
      298                    total final consumption
      299                    total final consumption
      300                    total final consumption
      301                    total final consumption
      302                    total final consumption
      303                    total final consumption
      304                    total final consumption
      305                                   industry
      306                                   industry
      307                                   industry
      308                                   industry
      309                             iron and steel
      310                             iron and steel
      311                             iron and steel
      312                             iron and steel
      313                                  chemicals
      314                                  chemicals
      315                                  chemicals
      316                                  chemicals
      317              non-metallic minerals: cement
      318              non-metallic minerals: cement
      319              non-metallic minerals: cement
      320              non-metallic minerals: cement
      321                                  transport
      322                                  transport
      323                                  transport
      324                                  transport
      325                                       road
      326                                       road
      327                                       road
      328                                       road
      329          road passenger light duty vehicle
      330          road passenger light duty vehicle
      331          road passenger light duty vehicle
      332          road passenger light duty vehicle
      333                     road heavy-duty trucks
      334                     road heavy-duty trucks
      335                     road heavy-duty trucks
      336                     road heavy-duty trucks
      337      total aviation (domestic and bunkers)
      338      total aviation (domestic and bunkers)
      339      total aviation (domestic and bunkers)
      340      total aviation (domestic and bunkers)
      341    total navigation (domestic and bunkers)
      342    total navigation (domestic and bunkers)
      343    total navigation (domestic and bunkers)
      344    total navigation (domestic and bunkers)
      345                                  buildings
      346                                  buildings
      347                                  buildings
      348                                  buildings
      349                                residential
      350                                residential
      351                                residential
      352                                residential
      353                                   services
      354                                   services
      355                                   services
      356                                   services
      357                        total energy supply
      358                        total energy supply
      359                        total energy supply
      360                        total energy supply
      361                        total energy supply
      362                        total energy supply
      363                        total energy supply
      364                        total energy supply
      365                        total energy supply
      366                        total energy supply
      367                        total energy supply
      368                        total energy supply
      369                        total energy supply
      370                        total energy supply
      371                        total energy supply
      372                        total energy supply
      373                        total energy supply
      374                        total energy supply
      375                        total energy supply
      376                        total energy supply
      377                        total energy supply
      378                        total energy supply
      379                        total energy supply
      380                        total energy supply
      381 biofuels production and direct air capture
      382 biofuels production and direct air capture
      383 biofuels production and direct air capture
      384 biofuels production and direct air capture
      385                        power sector inputs
      386                        power sector inputs
      387                        power sector inputs
      388                        power sector inputs
      389                        power sector inputs
      390                        power sector inputs
      391                        power sector inputs
      392                        power sector inputs
      393                        power sector inputs
      394                        power sector inputs
      395                        power sector inputs
      396                        power sector inputs
      397                        power sector inputs
      398                        power sector inputs
      399                        power sector inputs
      400                        power sector inputs
      401                        power sector inputs
      402                        power sector inputs
      403                        power sector inputs
      404                        power sector inputs
      405                        other energy sector
      406                        other energy sector
      407                        other energy sector
      408                        other energy sector
      409                    total final consumption
      410                    total final consumption
      411                    total final consumption
      412                    total final consumption
      413                    total final consumption
      414                    total final consumption
      415                    total final consumption
      416                    total final consumption
      417                    total final consumption
      418                    total final consumption
      419                    total final consumption
      420                    total final consumption
      421                    total final consumption
      422                    total final consumption
      423                    total final consumption
      424                    total final consumption
      425                    total final consumption
      426                    total final consumption
      427                    total final consumption
      428                    total final consumption
      429                                   industry
      430                                   industry
      431                                   industry
      432                                   industry
      433                             iron and steel
      434                             iron and steel
      435                             iron and steel
      436                             iron and steel
      437                                  chemicals
      438                                  chemicals
      439                                  chemicals
      440                                  chemicals
      441              non-metallic minerals: cement
      442              non-metallic minerals: cement
      443              non-metallic minerals: cement
      444              non-metallic minerals: cement
      445                                  transport
      446                                  transport
      447                                  transport
      448                                  transport
      449                                       road
      450                                       road
      451                                       road
      452                                       road
      453          road passenger light duty vehicle
      454          road passenger light duty vehicle
      455          road passenger light duty vehicle
      456          road passenger light duty vehicle
      457                     road heavy-duty trucks
      458                     road heavy-duty trucks
      459                     road heavy-duty trucks
      460                     road heavy-duty trucks
      461      total aviation (domestic and bunkers)
      462      total aviation (domestic and bunkers)
      463      total aviation (domestic and bunkers)
      464      total aviation (domestic and bunkers)
      465    total navigation (domestic and bunkers)
      466    total navigation (domestic and bunkers)
      467    total navigation (domestic and bunkers)
      468    total navigation (domestic and bunkers)
      469                                  buildings
      470                                  buildings
      471                                  buildings
      472                                  buildings
      473                                residential
      474                                residential
      475                                residential
      476                                residential
      477                                   services
      478                                   services
      479                                   services
      480                                   services
      481                        total energy supply
      482                        total energy supply
      483                        total energy supply
      484                        total energy supply
      
      [[5]]
          year
      1   2020
      2   2030
      3   2040
      4   2050
      5   2020
      6   2030
      7   2040
      8   2050
      9   2020
      10  2030
      11  2040
      12  2050
      13  2020
      14  2030
      15  2040
      16  2050
      17  2020
      18  2030
      19  2040
      20  2050
      21  2020
      22  2030
      23  2040
      24  2050
      25  2020
      26  2030
      27  2040
      28  2050
      29  2020
      30  2030
      31  2040
      32  2050
      33  2020
      34  2030
      35  2040
      36  2050
      37  2020
      38  2030
      39  2040
      40  2050
      41  2020
      42  2030
      43  2040
      44  2050
      45  2020
      46  2030
      47  2040
      48  2050
      49  2020
      50  2030
      51  2040
      52  2050
      53  2020
      54  2030
      55  2040
      56  2050
      57  2020
      58  2030
      59  2040
      60  2050
      61  2020
      62  2030
      63  2040
      64  2050
      65  2020
      66  2030
      67  2040
      68  2050
      69  2020
      70  2030
      71  2040
      72  2050
      73  2020
      74  2030
      75  2040
      76  2050
      77  2020
      78  2030
      79  2040
      80  2050
      81  2020
      82  2030
      83  2040
      84  2050
      85  2020
      86  2030
      87  2040
      88  2050
      89  2020
      90  2030
      91  2040
      92  2050
      93  2020
      94  2030
      95  2040
      96  2050
      97  2020
      98  2030
      99  2040
      100 2050
      101 2020
      102 2030
      103 2040
      104 2050
      105 2020
      106 2030
      107 2040
      108 2050
      109 2020
      110 2030
      111 2040
      112 2050
      113 2020
      114 2030
      115 2040
      116 2050
      117 2020
      118 2030
      119 2040
      120 2050
      121 2020
      122 2030
      123 2040
      124 2050
      125 2020
      126 2030
      127 2040
      128 2050
      129 2020
      130 2030
      131 2040
      132 2050
      133 2020
      134 2030
      135 2040
      136 2050
      137 2020
      138 2030
      139 2040
      140 2050
      141 2020
      142 2030
      143 2040
      144 2050
      145 2020
      146 2030
      147 2040
      148 2050
      149 2020
      150 2030
      151 2040
      152 2050
      153 2020
      154 2030
      155 2040
      156 2050
      157 2020
      158 2030
      159 2040
      160 2050
      161 2020
      162 2030
      163 2040
      164 2050
      165 2020
      166 2030
      167 2040
      168 2050
      169 2020
      170 2030
      171 2040
      172 2050
      173 2020
      174 2030
      175 2040
      176 2050
      177 2020
      178 2030
      179 2040
      180 2050
      181 2020
      182 2030
      183 2040
      184 2050
      185 2020
      186 2030
      187 2040
      188 2050
      189 2020
      190 2030
      191 2040
      192 2050
      193 2020
      194 2030
      195 2040
      196 2050
      197 2020
      198 2030
      199 2040
      200 2050
      201 2020
      202 2030
      203 2040
      204 2050
      205 2020
      206 2030
      207 2040
      208 2050
      209 2020
      210 2030
      211 2040
      212 2050
      213 2020
      214 2030
      215 2040
      216 2050
      217 2020
      218 2030
      219 2040
      220 2050
      221 2020
      222 2030
      223 2040
      224 2050
      225 2020
      226 2030
      227 2040
      228 2050
      229 2020
      230 2030
      231 2040
      232 2050
      233 2020
      234 2030
      235 2040
      236 2050
      237 2020
      238 2030
      239 2040
      240 2050
      241 2020
      242 2030
      243 2040
      244 2050
      245 2020
      246 2030
      247 2040
      248 2050
      249 2020
      250 2030
      251 2040
      252 2050
      253 2020
      254 2030
      255 2040
      256 2050
      257 2020
      258 2030
      259 2040
      260 2050
      261 2020
      262 2030
      263 2040
      264 2050
      265 2020
      266 2030
      267 2040
      268 2050
      269 2020
      270 2030
      271 2040
      272 2050
      273 2020
      274 2030
      275 2040
      276 2050
      277 2020
      278 2030
      279 2040
      280 2050
      281 2020
      282 2030
      283 2040
      284 2050
      285 2020
      286 2030
      287 2040
      288 2050
      289 2020
      290 2030
      291 2040
      292 2050
      293 2020
      294 2030
      295 2040
      296 2050
      297 2020
      298 2030
      299 2040
      300 2050
      301 2020
      302 2030
      303 2040
      304 2050
      305 2020
      306 2030
      307 2040
      308 2050
      309 2020
      310 2030
      311 2040
      312 2050
      313 2020
      314 2030
      315 2040
      316 2050
      317 2020
      318 2030
      319 2040
      320 2050
      321 2020
      322 2030
      323 2040
      324 2050
      325 2020
      326 2030
      327 2040
      328 2050
      329 2020
      330 2030
      331 2040
      332 2050
      333 2020
      334 2030
      335 2040
      336 2050
      337 2020
      338 2030
      339 2040
      340 2050
      341 2020
      342 2030
      343 2040
      344 2050
      345 2020
      346 2030
      347 2040
      348 2050
      349 2020
      350 2030
      351 2040
      352 2050
      353 2020
      354 2030
      355 2040
      356 2050
      357 2020
      358 2030
      359 2040
      360 2050
      361 2020
      362 2030
      363 2040
      364 2050
      365 2020
      366 2030
      367 2040
      368 2050
      369 2020
      370 2030
      371 2040
      372 2050
      373 2020
      374 2030
      375 2040
      376 2050
      377 2020
      378 2030
      379 2040
      380 2050
      381 2020
      382 2030
      383 2040
      384 2050
      385 2020
      386 2030
      387 2040
      388 2050
      389 2020
      390 2030
      391 2040
      392 2050
      393 2020
      394 2030
      395 2040
      396 2050
      397 2020
      398 2030
      399 2040
      400 2050
      401 2020
      402 2030
      403 2040
      404 2050
      405 2020
      406 2030
      407 2040
      408 2050
      409 2020
      410 2030
      411 2040
      412 2050
      413 2020
      414 2030
      415 2040
      416 2050
      417 2020
      418 2030
      419 2040
      420 2050
      421 2020
      422 2030
      423 2040
      424 2050
      425 2020
      426 2030
      427 2040
      428 2050
      429 2020
      430 2030
      431 2040
      432 2050
      433 2020
      434 2030
      435 2040
      436 2050
      437 2020
      438 2030
      439 2040
      440 2050
      441 2020
      442 2030
      443 2040
      444 2050
      445 2020
      446 2030
      447 2040
      448 2050
      449 2020
      450 2030
      451 2040
      452 2050
      453 2020
      454 2030
      455 2040
      456 2050
      457 2020
      458 2030
      459 2040
      460 2050
      461 2020
      462 2030
      463 2040
      464 2050
      465 2020
      466 2030
      467 2040
      468 2050
      469 2020
      470 2030
      471 2040
      472 2050
      473 2020
      474 2030
      475 2040
      476 2050
      477 2020
      478 2030
      479 2040
      480 2050
      481 2020
      482 2030
      483 2040
      484 2050
      
      [[6]]
                  value
      1     550.4698707
      2      47.3894183
      3     -60.5859092
      4    -175.4472297
      5     397.4480543
      6     188.7143975
      7      13.0514154
      8       0.0000000
      9      70.2111974
      10     30.5464284
      11     12.7604793
      12      0.5758578
      13    174.7404202
      14    116.1271626
      15     53.1712805
      16     36.7285568
      17     82.6013642
      18     55.5660312
      19     22.5908163
      20      1.1956011
      21    113.1381332
      22     82.1050219
      23     31.6630277
      24      0.0000000
      25    398.3744906
      26    225.3184274
      27      0.7532166
      28      0.0000000
      29     93.6058766
      30     80.6176133
      31      5.0496159
      32      0.0000000
      33     88.7888100
      34    147.1479930
      35     98.3098637
      36     36.2081966
      37    142.7172828
      38    150.8653940
      39    100.0609150
      40     27.1827463
      41     74.5956583
      42     36.2747815
      43      1.3909859
      44      0.0000000
      45    182.1050792
      46    159.6979268
      47     89.0766102
      48     44.1177254
      49   2368.7962376
      50   1320.3705960
      51    367.2923172
      52    -29.4385458
      53    150.0000000
      54     60.0000000
      55    -60.0000000
      56   -110.0000000
      57  12763.4611034
      58   5359.1821086
      59    392.3527007
      60   -807.1288825
      61   3009.1959615
      62   2454.2085893
      63   1027.6093147
      64     61.3004139
      65   2415.2129421
      66   1871.8160764
      67    778.2053491
      68     88.2921727
      69   3021.2168930
      70   2641.4669656
      71   1573.8208497
      72    591.8072198
      73   1385.3870012
      74   1217.9542991
      75    690.3366346
      76    101.7648171
      77   1920.9290456
      78   1747.6443868
      79    920.5647911
      80     91.9987471
      81   2761.6498757
      82   2341.5314912
      83    362.4314112
      84     24.9521077
      85   1831.8762496
      86   2087.3268579
      87    524.4611018
      88     33.0920023
      89    656.1545517
      90   1211.4726177
      91    891.4865957
      92    362.5932179
      93    807.8559071
      94   1042.7729587
      95    771.1215247
      96    223.5124311
      97   1278.4655499
      98    993.9080975
      99    234.5592598
      100    96.9414688
      101  2912.3385587
      102  2742.6176155
      103  1571.3675932
      104   699.2068147
      105 34763.7436395
      106 25711.9020643
      107  9738.3171260
      108  1568.3325306
      109  5860.0000000
      110  2250.0000000
      111   570.0000000
      112 -1870.0000000
      113 31904.0000000
      114 33134.7000000
      115 30799.9000000
      116 28946.4000000
      117 14335.2000000
      118 13695.0000000
      119 11553.4000000
      120  9863.0400000
      121 10193.7000000
      122 11411.5000000
      123 11247.9000000
      124 11094.2000000
      125  7161.5100000
      126  7773.6900000
      127  7674.7400000
      128  7628.5300000
      129   213.4100000
      130   254.3700000
      131   323.6500000
      132   360.3800000
      133     0.8100000
      134     8.7400000
      135    27.7900000
      136    59.2800000
      137 13502.0000000
      138 12758.6000000
      139 10676.3000000
      140  9307.7400000
      141  9750.4000000
      142  9127.9800000
      143  7281.7900000
      144  5938.4400000
      145   557.3000000
      146   371.5600000
      147   308.5200000
      148   260.2900000
      149  3095.2400000
      150  3104.6600000
      151  2863.2600000
      152  2842.1000000
      153    99.1000000
      154   154.4400000
      155   222.7700000
      156   266.9100000
      157  1487.1800000
      158  1698.3700000
      159  1695.4900000
      160  1659.1000000
      161 19521.6000000
      162 21627.0000000
      163 21501.3000000
      164 21056.1000000
      165  4474.2800000
      166  4458.2400000
      167  4170.3700000
      168  3829.9800000
      169  9080.0600000
      170 10455.5000000
      171 10388.4000000
      172 10331.1000000
      173  3320.8500000
      174  3800.0100000
      175  3929.0500000
      176  3904.1200000
      177   113.5000000
      178   100.0400000
      179   101.0000000
      180    93.6500000
      181  9132.2200000
      182 10036.5000000
      183 10060.7000000
      184  9669.4400000
      185  2724.2600000
      186  2929.0000000
      187  2797.7000000
      188  2652.9700000
      189  1286.7900000
      190  1492.1900000
      191  1492.0000000
      192  1429.1300000
      193  2458.3300000
      194  2648.1700000
      195  2699.1400000
      196  2585.3000000
      197  7112.9500000
      198  8471.7600000
      199  8570.5700000
      200  8699.6600000
      201  5484.7800000
      202  6064.5200000
      203  5925.1000000
      204  5666.9000000
      205  2803.0500000
      206  2961.6000000
      207  2760.5500000
      208  2470.3400000
      209  1688.1000000
      210  2069.7900000
      211  2274.1600000
      212  2435.0400000
      213   586.3100000
      214  1259.4900000
      215  1439.5700000
      216  1675.4500000
      217   795.8500000
      218   904.9800000
      219   978.6400000
      220  1144.9400000
      221  2850.6500000
      222  2680.3300000
      223  2446.3600000
      224  2293.4100000
      225  1982.9400000
      226  1746.6000000
      227  1527.8200000
      228  1415.0800000
      229   867.7100000
      230   933.7300000
      231   918.5400000
      232   878.3300000
      233     0.9700000
      234    11.2700000
      235    35.1500000
      236    69.5900000
      237 31904.0000000
      238 28803.0000000
      239 18554.4000000
      240 11346.5000000
      241 14335.2000000
      242 11881.3000000
      243  6594.4600000
      244  2973.1500000
      245 10193.7000000
      246 10092.6000000
      247  7169.4100000
      248  5077.7700000
      249  7161.5100000
      250  6679.8600000
      251  4966.9500000
      252  3758.4700000
      253   213.4100000
      254   149.1900000
      255  -176.4600000
      256  -462.9100000
      257     0.8100000
      258    49.9700000
      259   163.5300000
      260   405.9600000
      261 13502.0000000
      262 11329.9000000
      263  6389.1300000
      264  3137.6700000
      265  9750.4000000
      266  8163.4300000
      267  4291.9500000
      268  1712.5900000
      269   557.3000000
      270   322.0800000
      271   230.3500000
      272   155.8600000
      273  3095.2400000
      274  2759.4100000
      275  2021.7300000
      276  1597.9300000
      277    99.1000000
      278    84.9300000
      279  -154.9100000
      280  -328.7100000
      281  1487.1800000
      282  1334.0900000
      283   730.2900000
      284   191.2000000
      285 19521.6000000
      286 18784.8000000
      287 13438.2000000
      288  9123.8900000
      289  4474.2800000
      290  3621.1400000
      291  2239.1500000
      292  1238.7800000
      293  9080.0600000
      294  9302.2300000
      295  6669.6300000
      296  4754.8800000
      297  3320.8500000
      298  3225.1700000
      299  2464.8800000
      300  1803.3600000
      301   113.5000000
      302    64.4300000
      303   -21.0300000
      304  -124.9300000
      305  9132.2200000
      306  8569.2900000
      307  6233.7000000
      308  3946.0300000
      309  2724.2600000
      310  2511.5200000
      311  1807.7500000
      312  1119.8400000
      313  1286.7900000
      314  1314.6200000
      315   925.0400000
      316   547.9700000
      317  2458.3300000
      318  2328.6300000
      319  1758.4100000
      320  1084.1000000
      321  7112.9500000
      322  7616.0700000
      323  5556.6100000
      324  4024.7600000
      325  5484.7800000
      326  5458.5500000
      327  3772.6800000
      328  2508.6100000
      329  2803.0500000
      330  2588.6000000
      331  1597.8200000
      332   996.8700000
      333  1688.1000000
      334  1909.4700000
      335  1548.7500000
      336  1137.4500000
      337   586.3100000
      338  1196.8900000
      339  1135.7500000
      340  1073.7600000
      341   795.8500000
      342   778.3300000
      343   524.7500000
      344   361.8900000
      345  2850.6500000
      346  2266.8200000
      347  1434.3800000
      348  1029.4900000
      349  1982.9400000
      350  1558.5700000
      351  1002.2300000
      352   747.7300000
      353   867.7100000
      354   708.2500000
      355   432.1500000
      356   281.7700000
      357     0.9700000
      358    86.4700000
      359   430.8500000
      360   917.8200000
      361 31904.0000000
      362 20590.4000000
      363  5103.2700000
      364   509.6300000
      365 14335.2000000
      366  7578.3200000
      367  1140.4400000
      368   114.2700000
      369 10193.7000000
      370  7710.4400000
      371  3029.6100000
      372   722.1500000
      373  7161.5100000
      374  5282.3300000
      375  1390.9100000
      376   404.6700000
      377   213.4100000
      378    19.3400000
      379  -457.6800000
      380  -731.4600000
      381     0.8100000
      382   155.8700000
      383   530.3000000
      384   786.8500000
      385 13502.0000000
      386  7076.4700000
      387  -188.6100000
      388  -350.7800000
      389  9750.4000000
      390  4653.4800000
      391    48.7300000
      392    26.6500000
      393   557.3000000
      394   167.3900000
      395    17.8000000
      396     2.3400000
      397  3095.2400000
      398  2264.1800000
      399    79.9900000
      400    41.6900000
      401    99.1000000
      402    -8.5800000
      403  -335.1300000
      404  -421.4600000
      405  1487.1800000
      406   965.6200000
      407   112.3300000
      408  -266.4500000
      409 19521.6000000
      410 14765.0000000
      411  6092.0700000
      412  1004.6800000
      413  4474.2800000
      414  2835.2300000
      415  1043.4500000
      416    72.9200000
      417  9080.0600000
      418  7162.0500000
      419  2864.5000000
      420   650.7900000
      421  3320.8500000
      422  2490.7300000
      423  1094.3000000
      424   213.2300000
      425   113.5000000
      426    28.8900000
      427   -96.1800000
      428  -204.8200000
      429  9132.2200000
      430  7167.7100000
      431  3246.0500000
      432   395.7800000
      433  2724.2600000
      434  2090.5400000
      435   965.0500000
      436   176.8800000
      437  1286.7900000
      438  1137.2400000
      439   545.8300000
      440    38.4800000
      441  2458.3300000
      442  1910.4600000
      443   869.0200000
      444    75.5000000
      445  7112.9500000
      446  5687.0100000
      447  2258.2000000
      448   535.1600000
      449  5484.7800000
      450  3987.8400000
      451  1369.9700000
      452   195.0300000
      453  2803.0500000
      454  1690.9900000
      455   421.6600000
      456    45.3400000
      457  1688.1000000
      458  1574.2600000
      459   745.5800000
      460   136.1200000
      461   586.3100000
      462   884.2100000
      463   511.0200000
      464   199.4400000
      465   795.8500000
      466   673.3700000
      467   303.7800000
      468   107.1000000
      469  2850.6500000
      470  1631.9100000
      471   474.5800000
      472    55.3600000
      473  1982.9400000
      474  1197.4000000
      475   368.8800000
      476    54.6100000
      477   867.7100000
      478   434.5100000
      479   105.7000000
      480     0.7500000
      481     0.9700000
      482   234.1100000
      483  1008.2400000
      484  1525.9100000
      
      [[7]]
             reductions
      1    0.000000e+00
      2    9.139110e-01
      3    1.110062e+00
      4    1.318723e+00
      5    0.000000e+00
      6    5.251847e-01
      7    9.671620e-01
      8    1.000000e+00
      9    0.000000e+00
      10   5.649351e-01
      11   8.182558e-01
      12   9.917982e-01
      13   0.000000e+00
      14   3.354304e-01
      15   6.957128e-01
      16   7.898108e-01
      17   0.000000e+00
      18   3.272989e-01
      19   7.265080e-01
      20   9.855256e-01
      21   0.000000e+00
      22   2.742940e-01
      23   7.201383e-01
      24   1.000000e+00
      25   0.000000e+00
      26   4.344055e-01
      27   9.981093e-01
      28   1.000000e+00
      29   0.000000e+00
      30   1.387548e-01
      31   9.460545e-01
      32   1.000000e+00
      33   0.000000e+00
      34  -6.572808e-01
      35  -1.072326e-01
      36   5.921987e-01
      37   0.000000e+00
      38  -5.709267e-02
      39   2.988872e-01
      40   8.095343e-01
      41   0.000000e+00
      42   5.137146e-01
      43   9.813530e-01
      44   1.000000e+00
      45   0.000000e+00
      46   1.230452e-01
      47   5.108505e-01
      48   7.577348e-01
      49   0.000000e+00
      50   4.425985e-01
      51   8.449456e-01
      52   1.012428e+00
      53   0.000000e+00
      54   6.000000e-01
      55   1.400000e+00
      56   1.733333e+00
      57   0.000000e+00
      58   5.801153e-01
      59   9.692597e-01
      60   1.063237e+00
      61   0.000000e+00
      62   1.844305e-01
      63   6.585103e-01
      64   9.796290e-01
      65   0.000000e+00
      66   2.249892e-01
      67   6.777902e-01
      68   9.634433e-01
      69   0.000000e+00
      70   1.256944e-01
      71   4.790772e-01
      72   8.041163e-01
      73   0.000000e+00
      74   1.208563e-01
      75   5.017012e-01
      76   9.265441e-01
      77   0.000000e+00
      78   9.020878e-02
      79   5.207711e-01
      80   9.521072e-01
      81   0.000000e+00
      82   1.521259e-01
      83   8.687627e-01
      84   9.909648e-01
      85   0.000000e+00
      86  -1.394475e-01
      87   7.137028e-01
      88   9.819355e-01
      89   0.000000e+00
      90  -8.463221e-01
      91  -3.586534e-01
      92   4.473966e-01
      93   0.000000e+00
      94  -2.907908e-01
      95   4.547145e-02
      96   7.233264e-01
      97   0.000000e+00
      98   2.225773e-01
      99   8.165306e-01
      100  9.241736e-01
      101  0.000000e+00
      102  5.827652e-02
      103  4.604447e-01
      104  7.599157e-01
      105  0.000000e+00
      106  2.603817e-01
      107  7.198714e-01
      108  9.548860e-01
      109  1.000000e+00
      110  6.160410e-01
      111  9.027304e-01
      112  1.319113e+00
      113  0.000000e+00
      114 -3.857510e-02
      115  3.460695e-02
      116  9.270311e-02
      117  0.000000e+00
      118  4.465930e-02
      119  1.940538e-01
      120  3.119705e-01
      121  0.000000e+00
      122 -1.194659e-01
      123 -1.034168e-01
      124 -8.833888e-02
      125  0.000000e+00
      126 -8.548197e-02
      127 -7.166505e-02
      128 -6.521250e-02
      129  0.000000e+00
      130 -1.919310e-01
      131 -5.165644e-01
      132 -6.886744e-01
      133  0.000000e+00
      134 -9.790123e+00
      135 -3.330864e+01
      136 -7.218519e+01
      137  0.000000e+00
      138  5.505851e-02
      139  2.092801e-01
      140  3.106399e-01
      141  0.000000e+00
      142  6.383533e-02
      143  2.531804e-01
      144  3.909542e-01
      145  0.000000e+00
      146  3.332855e-01
      147  4.464023e-01
      148  5.329446e-01
      149  0.000000e+00
      150 -3.043383e-03
      151  7.494734e-02
      152  8.178364e-02
      153  0.000000e+00
      154 -5.584258e-01
      155 -1.247931e+00
      156 -1.693340e+00
      157  0.000000e+00
      158 -1.420070e-01
      159 -1.400705e-01
      160 -1.156013e-01
      161  0.000000e+00
      162 -1.078498e-01
      163 -1.014107e-01
      164 -7.860524e-02
      165  0.000000e+00
      166  3.584934e-03
      167  6.792378e-02
      168  1.440008e-01
      169  0.000000e+00
      170 -1.514792e-01
      171 -1.440894e-01
      172 -1.377788e-01
      173  0.000000e+00
      174 -1.442884e-01
      175 -1.831459e-01
      176 -1.756388e-01
      177  0.000000e+00
      178  1.185903e-01
      179  1.101322e-01
      180  1.748899e-01
      181  0.000000e+00
      182 -9.902083e-02
      183 -1.016708e-01
      184 -5.882688e-02
      185  0.000000e+00
      186 -7.515435e-02
      187 -2.695778e-02
      188  2.616857e-02
      189  0.000000e+00
      190 -1.596220e-01
      191 -1.594744e-01
      192 -1.106163e-01
      193  0.000000e+00
      194 -7.722316e-02
      195 -9.795674e-02
      196 -5.164888e-02
      197  0.000000e+00
      198 -1.910333e-01
      199 -2.049248e-01
      200 -2.230734e-01
      201  0.000000e+00
      202 -1.056998e-01
      203 -8.028034e-02
      204 -3.320461e-02
      205  0.000000e+00
      206 -5.656339e-02
      207  1.516206e-02
      208  1.186957e-01
      209  0.000000e+00
      210 -2.261063e-01
      211 -3.471714e-01
      212 -4.424738e-01
      213  0.000000e+00
      214 -1.148164e+00
      215 -1.455305e+00
      216 -1.857618e+00
      217  0.000000e+00
      218 -1.371238e-01
      219 -2.296790e-01
      220 -4.386379e-01
      221  0.000000e+00
      222  5.974778e-02
      223  1.418238e-01
      224  1.954782e-01
      225  0.000000e+00
      226  1.191867e-01
      227  2.295178e-01
      228  2.863728e-01
      229  0.000000e+00
      230 -7.608533e-02
      231 -5.857948e-02
      232 -1.223911e-02
      233  0.000000e+00
      234 -1.061856e+01
      235 -3.523711e+01
      236 -7.074227e+01
      237  0.000000e+00
      238  9.719784e-02
      239  4.184303e-01
      240  6.443549e-01
      241  0.000000e+00
      242  1.711800e-01
      243  5.399813e-01
      244  7.925979e-01
      245  0.000000e+00
      246  9.917890e-03
      247  2.966823e-01
      248  5.018717e-01
      249  0.000000e+00
      250  6.725537e-02
      251  3.064382e-01
      252  4.751847e-01
      253  0.000000e+00
      254  3.009231e-01
      255  1.826859e+00
      256  3.169111e+00
      257  0.000000e+00
      258 -6.069136e+01
      259 -2.008889e+02
      260 -5.001852e+02
      261  0.000000e+00
      262  1.608725e-01
      263  5.268012e-01
      264  7.676144e-01
      265  0.000000e+00
      266  1.627595e-01
      267  5.598181e-01
      268  8.243569e-01
      269  0.000000e+00
      270  4.220707e-01
      271  5.866679e-01
      272  7.203302e-01
      273  0.000000e+00
      274  1.084989e-01
      275  3.468261e-01
      276  4.837460e-01
      277  0.000000e+00
      278  1.429869e-01
      279  2.563169e+00
      280  4.316953e+00
      281  0.000000e+00
      282  1.029398e-01
      283  5.089431e-01
      284  8.714345e-01
      285  0.000000e+00
      286  3.774281e-02
      287  3.116240e-01
      288  5.326259e-01
      289  0.000000e+00
      290  1.906765e-01
      291  4.995508e-01
      292  7.231331e-01
      293  0.000000e+00
      294 -2.446790e-02
      295  2.654641e-01
      296  4.763383e-01
      297  0.000000e+00
      298  2.881190e-02
      299  2.577563e-01
      300  4.569583e-01
      301  0.000000e+00
      302  4.323348e-01
      303  1.185286e+00
      304  2.100705e+00
      305  0.000000e+00
      306  6.164219e-02
      307  3.173949e-01
      308  5.679002e-01
      309  0.000000e+00
      310  7.809093e-02
      311  3.364253e-01
      312  5.889379e-01
      313  0.000000e+00
      314 -2.162746e-02
      315  2.811259e-01
      316  5.741574e-01
      317  0.000000e+00
      318  5.275939e-02
      319  2.847136e-01
      320  5.590096e-01
      321  0.000000e+00
      322 -7.073296e-02
      323  2.188037e-01
      324  4.341644e-01
      325  0.000000e+00
      326  4.782325e-03
      327  3.121547e-01
      328  5.426234e-01
      329  0.000000e+00
      330  7.650595e-02
      331  4.299709e-01
      332  6.443624e-01
      333  0.000000e+00
      334 -1.311356e-01
      335  8.254843e-02
      336  3.261951e-01
      337  0.000000e+00
      338 -1.041394e+00
      339 -9.371152e-01
      340 -8.313861e-01
      341  0.000000e+00
      342  2.201420e-02
      343  3.406421e-01
      344  5.452786e-01
      345  0.000000e+00
      346  2.048059e-01
      347  4.968235e-01
      348  6.388578e-01
      349  0.000000e+00
      350  2.140105e-01
      351  4.945737e-01
      352  6.229185e-01
      353  0.000000e+00
      354  1.837711e-01
      355  5.019649e-01
      356  6.752717e-01
      357  0.000000e+00
      358 -8.814433e+01
      359 -4.431753e+02
      360 -9.452062e+02
      361  0.000000e+00
      362  3.546138e-01
      363  8.400429e-01
      364  9.840261e-01
      365  0.000000e+00
      366  4.713488e-01
      367  9.204448e-01
      368  9.920287e-01
      369  0.000000e+00
      370  2.436073e-01
      371  7.027958e-01
      372  9.291572e-01
      373  0.000000e+00
      374  2.624000e-01
      375  8.057798e-01
      376  9.434938e-01
      377  0.000000e+00
      378  9.093763e-01
      379  3.144604e+00
      380  4.427487e+00
      381  0.000000e+00
      382 -1.914321e+02
      383 -6.536914e+02
      384 -9.704198e+02
      385  0.000000e+00
      386  4.758947e-01
      387  1.013969e+00
      388  1.025980e+00
      389  0.000000e+00
      390  5.227396e-01
      391  9.950023e-01
      392  9.972668e-01
      393  0.000000e+00
      394  6.996411e-01
      395  9.680603e-01
      396  9.958012e-01
      397  0.000000e+00
      398  2.684961e-01
      399  9.741571e-01
      400  9.865309e-01
      401  0.000000e+00
      402  1.086579e+00
      403  4.381736e+00
      404  5.252876e+00
      405  0.000000e+00
      406  3.507040e-01
      407  9.244678e-01
      408  1.179165e+00
      409  0.000000e+00
      410  2.436583e-01
      411  6.879318e-01
      412  9.485350e-01
      413  0.000000e+00
      414  3.663271e-01
      415  7.667893e-01
      416  9.837024e-01
      417  0.000000e+00
      418  2.112332e-01
      419  6.845285e-01
      420  9.283276e-01
      421  0.000000e+00
      422  2.499721e-01
      423  6.704759e-01
      424  9.357905e-01
      425  0.000000e+00
      426  7.454626e-01
      427  1.847401e+00
      428  2.804581e+00
      429  0.000000e+00
      430  2.151186e-01
      431  6.445497e-01
      432  9.566611e-01
      433  0.000000e+00
      434  2.326210e-01
      435  6.457570e-01
      436  9.350723e-01
      437  0.000000e+00
      438  1.162194e-01
      439  5.758205e-01
      440  9.700961e-01
      441  0.000000e+00
      442  2.228627e-01
      443  6.464999e-01
      444  9.692881e-01
      445  0.000000e+00
      446  2.004710e-01
      447  6.825227e-01
      448  9.247626e-01
      449  0.000000e+00
      450  2.729262e-01
      451  7.502233e-01
      452  9.644416e-01
      453  0.000000e+00
      454  3.967321e-01
      455  8.495710e-01
      456  9.838248e-01
      457  0.000000e+00
      458  6.743676e-02
      459  5.583319e-01
      460  9.193650e-01
      461  0.000000e+00
      462 -5.080930e-01
      463  1.284133e-01
      464  6.598387e-01
      465  0.000000e+00
      466  1.538983e-01
      467  6.182949e-01
      468  8.654269e-01
      469  0.000000e+00
      470  4.275306e-01
      471  8.335187e-01
      472  9.805799e-01
      473  0.000000e+00
      474  3.961492e-01
      475  8.139732e-01
      476  9.724601e-01
      477  0.000000e+00
      478  4.992451e-01
      479  8.781851e-01
      480  9.991357e-01
      481  0.000000e+00
      482 -2.403505e+02
      483 -1.038423e+03
      484 -1.572103e+03
      
      [[8]]
          type
      1    ipr
      2    ipr
      3    ipr
      4    ipr
      5    ipr
      6    ipr
      7    ipr
      8    ipr
      9    ipr
      10   ipr
      11   ipr
      12   ipr
      13   ipr
      14   ipr
      15   ipr
      16   ipr
      17   ipr
      18   ipr
      19   ipr
      20   ipr
      21   ipr
      22   ipr
      23   ipr
      24   ipr
      25   ipr
      26   ipr
      27   ipr
      28   ipr
      29   ipr
      30   ipr
      31   ipr
      32   ipr
      33   ipr
      34   ipr
      35   ipr
      36   ipr
      37   ipr
      38   ipr
      39   ipr
      40   ipr
      41   ipr
      42   ipr
      43   ipr
      44   ipr
      45   ipr
      46   ipr
      47   ipr
      48   ipr
      49   ipr
      50   ipr
      51   ipr
      52   ipr
      53   ipr
      54   ipr
      55   ipr
      56   ipr
      57   ipr
      58   ipr
      59   ipr
      60   ipr
      61   ipr
      62   ipr
      63   ipr
      64   ipr
      65   ipr
      66   ipr
      67   ipr
      68   ipr
      69   ipr
      70   ipr
      71   ipr
      72   ipr
      73   ipr
      74   ipr
      75   ipr
      76   ipr
      77   ipr
      78   ipr
      79   ipr
      80   ipr
      81   ipr
      82   ipr
      83   ipr
      84   ipr
      85   ipr
      86   ipr
      87   ipr
      88   ipr
      89   ipr
      90   ipr
      91   ipr
      92   ipr
      93   ipr
      94   ipr
      95   ipr
      96   ipr
      97   ipr
      98   ipr
      99   ipr
      100  ipr
      101  ipr
      102  ipr
      103  ipr
      104  ipr
      105  ipr
      106  ipr
      107  ipr
      108  ipr
      109  ipr
      110  ipr
      111  ipr
      112  ipr
      113  weo
      114  weo
      115  weo
      116  weo
      117  weo
      118  weo
      119  weo
      120  weo
      121  weo
      122  weo
      123  weo
      124  weo
      125  weo
      126  weo
      127  weo
      128  weo
      129  weo
      130  weo
      131  weo
      132  weo
      133  weo
      134  weo
      135  weo
      136  weo
      137  weo
      138  weo
      139  weo
      140  weo
      141  weo
      142  weo
      143  weo
      144  weo
      145  weo
      146  weo
      147  weo
      148  weo
      149  weo
      150  weo
      151  weo
      152  weo
      153  weo
      154  weo
      155  weo
      156  weo
      157  weo
      158  weo
      159  weo
      160  weo
      161  weo
      162  weo
      163  weo
      164  weo
      165  weo
      166  weo
      167  weo
      168  weo
      169  weo
      170  weo
      171  weo
      172  weo
      173  weo
      174  weo
      175  weo
      176  weo
      177  weo
      178  weo
      179  weo
      180  weo
      181  weo
      182  weo
      183  weo
      184  weo
      185  weo
      186  weo
      187  weo
      188  weo
      189  weo
      190  weo
      191  weo
      192  weo
      193  weo
      194  weo
      195  weo
      196  weo
      197  weo
      198  weo
      199  weo
      200  weo
      201  weo
      202  weo
      203  weo
      204  weo
      205  weo
      206  weo
      207  weo
      208  weo
      209  weo
      210  weo
      211  weo
      212  weo
      213  weo
      214  weo
      215  weo
      216  weo
      217  weo
      218  weo
      219  weo
      220  weo
      221  weo
      222  weo
      223  weo
      224  weo
      225  weo
      226  weo
      227  weo
      228  weo
      229  weo
      230  weo
      231  weo
      232  weo
      233  weo
      234  weo
      235  weo
      236  weo
      237  weo
      238  weo
      239  weo
      240  weo
      241  weo
      242  weo
      243  weo
      244  weo
      245  weo
      246  weo
      247  weo
      248  weo
      249  weo
      250  weo
      251  weo
      252  weo
      253  weo
      254  weo
      255  weo
      256  weo
      257  weo
      258  weo
      259  weo
      260  weo
      261  weo
      262  weo
      263  weo
      264  weo
      265  weo
      266  weo
      267  weo
      268  weo
      269  weo
      270  weo
      271  weo
      272  weo
      273  weo
      274  weo
      275  weo
      276  weo
      277  weo
      278  weo
      279  weo
      280  weo
      281  weo
      282  weo
      283  weo
      284  weo
      285  weo
      286  weo
      287  weo
      288  weo
      289  weo
      290  weo
      291  weo
      292  weo
      293  weo
      294  weo
      295  weo
      296  weo
      297  weo
      298  weo
      299  weo
      300  weo
      301  weo
      302  weo
      303  weo
      304  weo
      305  weo
      306  weo
      307  weo
      308  weo
      309  weo
      310  weo
      311  weo
      312  weo
      313  weo
      314  weo
      315  weo
      316  weo
      317  weo
      318  weo
      319  weo
      320  weo
      321  weo
      322  weo
      323  weo
      324  weo
      325  weo
      326  weo
      327  weo
      328  weo
      329  weo
      330  weo
      331  weo
      332  weo
      333  weo
      334  weo
      335  weo
      336  weo
      337  weo
      338  weo
      339  weo
      340  weo
      341  weo
      342  weo
      343  weo
      344  weo
      345  weo
      346  weo
      347  weo
      348  weo
      349  weo
      350  weo
      351  weo
      352  weo
      353  weo
      354  weo
      355  weo
      356  weo
      357  weo
      358  weo
      359  weo
      360  weo
      361  weo
      362  weo
      363  weo
      364  weo
      365  weo
      366  weo
      367  weo
      368  weo
      369  weo
      370  weo
      371  weo
      372  weo
      373  weo
      374  weo
      375  weo
      376  weo
      377  weo
      378  weo
      379  weo
      380  weo
      381  weo
      382  weo
      383  weo
      384  weo
      385  weo
      386  weo
      387  weo
      388  weo
      389  weo
      390  weo
      391  weo
      392  weo
      393  weo
      394  weo
      395  weo
      396  weo
      397  weo
      398  weo
      399  weo
      400  weo
      401  weo
      402  weo
      403  weo
      404  weo
      405  weo
      406  weo
      407  weo
      408  weo
      409  weo
      410  weo
      411  weo
      412  weo
      413  weo
      414  weo
      415  weo
      416  weo
      417  weo
      418  weo
      419  weo
      420  weo
      421  weo
      422  weo
      423  weo
      424  weo
      425  weo
      426  weo
      427  weo
      428  weo
      429  weo
      430  weo
      431  weo
      432  weo
      433  weo
      434  weo
      435  weo
      436  weo
      437  weo
      438  weo
      439  weo
      440  weo
      441  weo
      442  weo
      443  weo
      444  weo
      445  weo
      446  weo
      447  weo
      448  weo
      449  weo
      450  weo
      451  weo
      452  weo
      453  weo
      454  weo
      455  weo
      456  weo
      457  weo
      458  weo
      459  weo
      460  weo
      461  weo
      462  weo
      463  weo
      464  weo
      465  weo
      466  weo
      467  weo
      468  weo
      469  weo
      470  weo
      471  weo
      472  weo
      473  weo
      474  weo
      475  weo
      476  weo
      477  weo
      478  weo
      479  weo
      480  weo
      481  weo
      482  weo
      483  weo
      484  weo
      

