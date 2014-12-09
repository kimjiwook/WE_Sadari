//
//  MenuNavigationController.swift
//  Sadari
//
//  Created by kimjiwook on 2014. 12. 9..
//  Copyright (c) 2014년 KimJiWook. All rights reserved.
//

import Foundation
import UIKit

class MenuNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "panGestureRecognized:"))
    }
    
    func panGestureRecognized(sender:UIPanGestureRecognizer) {
        self.view.endEditing(true)
        self.frostedViewController.view.endEditing(true)
        
        self.frostedViewController.panGestureRecognized(sender)
    }
}