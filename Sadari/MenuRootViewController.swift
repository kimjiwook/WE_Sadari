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
//        REST_Players.getMonthPlayers("2014-12-01")
        
        var results:[Players] = RESTAPI.players("2014-12-01")

        NSLog("\(results)")
        
        for result in results {
            var players:Players = result as Players
            NSLog("카운트 : \(players.count)")
            NSLog("이 름 : \(players.player.name)")
            NSLog("비 고 : \(players.player.description)")
            NSLog("삭 제 : \(players.player.deleted)")
        }
        
//        var str = RESTAPI.sync_players("")
//        NSLog("\(str)")
//        RESTAPI.test_players("", completion)
        
        
//        completion("test")
//        RESTAPI.test_players("", completion)
    }
    
    
    func completion(str:NSString)->String {
        NSLog("\(str)")
        return str
    }
}