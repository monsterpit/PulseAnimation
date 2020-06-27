//
//  PulsingView.swift
//  PulseAnimation
//
//  Created by Vikas Salian on 27/06/20.
//  Copyright © 2020 Mojave. All rights reserved.
//

import UIKit

class PulsingView: UIView {

    var pulseRadius: CGFloat = 100
    var pulseCenter: CGPoint = CGPoint(x: 0, y: 0)
    var tapCount = 0
    var progressDirectionIsClockwise: Bool = false
    var progressStrokeColor: UIColor = .blue
    var progresslineWidth: CGFloat = 10
    var wantProgressTrack: Bool = false
    var progressTrackColor: UIColor = .lightGray
    var isProgressBarPresistent: Bool = false
    
    private var layerStartAngle: CGFloat = -( CGFloat.pi / 2)
    private var layerEndAngle: CGFloat = -(CGFloat.pi / 2) - (CGFloat.pi * 2)
    private var layerClockwise: Bool = false
    
    override func draw(_ rect: CGRect) {
       isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addPulse))
        addGestureRecognizer(tapGesture)
        pulseCenter = CGPoint(x: (rect.origin.x + (rect.size.width/2)), y: (rect.origin.y + (rect.size.height/2)))
    }
    
    func addTrackLayer(){
        let tracklayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: pulseCenter, radius: pulseRadius + (progresslineWidth*2), startAngle: layerStartAngle, endAngle: layerEndAngle, clockwise: layerClockwise)
        tracklayer.path = circularPath.cgPath
        tracklayer.strokeColor = progressTrackColor.cgColor
        tracklayer.lineWidth = progresslineWidth
        tracklayer.lineCap = .round
        tracklayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(tracklayer)
    }

    
    
    @objc func addPulse(){
        tapCount += 1
        AnimationNameConstant.pulse = AnimationNameConstant.pulse + "\(tapCount)"
        let pulse = Pulsing(numberOfPulses: 1, radius: pulseRadius, position: pulseCenter)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.red.cgColor
        pulse.pulsingDelegate = self
        layer.insertSublayer(pulse, at: 0)
        
    }

}

extension PulsingView: CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let _ = anim.value(forKey: AnimationNameConstant.pulse) as? String{
            let progressAnimation = CircularProgressbar(viewCenter: pulseCenter, viewRadius: pulseRadius)
            progressAnimation.animationDuration = 1
            progressAnimation.isPersistent = isProgressBarPresistent
            if wantProgressTrack{
                addTrackLayer()
            }
            layer.addSublayer(progressAnimation)
        }
    }
}

struct AnimationNameConstant{
    static var pulse = "pulse"
    static var strokeEnd = "strokeEnd"
}
