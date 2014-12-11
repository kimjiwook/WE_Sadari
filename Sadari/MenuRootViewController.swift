//
//  MenuRootViewController.swift
//  Sadari
//
//  Created by kimjiwook on 2014. 12. 9..
//  Copyright (c) 2014년 KimJiWook. All rights reserved.
//

import Foundation
import UIKit

class MenuRootViewController: REFrostedViewController {
    override func awakeFromNib() {
        // 첫 시작 만들어주는 부분 (메뉴와 메인)
        // 1. 네비게이션 연결
        self.contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("contentController") as UIViewController
        
        // 2. 메뉴 연결
        self.menuViewController = self.storyboard?.instantiateViewControllerWithIdentifier("menuController") as UIViewController
        
        // REST 샘플
        REST_Players.getMonthPlayers("2014-12-01")
    }
}