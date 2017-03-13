//
//  ZProgressViewController.swift
//  ZProgress-Swift
//
//  Created by dazhongge on 2017/1/12.
//  Copyright © 2017年 dazhongge. All rights reserved.
//

import UIKit

class ZProgressViewController: ZSBaseViewController {

    
    
    private var z1: ZProgressView! //= ZProgressView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200), circleFrame: CGRect.init(x: 0, y: 0, width: 200, height: 200), strokeColor: .orange, animationType: .ZSlow)
    private var change: Bool!
    
    override func loadViews() {
        super.loadViews()

        self.z1 = ZProgressView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200), circleFrame: CGRect.init(x: 0, y: 0, width: 200, height: 200), strokeColor: .orange, animationType: .ZSlow)
        
        self.z1.strokeStart = 0.1
        self.z1.strokeEnd = 0.9
        self.view.addSubview(self.z1)
        
        let start = UIButton.init(type: .custom)
        start.addTarget(self, action: #selector(startAction(sender:)), for: .touchUpInside)
        start.backgroundColor = .orange
        start.frame = CGRect.init(x: 75, y: 20, width: self.view.frame.size.width - 150, height: 35)
        self.view.addSubview(start)
        
        let clear = UIButton.init(type: .custom)
        clear.addTarget(self, action: #selector(clearAction(sender:)), for: .touchUpInside)
        clear.backgroundColor = .red
        clear.frame = CGRect.init(x: 75, y: 60, width: self.view.frame.size.width - 150, height: 35)
        self.view.addSubview(clear)
        
    }
    
    override func loadLayout() {
        
        super.loadLayout()
        self.z1.frame = CGRect.init(x: 0, y: 0, width: 300, height: 300)
        self.z1.circleFrame = CGRect.init(x: 0, y: 0, width: 300, height: 300)
        self.z1.center = self.view.center
        
    }

    @objc private func startAction(sender: UIButton) {
    
        self.z1.startAnimation = true
    
    }
    
    @objc private func clearAction(sender: UIButton) {
    
        self.z1.clearAnimation = true
    
    }
    
}
