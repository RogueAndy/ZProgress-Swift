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

    public var animationType: ZAnimationType! {
    
        willSet(type) {
        
            self.animationType = type
            switch self.animationType! {
            case .ZQuickly:
                self.strokeProgressCount = 0.03
                self.timerSecond = 0.005
            case .ZCommon:
                self.strokeProgressCount = 0.01
                self.timerSecond = 0.005
            case .ZSlow:
                self.strokeProgressCount = 0.001
                self.timerSecond = 0.005
            }
        
        }
    
    }
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
                self.shapeLayer?.strokeStart = CGFloat(self.strokeStart)
                self.countNumber = self.strokeStart
                self.animationTimer = Timer.scheduledTimer(timeInterval: Double(self.timerSecond), target: self, selector: #selector(startAction), userInfo: nil, repeats: true)
                
            }
        
        }
        
    }
    public var clearAnimation: Bool? {
    
        willSet(animation) {
        
            self.clearAnimation = animation
            if self.clearAnimation == true {
            
                self.animationTimer?.invalidate()
                self.animationTimer = nil
                self.countNumber = self.strokeEnd
                self.animationTimer = Timer.scheduledTimer(timeInterval: Double(self.timerSecond), target: self, selector: #selector(clearAction), userInfo: nil, repeats: true)
                return
            
            }
        
        }
    
    }
    public var strokeStart: Float = 0
    public var strokeEnd: Float = 1
    
    private var shapeLayer: CAShapeLayer?
    private var animationTimer: Timer?
    private var countNumber: Float!
    private var timerSecond: Float!
    private var strokeProgressCount: Float!
    
    /// 初始化方法，但是在初始化的时候，所有的 init 方法里，都不会调用私有属性的 willSet 方法，所以把属性赋值放入 loadNeed(frame: CGRect, circleFrame: CGRect, strokeColor: UIColor, animationType: ZAnimationType)，才能让其调用 willSet() 方法
    ///
    /// - Parameters:
    ///   - frame: 设置界面大小
    ///   - circleFrame: 设置圆圈的界面大小
    ///   - strokeColor: 设置填充圆圈的颜色
    ///   - animationType: 动画速度
    public init(frame: CGRect, circleFrame: CGRect, strokeColor: UIColor, animationType: ZAnimationType) {
    
        super.init(frame: frame)
        self.loadNeed(frame: frame, circleFrame: circleFrame, strokeColor: strokeColor, animationType: animationType)
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
    
    // MARK: - 设置 private 方法
    
    private func loadNeed(frame: CGRect, circleFrame: CGRect, strokeColor: UIColor, animationType: ZAnimationType) {
    
        self.animationType = animationType
        self.circleFrame = circleFrame
        self.strokeColor = strokeColor
    
    }
    
    private func loadInit() {
    
        
    }
    
    private func loadViews() {
    
        self.shapeLayer = CAShapeLayer()
        self.shapeLayer!.fillColor = UIColor.clear.cgColor
        self.shapeLayer!.lineWidth = 75.0
        self.shapeLayer!.strokeColor = self.strokeColor?.cgColor
        
        let path = UIBezierPath.init(ovalIn: self.circleFrame)
        self.shapeLayer!.path = path.cgPath
        self.layer.addSublayer(self.shapeLayer!)
        self.shapeLayer!.strokeStart = 0
        self.shapeLayer!.strokeEnd = 0.0
    
    }
    
    private func loadLayout() {
    
        self.shapeLayer?.frame = self.circleFrame
        self.shapeLayer?.position = CGPoint.init(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
    
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.loadLayout()
        let path = UIBezierPath.init(ovalIn: self.circleFrame)
        self.shapeLayer?.path = path.cgPath
        
    }
    
    // MARK: - selector action
    
    /// begin current shareLayer
    ///
    /// - Parameter timer: time
    @objc private func startAction(timer: Timer) {
    
        if self.countNumber >= self.strokeEnd {
        
            self.shapeLayer?.strokeEnd = CGFloat(self.strokeEnd)
            self.animationTimer?.invalidate()
            self.animationTimer = nil
            return
        
        }
        
        self.shapeLayer?.strokeEnd = CGFloat(self.countNumber)
        self.countNumber = self.strokeProgressCount + self.countNumber
    
    }
    
    /// clear current shareLayer
    ///
    /// - Parameter timer: time
    @objc private func clearAction(timer: Timer) {
    
        if self.countNumber <= self.strokeStart {
        
            self.shapeLayer?.strokeEnd = CGFloat(self.strokeStart)
            self.animationTimer?.invalidate()
            self.animationTimer = nil
            return
        
        }
        
        self.shapeLayer?.strokeEnd = CGFloat(self.countNumber)
        self.countNumber = self.countNumber - self.strokeProgressCount
    
    }

}
