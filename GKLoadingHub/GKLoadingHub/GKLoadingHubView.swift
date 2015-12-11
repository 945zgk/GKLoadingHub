//
//  GKLoadingHubView.swift
//  GKLoadingHub
//
//  Created by 做功课 on 15/12/12.
//  Copyright (c) 2015年 做功课. All rights reserved.
//

import UIKit



class GKLoadingHubView: UIView {

    var ball_color: UIColor = UIColor.blackColor() // 球的颜色
    var ball_radius: CGFloat = 20.0 // 球的直径
  
    private var ball_1: UIView!
    private var ball_2: UIView!
    private var ball_3: UIView!
    
    private var HEIGHT: CGFloat = 0.0
    private var WIDTH: CGFloat = 0.0
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        HEIGHT = frame.size.height
        WIDTH = frame.size.width
        
        let view_bg = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        
        // todo 这里一设置透明度，就会出现警告
//        view_bg.alpha = 0.9
//        view_bg.layer.opacity = 0.9
        view_bg.frame = CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT)
        view_bg.layer.cornerRadius = 5.0
        view_bg.clipsToBounds = true
        
        self.addSubview(view_bg)
        self.backgroundColor = UIColor.clearColor()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    func dismissHub() {
        
    }
    
    func showHub() {
        
        let ball_y = HEIGHT * 0.5 - ball_radius * 0.5
        
        ball_1 = UIView(frame: CGRect(x: WIDTH * 0.5 - ball_radius * 1.5, y: ball_y, width: ball_radius, height: ball_radius))
        ball_1.layer.cornerRadius = ball_radius * 0.5
        ball_1.clipsToBounds = true
        ball_1.backgroundColor = ball_color
        
        ball_2 = UIView(frame: CGRect(x: WIDTH * 0.5 - ball_radius * 0.5, y: ball_y, width: ball_radius, height: ball_radius))
        ball_2.layer.cornerRadius = ball_radius * 0.5
        ball_2.clipsToBounds = true
        ball_2.backgroundColor = ball_color
        
        ball_3 = UIView(frame: CGRect(x: WIDTH * 0.5 + ball_radius * 1.5, y: ball_y, width: ball_radius, height: ball_radius))
        ball_3.layer.cornerRadius = ball_radius * 0.5
        ball_3.clipsToBounds = true
        ball_3.backgroundColor = ball_color
        
        self.addSubview(ball_1)
        self.addSubview(ball_2)
        self.addSubview(ball_3)
        
        rotationAnimation()
        
    }
    
    private func rotationAnimation() {
        
        let center_point = CGPoint(x: WIDTH * 0.5, y: HEIGHT * 0.5)
        let center_ball_1 = CGPoint(x: WIDTH * 0.5 - ball_radius, y: HEIGHT * 0.5)
        let center_ball_3 = CGPoint(x: WIDTH * 0.5 + ball_radius, y: HEIGHT * 0.5)
        
        let path_ball_1 = UIBezierPath()
        let path_ball_1_1 = UIBezierPath()
        let animation_ball_1 = CAKeyframeAnimation(keyPath: "position")
        
        let path_ball_3 = UIBezierPath()
        let path_ball_3_1 = UIBezierPath()
        let animation_ball_3 = CAKeyframeAnimation(keyPath: "position")
        
        // 第一个圆的曲线
        path_ball_1.moveToPoint(center_ball_1)
        path_ball_1.addArcWithCenter(center_point, radius: ball_radius, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI * 2), clockwise: false)
        
        path_ball_1_1.addArcWithCenter(center_point, radius: ball_radius, startAngle: 0.0, endAngle: CGFloat(M_PI), clockwise: false)
        
        path_ball_1.appendPath(path_ball_1_1)
        
        // 第一个圆的动画
        animation_ball_1.path = path_ball_1.CGPath
        animation_ball_1.removedOnCompletion = false
        animation_ball_1.fillMode = kCAFillModeForwards
        animation_ball_1.calculationMode = kCAAnimationCubic
        animation_ball_1.repeatCount = 1
        animation_ball_1.duration = 1.4
        animation_ball_1.delegate = self
        animation_ball_1.autoreverses = false // 不回到原位
        animation_ball_1.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        ball_1.layer.addAnimation(animation_ball_1, forKey: "animation")
        
        // 第三个圆的曲线
        path_ball_3.moveToPoint(center_ball_3)
        path_ball_3.addArcWithCenter(center_point, radius: ball_radius, startAngle: 0.0, endAngle: CGFloat(M_PI), clockwise: false)
        
        path_ball_3_1.addArcWithCenter(center_point, radius: ball_radius, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI * 2), clockwise: false)
        
        path_ball_3.appendPath(path_ball_3_1)
        
        // 第三个圆的动画
        
        animation_ball_3.path = path_ball_3.CGPath
        animation_ball_3.removedOnCompletion = false
        animation_ball_3.fillMode = kCAFillModeForwards
        animation_ball_3.calculationMode = kCAAnimationCubic
        animation_ball_3.repeatCount = 1
        animation_ball_3.duration = 1.4
        animation_ball_3.autoreverses = false
        animation_ball_3.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        ball_3.layer.addAnimation(animation_ball_3, forKey: "animation")
        
    }
    
    // MARK: - delegate
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        self.rotationAnimation()
    }
    
    override func animationDidStart(anim: CAAnimation!) {
        
        UIView.animateWithDuration(0.3, delay: 0.1, options: .CurveEaseOut | .BeginFromCurrentState, animations: { () -> Void in
            
            self.ball_1.transform = CGAffineTransformMakeTranslation(-self.ball_radius, 0)
            self.ball_1.transform = CGAffineTransformScale(self.ball_1.transform, 0.8, 0.8)
            
            self.ball_3.transform = CGAffineTransformMakeTranslation(self.ball_radius, 0)
            self.ball_3.transform = CGAffineTransformScale(self.ball_3.transform, 0.8, 0.8)
            
            self.ball_2.transform = CGAffineTransformScale(self.ball_2.transform, 0.8, 0.8)
            
            }) { (finished: Bool) -> Void in
            
                self.ball_1.transform = CGAffineTransformIdentity
                self.ball_2.transform = CGAffineTransformIdentity
                self.ball_3.transform = CGAffineTransformIdentity
                
        }
        
    }
    
}
