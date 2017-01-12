//
//  ZProgressViewController.swift
//  ZProgress-Swift
//
//  Created by dazhongge on 2017/1/12.
//  Copyright © 2017年 dazhongge. All rights reserved.
//

import UIKit

class ZProgressViewController: ZSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let z = ZProgressView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200), circleFrame: CGRect.init(x: 0, y: 0, width: 200, height: 200), strokeColor: .orange, animationType: .ZSlow)
        print(z)
    }

}
