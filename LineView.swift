//
//  LineView.swift
//  OplayerSport
//
//  Created by App005 SYNERGY on 2019/7/26.
//  Copyright © 2019 App005 SYNERGY. All rights reserved.
//

import UIKit

class LineView: UIView {
    private var lineWidth:CGFloat = 10.0
    private var strockColor:UIColor = UIColor.red
    
    public var progress:CGFloat? {
        didSet{
            self.animateToProgress(progress: self.progress ?? 0)
        }
    }
    // 绘画layer
    private var shapeLayer:CAShapeLayer!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect,lineWidth:CGFloat,strockColor:UIColor) {
        self.init(frame: frame)
        self.lineWidth = lineWidth
        self.strockColor = strockColor
        setBackGroundCycle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setBackGroundCycle()  {
        let viewWidth = self.frame.size.width

        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: lineWidth/2, y: lineWidth/2))
        linePath.addLine(to: CGPoint(x: viewWidth - lineWidth/2, y: lineWidth/2))
        
        let bgLayer = CAShapeLayer()
        bgLayer.fillColor = UIColor.red.cgColor
        bgLayer.lineWidth = lineWidth
        bgLayer.strokeColor = UIColor(red: 212.0/255.0, green: 212.0/255.0, blue: 212.0/255.0, alpha: 1).cgColor
        bgLayer.strokeStart = 0
        bgLayer.strokeEnd = 1
        bgLayer.lineCap = .round
        bgLayer.path = linePath.cgPath
        self.layer.addSublayer(bgLayer)
       
        shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = .round
        shapeLayer.strokeColor = strockColor.cgColor
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0

        self.layer.addSublayer(shapeLayer)
        shapeLayer.path = linePath.cgPath
        
        
        
    }
    private func animateToProgress(progress:CGFloat) {
        shapeLayer.strokeEnd = progress
    }
}
