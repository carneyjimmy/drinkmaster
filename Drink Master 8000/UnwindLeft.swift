//
//  UnwindLeft.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/6/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit
import QuartzCore

class UnwindLeft: UIStoryboardSegue {

    override func perform() {
        let src: UIViewController = self.sourceViewController
        let transition: CATransition = CATransition()
        let timeFunc : CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.duration = 0.5
        transition.timingFunction = timeFunc
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        src.navigationController!.view.layer.addAnimation(transition, forKey: kCATransition)
        src.navigationController!.popViewControllerAnimated(true)
        src.dismissViewControllerAnimated(false, completion: {})
    }
    
}
