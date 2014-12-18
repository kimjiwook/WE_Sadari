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
        
//        NSLog("메소드 시작")
//        RESTAPI.players("2014-12-01", completion:{(objects:AnyObject!, complet:Bool!) in
//            if complet == true {
//                self.setData(objects as [Players])
//            } else {
//                NSLog("Error")
//            }
//        })
//        NSLog("메소드 끝나고")
    }
    
    func setData(players:[Players]) {
        for player in players {
            NSLog("카운트 : \(player.count)")
            NSLog("이 름 : \(player.player.name)")
            NSLog("비 고 : \(player.player.description)")
            NSLog("삭 제 : \(player.player.deleted)")
        }
    }
}