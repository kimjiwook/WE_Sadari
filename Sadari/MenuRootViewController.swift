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
        
//        var results:[Players] = RESTAPI.players("2014-12-01")
//
//        NSLog("\(results)")
//        
//        for result in results {
//            var players:Players = result as Players
//            NSLog("카운트 : \(players.count)")
//            NSLog("이 름 : \(players.player.name)")
//            NSLog("비 고 : \(players.player.description)")
//            NSLog("삭 제 : \(players.player.deleted)")
//        }
        
//        RESTAPI.sync_players("2014-12-01", callback)
        NSLog("메소드 시작")
        RESTAPI.test("2014-12-01", handler: {(str:String!, bool:Bool!) in
            NSLog("\(str), \(bool)")
        })
        NSLog("메소드 끝나고")
    }
    
    
    func callback(error:NSError!, players:[Players]?) {
        if (error != nil) {
            for player in players! {
                NSLog("카운트 : \(player.count)")
                NSLog("이 름 : \(player.player.name)")
                NSLog("비 고 : \(player.player.description)")
                NSLog("삭 제 : \(player.player.deleted)")
            }
        } else {
            NSLog("error: \(error)")
        }
    }
}