//
//  PushLeft.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/6/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit
import QuartzCore

class PushFromLeft: UIStoryboardSegue {
    
    override func perform() {
        let src: UIViewController = self.sourceViewController 
        let dst: UINavigationController = self.destinationViewController as! UINavigationController
        let dest = dst.topViewController
        let transition: CATransition = CATransition()
        let timeFunc : CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.duration = 0.5
        transition.timingFunction = timeFunc
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        src.navigationController!.view.layer.addAnimation(transition, forKey: kCATransition)
        src.navigationController!.pushViewController(dest!, animated: false)
    }
    
}
