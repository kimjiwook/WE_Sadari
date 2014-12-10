//
//  CalendarViewController.swift
//  Sadari
//
//  Created by kimjiwook on 2014. 12. 10..
//  Copyright (c) 2014년 KimJiWook. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func showMenu(sender: AnyObject) {
        self.view.endEditing(true)
        self.frostedViewController.view.endEditing(true)
        self.frostedViewController.presentMenuViewController()
    }
}
