//
//  ViewController.swift
//  PulseAnimation
//
//  Created by Mojave on 26/05/20.
//  Copyright © 2020 Mojave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animationView: UIImageView!{
        didSet{
            animationView.layer.cornerRadius = 100
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        UIView.transition(with: animationView,
//                          duration: 5,
//                          options: [.allowUserInteraction,.curveEaseIn],
//                          animations: {
//                            self.animationView.backgroundColor = .blue
//        })
        
        animationView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addPulse))
        animationView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func addPulse(){
        let pulse = Pulsing(numberOfPulses: 1, radius: (animationView.frame.width / 2), position: animationView.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.red.cgColor
        
        self.view.layer.insertSublayer(pulse, below: animationView.layer)
    }

}
