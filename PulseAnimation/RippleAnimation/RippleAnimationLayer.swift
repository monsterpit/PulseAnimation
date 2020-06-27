//
//  RippleAnimationLayer.swift
//  PulseAnimation
//
//  Created by Vikas Salian on 27/06/20.
//  Copyright © 2020 Mojave. All rights reserved.
//

import UIKit

class Pulsing: CALayer{
    
    var animationGroup = CAAnimationGroup()
    
    var initialPulseScale: Float = 0
    var nextPulseAfter: TimeInterval = 0
    var animationDuration: TimeInterval = 0
    var radius: CGFloat = 100
    var numberOfPulses: Float = .infinity
    var pulsingDelegate: CAAnimationDelegate?
    
    override init(layer: Any){
        super.init(layer: layer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(numberOfPulses: Float = .infinity,radius: CGFloat,position: CGPoint){
        super.init()
        
        self.backgroundColor = UIColor.black.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.radius = radius
        self.numberOfPulses = numberOfPulses
        self.position = position
    
        self.bounds = CGRect(x: 0, y: 0, width: radius * 2 , height: radius * 2)
        self.cornerRadius = radius
        
        DispatchQueue.global(qos: .default).async {
            self.setupAnimationGroup()
            
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: AnimationNameConstant.pulse)
            }
        }
    }
    
    func createScaleAnimation() -> CABasicAnimation{
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value: 1)
        scaleAnimation.toValue =  NSNumber(value: initialPulseScale)
        scaleAnimation.duration = animationDuration
        return scaleAnimation
    }
    
    func createOpacityAnimation() -> CAKeyframeAnimation{
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = animationDuration
        opacityAnimation.values = [1,0.4,0]
        opacityAnimation.keyTimes = [0,0.5,1]
        return opacityAnimation
    }
    
    func setupAnimationGroup(){
        self.animationGroup = CAAnimationGroup()
        self.animationGroup.duration = animationDuration + nextPulseAfter
        self.animationGroup.repeatCount = numberOfPulses
        
        let defaultCurve = CAMediaTimingFunction(name: .default)
        self.animationGroup.timingFunction = defaultCurve
        
        self.animationGroup.animations = [createScaleAnimation(),createOpacityAnimation()]
        self.animationGroup.setValue(AnimationNameConstant.pulse, forKey: AnimationNameConstant.pulse)
        self.animationGroup.delegate = pulsingDelegate
    }
}

