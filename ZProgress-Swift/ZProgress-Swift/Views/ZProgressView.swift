//
//  ZProgressView.swift
//  ZProgress-Swift
//
//  Created by dazhongge on 2017/1/12.
//  Copyright © 2017年 dazhongge. All rights reserved.
//

import UIKit
import Foundation

enum ZAnimationType {

    case ZQuickly
    case ZCommon
    case ZSlow
    
}

class ZProgressView: UIView {

    public var animationType: ZAnimationType?
    public var strokeColor: UIColor?
    public var circleFrame: CGRect! {
    
        willSet(frame) {
         
            self.circleFrame = frame
            self.loadLayout()
        
        }
        
    }
    public var startAnimation: Bool? {
    
        willSet(animation) {
        
            self.startAnimation = animation
            if self.startAnimation == true {
            
                self.animationTimer?.invalidate()
                self.animationTimer = nil
                self.shapeLayer.strokeStart = CGFloat(self.strokeStart)
                self.countNumber = self.strokeStart
                self.animationTimer = Timer.scheduledTimer(timeInterval: Double(self.timerSecond), target: self, selector: #selector(startAction), userInfo: nil, repeats: true)
                
            }
        
        }
        
    }
    public var clearAnimation: Bool?
    public var strokeStart: Float = 0
    public var strokeEnd: Float = 1
    
    private var shapeLayer: CAShapeLayer!
    private var animationTimer: Timer?
    private var countNumber: Float!
    private var timerSecond: Float!
    private var strokeProgressCount: Float!
    
    public init(frame: CGRect, circleFrame: CGRect, strokeColor: UIColor, animationType: ZAnimationType) {
    
        super.init(frame: frame)
        self.animationType = animationType
        self.circleFrame = circleFrame;
        self.strokeColor = strokeColor;
        
        self.loadInit()
        self.loadViews()
        self.loadLayout()
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.loadInit()
        self.loadViews()
        self.loadLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadInit() {
    
        
        
    }
    
    private func loadViews() {
    
        self.shapeLayer = CAShapeLayer()
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        self.shapeLayer.lineWidth = 75.0
        self.shapeLayer.strokeColor = self.strokeColor?.cgColor
        
        let path = UIBezierPath.init(ovalIn: self.circleFrame)
        self.shapeLayer.path = path.cgPath
        self.layer.addSublayer(self.shapeLayer)
        self.shapeLayer.strokeStart = 0
        self.shapeLayer.strokeEnd = 0.0
    
    }
    
    private func loadLayout() {
    
        self.shapeLayer.frame = self.circleFrame
        self.shapeLayer.position = CGPoint.init(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
    
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.loadLayout()
        let path = UIBezierPath.init(ovalIn: self.circleFrame)
        self.shapeLayer.path = path.cgPath
        
    }
    
    // MARK - selector action
    
    @objc private func startAction(timer: Timer) {
    
        if self.countNumber >= self.strokeEnd {
        
            self.shapeLayer.strokeEnd = CGFloat(self.strokeEnd)
            self.animationTimer?.invalidate()
            self.animationTimer = nil
            return
        
        }
        
        self.shapeLayer.strokeEnd = CGFloat(self.countNumber)
        self.countNumber = self.strokeProgressCount + self.countNumber
    
    }
    
    @objc private func clearAction(timer: Timer) {
    
        if self.countNumber <= self.strokeStart {
        
            self.shapeLayer.strokeEnd = CGFloat(self.strokeStart)
            self.animationTimer?.invalidate()
            self.animationTimer = nil
            return
        
        }
        
        self.shapeLayer.strokeEnd = CGFloat(self.countNumber)
        self.countNumber = self.countNumber - self.strokeProgressCount
    
    }

}
