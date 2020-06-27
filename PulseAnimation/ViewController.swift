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
        

        
    }
    


}
