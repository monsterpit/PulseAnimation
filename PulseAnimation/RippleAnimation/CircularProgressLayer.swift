//
//  CircularProgressLayer.swift
//  PulseAnimation
//
//  Created by Vikas Salian on 27/06/20.
//  Copyright © 2020 Mojave. All rights reserved.
//

import UIKit

class CircularProgressbar : CAShapeLayer{
    
    private var layerCenter: CGPoint = CGPoint(x: 0, y: 0)
    private var layerRadius: CGFloat = 0
    private var layerStartAngle: CGFloat = -( CGFloat.pi / 2)
    private var layerEndAngle: CGFloat = -(CGFloat.pi / 2) - (CGFloat.pi * 2)
    private var layerClockwise: Bool = false
    var animationDuration: TimeInterval = 3
    var animationGroup = CAAnimationGroup()
    var isPersistent: Bool = false
    
    override init(layer: Any) {
        super.init(layer: layer)
    }

    required init?(coder: NSCoder) {
       super.init(coder: coder)
    }
    
    init(viewCenter: CGPoint,viewRadius: CGFloat,progressStartAngle: CGFloat = -( CGFloat.pi / 2),progressEndAngle: CGFloat =  -(CGFloat.pi / 2) - (CGFloat.pi * 2)  ,progressDirectionIsClockwise: Bool = false ,viewStrokeColor: UIColor = .blue,viewlineWidth: CGFloat = 10,viewfillColor: UIColor = .clear){
        super.init()
        self.layerCenter = viewCenter
        self.layerRadius = viewRadius + (viewlineWidth * 2)
        self.layerStartAngle = progressStartAngle
        self.layerEndAngle = progressEndAngle
        self.layerClockwise = progressDirectionIsClockwise
        self.strokeColor = viewStrokeColor.cgColor
        self.lineWidth = viewlineWidth
        self.fillColor = viewfillColor.cgColor
        self.lineCap = .round
        DispatchQueue.global(qos: .default).async {
           
            self.setupAnimationGroup()
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: AnimationNameConstant.strokeEnd)
            }
        }

    }

    func createACircularProgressAnimation() -> CABasicAnimation{
        let circularPath = UIBezierPath(arcCenter: layerCenter, radius: layerRadius, startAngle: layerStartAngle, endAngle: layerEndAngle, clockwise: layerClockwise)
        self.path = circularPath.cgPath
        strokeEnd = 0
        let circularProgressAnimation = CABasicAnimation(keyPath: AnimationNameConstant.strokeEnd)
        circularProgressAnimation.toValue = 1
        circularProgressAnimation.duration = animationDuration
        return circularProgressAnimation
    }

    
    func setupAnimationGroup(){
        self.animationGroup = CAAnimationGroup()
        self.animationGroup.duration = animationDuration
        self.animationGroup.setValue(AnimationNameConstant.strokeEnd, forKey: AnimationNameConstant.strokeEnd)
        self.animationGroup.animations = [createACircularProgressAnimation()]
        
        if isPersistent{
            self.animationGroup.fillMode = .forwards
            self.animationGroup.isRemovedOnCompletion = false
        }
    }
    
}
