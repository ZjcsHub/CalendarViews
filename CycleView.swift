//
//  CycleView.swift
//  OplayerSport
//
//  Created by App005 SYNERGY on 2019/7/17.
//  Copyright © 2019 App005 SYNERGY. All rights reserved.
//

import UIKit



class CycleView: UIView {

    private var lineWidth:CGFloat = 10.0
    // 绘画layer
    private var shapeLayer:CAShapeLayer!
    
    // 渐变layer
    var gradientLayer = CAGradientLayer()
    
    var startAngle:CGFloat?
    var endAngle:CGFloat?
    
    public var progress:CGFloat? {
        didSet{
            self.animateToProgress(progress: self.progress ?? 0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect,startAngle:CGFloat? = CGFloat(Double.pi/4 + Double.pi/2),endAngle:CGFloat? = CGFloat(Double.pi / 4),lineWidth:CGFloat) {
        self.init(frame: frame)
        self.lineWidth = lineWidth
        
        self.startAngle = startAngle
        self.endAngle = endAngle
        // 画背景圆
        setBackGroundCycle()
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setBackGroundCycle()  {
        
        let viewWidth = self.frame.size.width
        let viewHeight = self.frame.size.height
        
        let center = CGPoint(x: viewWidth/2, y: viewHeight/2)
        var circlePath:UIBezierPath

        
        if let startAngle = startAngle , let endAngle = endAngle {
           circlePath  = UIBezierPath(arcCenter: center, radius: (viewWidth - lineWidth)/2  , startAngle:startAngle, endAngle: endAngle, clockwise: true)
        }else{
           return
        }
        
       
        let bgLayer = CAShapeLayer()
        bgLayer.frame = self.bounds
        bgLayer.fillColor = UIColor.clear.cgColor
        bgLayer.lineWidth = lineWidth
        bgLayer.strokeColor = UIColor(red: 212.0/255.0, green: 212.0/255.0, blue: 212.0/255.0, alpha: 1).cgColor
        bgLayer.strokeStart = 0
        bgLayer.strokeEnd = 1
        bgLayer.lineCap = .round
        bgLayer.path = circlePath.cgPath
        self.layer.addSublayer(bgLayer)
        // 用于绘画圆环的layer
        shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = .round
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0
        shapeLayer.path = circlePath.cgPath
        self.layer.addSublayer(shapeLayer)

        let leftGradientLayer = CAGradientLayer()
        leftGradientLayer.frame = CGRect(x: 0, y: 0, width: viewWidth/2, height: viewHeight)
        leftGradientLayer.colors = [UIColor(brred: 255, brgreen: 255, brblue: 0, bralpha: 1).cgColor,
                                    UIColor(brred: 255, brgreen: 255.0/2, brblue: 0, bralpha: 1).cgColor]
        leftGradientLayer.locations = [NSNumber(value: 0),NSNumber(value: 0.9)]
        leftGradientLayer.startPoint = CGPoint(x: 0, y: 1)
        leftGradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.addSublayer(leftGradientLayer)
        
        
        let rightGradientLayer = CAGradientLayer()
        rightGradientLayer.frame = CGRect(x: viewWidth/2, y: 0, width: viewWidth/2, height: viewHeight)
        rightGradientLayer.colors = [
                                    UIColor(brred: 255, brgreen: 255.0/2, brblue: 0, bralpha: 1).cgColor,
                                    UIColor(brred: 255, brgreen: 0, brblue: 0, bralpha: 1).cgColor]
        rightGradientLayer.locations = [NSNumber(value: 0.1),NSNumber(value: 1)]
        rightGradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        rightGradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        gradientLayer.addSublayer(rightGradientLayer)
        
        gradientLayer.mask = shapeLayer
        gradientLayer.frame = self.bounds
        
        self.layer.addSublayer(gradientLayer)

    }
    
    
    private func animateToProgress(progress:CGFloat) {
        shapeLayer.strokeEnd = progress
    }
}
