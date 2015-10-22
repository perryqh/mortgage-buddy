require 'spec_helper'

describe MortgageBuddy::PaymentPlan do
  let(:payment_plan) { described_class.new(params) }

  context 'a more complex example' do
    let(:params) do
      {loan_amount:           1000.0,
       monthly_payment:       100.0,
       monthly_interest_rate: (5.0 / 100 / 12)}
    end

    context 'first payment' do
      subject { payment_plan.payments.first }
      its(:payment) { is_expected.to eq(100) }
      its(:number) { is_expected.to eq(1) }
      its(:principal) { is_expected.to eq(95.84) }
      its(:balance) { is_expected.to eq(904.16) }
      its(:interest) { is_expected.to eq(4.16) }
    end

    context 'middle payment' do
      subject { payment_plan.payments[6] }
      its(:payment) { is_expected.to eq(100) }
      its(:number) { is_expected.to eq(7) }
      its(:principal) { is_expected.to eq(98.26) }
      its(:balance) { is_expected.to eq(320.68) }
      its(:interest) { is_expected.to eq(1.74) }
    end

    context 'last payment' do
      subject { payment_plan.payments.last }
      its(:payment) { is_expected.to eq(23.53) }
      its(:number) { is_expected.to eq(11) }
      its(:principal) { is_expected.to eq(23.44) }
      its(:balance) { is_expected.to eq(0) }
      its(:interest) { is_expected.to eq(0.09) }
    end
  end

  context 'a simple example' do
    let(:params) do
      {loan_amount:           5.0,
       monthly_payment:       2.0,
       monthly_interest_rate: (20.0 / 100 / 12)}
    end

    context 'first payment' do
      subject { payment_plan.payments.first }
      its(:payment) { is_expected.to eq(2.0) }
      its(:number) { is_expected.to eq(1) }
      its(:principal) { is_expected.to eq(1.92) }
      its(:balance) { is_expected.to eq(3.08) }
      its(:interest) { is_expected.to eq(0.08) }
    end

    context 'second payment' do
      subject { payment_plan.payments[1] }
      its(:payment) { is_expected.to eq(2.0) }
      its(:number) { is_expected.to eq(2) }
      its(:principal) { is_expected.to eq(1.95) }
      its(:balance) { is_expected.to eq(1.13) }
      its(:interest) { is_expected.to eq(0.05) }
    end

    context 'last payment' do
      subject { payment_plan.payments.last }
      its(:payment) { is_expected.to eq(1.14) }
      its(:number) { is_expected.to eq(3) }
      its(:principal) { is_expected.to eq(1.13) }
      its(:balance) { is_expected.to eq(0.0) }
      its(:interest) { is_expected.to eq(0.01) }
    end
  end

  context '30 year example' do
    let(:params) do
      {loan_amount:           165000.0,
       monthly_payment:       836.03,
       monthly_interest_rate: (4.5 / 100 / 12)}
    end
    let(:expected) do
      [
          [1, 217.28, 618.75, 164782.72],
          [2, 218.09, 617.94, 164564.63],
          [3, 218.91, 617.12, 164345.72],
          [4, 219.73, 616.30, 164125.99],
          [5, 220.56, 615.47, 163905.43],
          [6, 221.38, 614.65, 163684.05],
          [7, 222.21, 613.82, 163461.84],
          [8, 223.05, 612.98, 163238.79],
          [9, 223.88, 612.15, 163014.91],
          [10, 224.72, 611.31, 162790.19],
          [11, 225.57, 610.46, 162564.62],
          [12, 226.41, 609.62, 162338.21],
          [13, 227.26, 608.77, 162110.95],
          [14, 228.11, 607.92, 161882.84],
          [15, 228.97, 607.06, 161653.87],
          [16, 229.83, 606.20, 161424.04],
          [17, 230.69, 605.34, 161193.35],
          [18, 231.55, 604.48, 160961.80],
          [19, 232.42, 603.61, 160729.38],
          [20, 233.29, 602.74, 160496.09],
          [21, 234.17, 601.86, 160261.92],
          [22, 235.05, 600.98, 160026.87],
          [23, 235.93, 600.10, 159790.94],
          [24, 236.81, 599.22, 159554.13],
          [25, 237.70, 598.33, 159316.43],
          [26, 238.59, 597.44, 159077.84],
          [27, 239.49, 596.54, 158838.35],
          [28, 240.39, 595.64, 158597.96],
          [29, 241.29, 594.74, 158356.67],
          [30, 242.19, 593.84, 158114.48],
          [31, 243.10, 592.93, 157871.38],
          [32, 244.01, 592.02, 157627.37],
          [33, 244.93, 591.10, 157382.44],
          [34, 245.85, 590.18, 157136.59],
          [35, 246.77, 589.26, 156889.82],
          [36, 247.69, 588.34, 156642.13],
          [37, 248.62, 587.41, 156393.51],
          [38, 249.55, 586.48, 156143.96],
          [39, 250.49, 585.54, 155893.47],
          [40, 251.43, 584.60, 155642.04],
          [41, 252.37, 583.66, 155389.67],
          [42, 253.32, 582.71, 155136.35],
          [43, 254.27, 581.76, 154882.08],
          [44, 255.22, 580.81, 154626.86],
          [45, 256.18, 579.85, 154370.68],
          [46, 257.14, 578.89, 154113.54],
          [47, 258.10, 577.93, 153855.44],
          [48, 259.07, 576.96, 153596.37],
          [49, 260.04, 575.99, 153336.33],
          [50, 261.02, 575.01, 153075.31],
          [51, 262.00, 574.03, 152813.31],
          [52, 262.98, 573.05, 152550.33],
          [53, 263.97, 572.06, 152286.36],
          [54, 264.96, 571.07, 152021.40],
          [55, 265.95, 570.08, 151755.45],
          [56, 266.95, 569.08, 151488.50],
          [57, 267.95, 568.08, 151220.55],
          [58, 268.95, 567.08, 150951.60],
          [59, 269.96, 566.07, 150681.64],
          [60, 270.97, 565.06, 150410.67],
          [61, 271.99, 564.04, 150138.68],
          [62, 273.01, 563.02, 149865.67],
          [63, 274.03, 562.00, 149591.64],
          [64, 275.06, 560.97, 149316.58],
          [65, 276.09, 559.94, 149040.49],
          [66, 277.13, 558.90, 148763.36],
          [67, 278.17, 557.86, 148485.19],
          [68, 279.21, 556.82, 148205.98],
          [69, 280.26, 555.77, 147925.72],
          [70, 281.31, 554.72, 147644.41],
          [71, 282.36, 553.67, 147362.05],
          [72, 283.42, 552.61, 147078.63],
          [73, 284.49, 551.54, 146794.14],
          [74, 285.55, 550.48, 146508.59],
          [75, 286.62, 549.41, 146221.97],
          [76, 287.70, 548.33, 145934.27],
          [77, 288.78, 547.25, 145645.49],
          [78, 289.86, 546.17, 145355.63],
          [79, 290.95, 545.08, 145064.68],
          [80, 292.04, 543.99, 144772.64],
          [81, 293.13, 542.90, 144479.51],
          [82, 294.23, 541.80, 144185.28],
          [83, 295.34, 540.69, 143889.94],
          [84, 296.44, 539.59, 143593.50],
          [85, 297.55, 538.48, 143295.95],
          [86, 298.67, 537.36, 142997.28],
          [87, 299.79, 536.24, 142697.49],
          [88, 300.91, 535.12, 142396.58],
          [89, 302.04, 533.99, 142094.54],
          [90, 303.18, 532.85, 141791.36],
          [91, 304.31, 531.72, 141487.05],
          [92, 305.45, 530.58, 141181.60],
          [93, 306.60, 529.43, 140875.00],
          [94, 307.75, 528.28, 140567.25],
          [95, 308.90, 527.13, 140258.35],
          [96, 310.06, 525.97, 139948.29],
          [97, 311.22, 524.81, 139637.07],
          [98, 312.39, 523.64, 139324.68],
          [99, 313.56, 522.47, 139011.12],
          [100, 314.74, 521.29, 138696.38],
          [101, 315.92, 520.11, 138380.46],
          [102, 317.10, 518.93, 138063.36],
          [103, 318.29, 517.74, 137745.07],
          [104, 319.49, 516.54, 137425.58],
          [105, 320.68, 515.35, 137104.90],
          [106, 321.89, 514.14, 136783.01],
          [107, 323.09, 512.94, 136459.92],
          [108, 324.31, 511.72, 136135.61],
          [109, 325.52, 510.51, 135810.09],
          [110, 326.74, 509.29, 135483.35],
          [111, 327.97, 508.06, 135155.38],
          [112, 329.20, 506.83, 134826.18],
          [113, 330.43, 505.60, 134495.75],
          [114, 331.67, 504.36, 134164.08],
          [115, 332.91, 503.12, 133831.17],
          [116, 334.16, 501.87, 133497.01],
          [117, 335.42, 500.61, 133161.59],
          [118, 336.67, 499.36, 132824.92],
          [119, 337.94, 498.09, 132486.98],
          [120, 339.20, 496.83, 132147.78],
          [121, 340.48, 495.55, 131807.30],
          [122, 341.75, 494.28, 131465.55],
          [123, 343.03, 493.00, 131122.52],
          [124, 344.32, 491.71, 130778.20],
          [125, 345.61, 490.42, 130432.59],
          [126, 346.91, 489.12, 130085.68],
          [127, 348.21, 487.82, 129737.47],
          [128, 349.51, 486.52, 129387.96],
          [129, 350.83, 485.20, 129037.13],
          [130, 352.14, 483.89, 128684.99],
          [131, 353.46, 482.57, 128331.53],
          [132, 354.79, 481.24, 127976.74],
          [133, 356.12, 479.91, 127620.62],
          [134, 357.45, 478.58, 127263.17],
          [135, 358.79, 477.24, 126904.38],
          [136, 360.14, 475.89, 126544.24],
          [137, 361.49, 474.54, 126182.75],
          [138, 362.84, 473.19, 125819.91],
          [139, 364.21, 471.82, 125455.70],
          [140, 365.57, 470.46, 125090.13],
          [141, 366.94, 469.09, 124723.19],
          [142, 368.32, 467.71, 124354.87],
          [143, 369.70, 466.33, 123985.17],
          [144, 371.09, 464.94, 123614.08],
          [145, 372.48, 463.55, 123241.60],
          [146, 373.87, 462.16, 122867.73],
          [147, 375.28, 460.75, 122492.45],
          [148, 376.68, 459.35, 122115.77],
          [149, 378.10, 457.93, 121737.67],
          [150, 379.51, 456.52, 121358.16],
          [151, 380.94, 455.09, 120977.22],
          [152, 382.37, 453.66, 120594.85],
          [153, 383.80, 452.23, 120211.05],
          [154, 385.24, 450.79, 119825.81],
          [155, 386.68, 449.35, 119439.13],
          [156, 388.13, 447.90, 119051.00],
          [157, 389.59, 446.44, 118661.41],
          [158, 391.05, 444.98, 118270.36],
          [159, 392.52, 443.51, 117877.84],
          [160, 393.99, 442.04, 117483.85],
          [161, 395.47, 440.56, 117088.38],
          [162, 396.95, 439.08, 116691.43],
          [163, 398.44, 437.59, 116292.99],
          [164, 399.93, 436.10, 115893.06],
          [165, 401.43, 434.60, 115491.63],
          [166, 402.94, 433.09, 115088.69],
          [167, 404.45, 431.58, 114684.24],
          [168, 405.96, 430.07, 114278.28],
          [169, 407.49, 428.54, 113870.79],
          [170, 409.01, 427.02, 113461.78],
          [171, 410.55, 425.48, 113051.23],
          [172, 412.09, 423.94, 112639.14],
          [173, 413.63, 422.40, 112225.51],
          [174, 415.18, 420.85, 111810.33],
          [175, 416.74, 419.29, 111393.59],
          [176, 418.30, 417.73, 110975.29],
          [177, 419.87, 416.16, 110555.42],
          [178, 421.45, 414.58, 110133.97],
          [179, 423.03, 413.00, 109710.94],
          [180, 424.61, 411.42, 109286.33],
          [181, 426.21, 409.82, 108860.12],
          [182, 427.80, 408.23, 108432.32],
          [183, 429.41, 406.62, 108002.91],
          [184, 431.02, 405.01, 107571.89],
          [185, 432.64, 403.39, 107139.25],
          [186, 434.26, 401.77, 106704.99],
          [187, 435.89, 400.14, 106269.10],
          [188, 437.52, 398.51, 105831.58],
          [189, 439.16, 396.87, 105392.42],
          [190, 440.81, 395.22, 104951.61],
          [191, 442.46, 393.57, 104509.15],
          [192, 444.12, 391.91, 104065.03],
          [193, 445.79, 390.24, 103619.24],
          [194, 447.46, 388.57, 103171.78],
          [195, 449.14, 386.89, 102722.64],
          [196, 450.82, 385.21, 102271.82],
          [197, 452.51, 383.52, 101819.31],
          [198, 454.21, 381.82, 101365.10],
          [199, 455.91, 380.12, 100909.19],
          [200, 457.62, 378.41, 100451.57],
          [201, 459.34, 376.69, 99992.23],
          [202, 461.06, 374.97, 99531.17],
          [203, 462.79, 373.24, 99068.38],
          [204, 464.52, 371.51, 98603.86],
          [205, 466.27, 369.76, 98137.59],
          [206, 468.01, 368.02, 97669.58],
          [207, 469.77, 366.26, 97199.81],
          [208, 471.53, 364.50, 96728.28],
          [209, 473.30, 362.73, 96254.98],
          [210, 475.07, 360.96, 95779.91],
          [211, 476.86, 359.17, 95303.05],
          [212, 478.64, 357.39, 94824.41],
          [213, 480.44, 355.59, 94343.97],
          [214, 482.24, 353.79, 93861.73],
          [215, 484.05, 351.98, 93377.68],
          [216, 485.86, 350.17, 92891.82],
          [217, 487.69, 348.34, 92404.13],
          [218, 489.51, 346.52, 91914.62],
          [219, 491.35, 344.68, 91423.27],
          [220, 493.19, 342.84, 90930.08],
          [221, 495.04, 340.99, 90435.04],
          [222, 496.90, 339.13, 89938.14],
          [223, 498.76, 337.27, 89439.38],
          [224, 500.63, 335.40, 88938.75],
          [225, 502.51, 333.52, 88436.24],
          [226, 504.39, 331.64, 87931.85],
          [227, 506.29, 329.74, 87425.56],
          [228, 508.18, 327.85, 86917.38],
          [229, 510.09, 325.94, 86407.29],
          [230, 512.00, 324.03, 85895.29],
          [231, 513.92, 322.11, 85381.37],
          [232, 515.85, 320.18, 84865.52],
          [233, 517.78, 318.25, 84347.74],
          [234, 519.73, 316.30, 83828.01],
          [235, 521.67, 314.36, 83306.34],
          [236, 523.63, 312.40, 82782.71],
          [237, 525.59, 310.44, 82257.12],
          [238, 527.57, 308.46, 81729.55],
          [239, 529.54, 306.49, 81200.01],
          [240, 531.53, 304.50, 80668.48],
          [241, 533.52, 302.51, 80134.96],
          [242, 535.52, 300.51, 79599.44],
          [243, 537.53, 298.50, 79061.91],
          [244, 539.55, 296.48, 78522.36],
          [245, 541.57, 294.46, 77980.79],
          [246, 543.60, 292.43, 77437.19],
          [247, 545.64, 290.39, 76891.55],
          [248, 547.69, 288.34, 76343.86],
          [249, 549.74, 286.29, 75794.12],
          [250, 551.80, 284.23, 75242.32],
          [251, 553.87, 282.16, 74688.45],
          [252, 555.95, 280.08, 74132.50],
          [253, 558.03, 278.00, 73574.47],
          [254, 560.13, 275.90, 73014.34],
          [255, 562.23, 273.80, 72452.11],
          [256, 564.33, 271.70, 71887.78],
          [257, 566.45, 269.58, 71321.33],
          [258, 568.58, 267.45, 70752.75],
          [259, 570.71, 265.32, 70182.04],
          [260, 572.85, 263.18, 69609.19],
          [261, 575.00, 261.03, 69034.19],
          [262, 577.15, 258.88, 68457.04],
          [263, 579.32, 256.71, 67877.72],
          [264, 581.49, 254.54, 67296.23],
          [265, 583.67, 252.36, 66712.56],
          [266, 585.86, 250.17, 66126.70],
          [267, 588.05, 247.98, 65538.65],
          [268, 590.26, 245.77, 64948.39],
          [269, 592.47, 243.56, 64355.92],
          [270, 594.70, 241.33, 63761.22],
          [271, 596.93, 239.10, 63164.29],
          [272, 599.16, 236.87, 62565.13],
          [273, 601.41, 234.62, 61963.72],
          [274, 603.67, 232.36, 61360.05],
          [275, 605.93, 230.10, 60754.12],
          [276, 608.20, 227.83, 60145.92],
          [277, 610.48, 225.55, 59535.44],
          [278, 612.77, 223.26, 58922.67],
          [279, 615.07, 220.96, 58307.60],
          [280, 617.38, 218.65, 57690.22],
          [281, 619.69, 216.34, 57070.53],
          [282, 622.02, 214.01, 56448.51],
          [283, 624.35, 211.68, 55824.16],
          [284, 626.69, 209.34, 55197.47],
          [285, 629.04, 206.99, 54568.43],
          [286, 631.40, 204.63, 53937.03],
          [287, 633.77, 202.26, 53303.26],
          [288, 636.14, 199.89, 52667.12],
          [289, 638.53, 197.50, 52028.59],
          [290, 640.92, 195.11, 51387.67],
          [291, 643.33, 192.70, 50744.34],
          [292, 645.74, 190.29, 50098.60],
          [293, 648.16, 187.87, 49450.44],
          [294, 650.59, 185.44, 48799.85],
          [295, 653.03, 183.00, 48146.82],
          [296, 655.48, 180.55, 47491.34],
          [297, 657.94, 178.09, 46833.40],
          [298, 660.40, 175.63, 46173.00],
          [299, 662.88, 173.15, 45510.12],
          [300, 665.37, 170.66, 44844.75],
          [301, 667.86, 168.17, 44176.89],
          [302, 670.37, 165.66, 43506.52],
          [303, 672.88, 163.15, 42833.64],
          [304, 675.40, 160.63, 42158.24],
          [305, 677.94, 158.09, 41480.30],
          [306, 680.48, 155.55, 40799.82],
          [307, 683.03, 153.00, 40116.79],
          [308, 685.59, 150.44, 39431.20],
          [309, 688.16, 147.87, 38743.04],
          [310, 690.74, 145.29, 38052.30],
          [311, 693.33, 142.70, 37358.97],
          [312, 695.93, 140.10, 36663.04],
          [313, 698.54, 137.49, 35964.50],
          [314, 701.16, 134.87, 35263.34],
          [315, 703.79, 132.24, 34559.55],
          [316, 706.43, 129.60, 33853.12],
          [317, 709.08, 126.95, 33144.04],
          [318, 711.74, 124.29, 32432.30],
          [319, 714.41, 121.62, 31717.89],
          [320, 717.09, 118.94, 31000.80],
          [321, 719.78, 116.25, 30281.02],
          [322, 722.48, 113.55, 29558.54],
          [323, 725.19, 110.84, 28833.35],
          [324, 727.90, 108.13, 28105.45],
          [325, 730.63, 105.40, 27374.82],
          [326, 733.37, 102.66, 26641.45],
          [327, 736.12, 99.91, 25905.33],
          [328, 738.89, 97.14, 25166.44],
          [329, 741.66, 94.37, 24424.78],
          [330, 744.44, 91.59, 23680.34],
          [331, 747.23, 88.80, 22933.11],
          [332, 750.03, 86.00, 22183.08],
          [333, 752.84, 83.19, 21430.24],
          [334, 755.67, 80.36, 20674.57],
          [335, 758.50, 77.53, 19916.07],
          [336, 761.34, 74.69, 19154.73],
          [337, 764.20, 71.83, 18390.53],
          [338, 767.07, 68.96, 17623.46],
          [339, 769.94, 66.09, 16853.52],
          [340, 772.83, 63.20, 16080.69],
          [341, 775.73, 60.30, 15304.96],
          [342, 778.64, 57.39, 14526.32],
          [343, 781.56, 54.47, 13744.76],
          [344, 784.49, 51.54, 12960.27],
          [345, 787.43, 48.60, 12172.84],
          [346, 790.38, 45.65, 11382.46],
          [347, 793.35, 42.68, 10589.11],
          [348, 796.32, 39.71, 9792.79],
          [349, 799.31, 36.72, 8993.48],
          [350, 802.30, 33.73, 8191.18],
          [351, 805.31, 30.72, 7385.87],
          [352, 808.33, 27.70, 6577.54],
          [353, 811.36, 24.67, 5766.18],
          [354, 814.41, 21.62, 4951.77],
          [355, 817.46, 18.57, 4134.31],
          [356, 820.53, 15.50, 3313.78],
          [357, 823.60, 12.43, 2490.18],
          [358, 826.69, 9.34, 1663.49],
          [359, 829.79, 6.24, 833.70],
          [360, 833.70, 3.13, 0.00]
      ]
    end
    let(:result_payments) do
      payment_plan.payments.collect do |payment|
        [payment.number, payment.principal, payment.interest, payment.balance]
      end
    end
    it 'calculates payment plan' do
      expect(result_payments).to eq(expected)
    end
  end
end