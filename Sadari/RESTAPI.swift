//
//  RESTAPI.swift
//  Sadari
//
//  Created by kimjiwook on 2014. 12. 12..
//  Copyright (c) 2014년 KimJiWook. All rights reserved.
//

import Foundation

class RESTAPI {
    
    typealias Handler = (String!, Bool!) -> Void
    
    class func players(ymd:NSString) -> [Players] {
        // http://my-sadari.herokuapp.com/api/statistics/players.json?from=2014-12-01
        var result = [Players]()
        
        let manager:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        var prameters:NSDictionary = ["from":ymd]
        let serializer:AFJSONRequestSerializer = AFJSONRequestSerializer()

        manager.requestSerializer = serializer
        manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        manager.GET("http://my-sadari.herokuapp.com/api/statistics/players.json",
            parameters: prameters,
            success: {(operation:AFHTTPRequestOperation!, responseObject:AnyObject!) in
                var dic:NSDictionary = responseObject as NSDictionary
                var json:NSMutableArray = dic["data"] as NSMutableArray

                for datas in json {
                    var data:NSMutableDictionary = datas as NSMutableDictionary
                    var count:Int = data["count"] as Int
                    var player1:NSMutableDictionary = datas["player"] as NSMutableDictionary
                    var name = player1["name"] as String
//                    NSLog("걸린수 : \(count) 이름 : \(name)")
                    
                    var players:Players = Players()
                    var player:Player = Player()
                    player.name = player1["name"] as String
                    player.description = player1["description"] as String
                    player.deleted = player1["deleted"] as Bool
                    player.defaultAmunt = player1["defaultAmount"] as Int
                    players.player = player
                    players.count = count
                    
//                    NSLog("카운트 : \(players.count)")
//                    NSLog("이 름 : \(players.player.name)")
//                    NSLog("비 고 : \(players.player.description)")
//                    NSLog("삭 제 : \(players.player.deleted)")
                    result.append(players)
//                    NSLog("\(result.count)")
                }
            },
            failure: {(operation:AFHTTPRequestOperation!, error:NSError!) in
                NSLog("Error : \(error)")
        })
        
        manager.operationQueue.waitUntilAllOperationsAreFinished()

        return result
    }
    
    class func sync_players(ymd:NSString, callback:(error:NSError!, players:[Players]?) -> Void) {
        var result = [Players]()
        
        let manager:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        var prameters:NSDictionary = ["from":ymd]
        manager.GET("http://my-sadari.herokuapp.com/api/statistics/players.json",
            parameters: prameters,
            success: {(operation:AFHTTPRequestOperation!, responseObject:AnyObject!) in
                var dic:NSDictionary = responseObject as NSDictionary
                var json:NSMutableArray = dic["data"] as NSMutableArray
                
                for datas in json {
                    var data:NSMutableDictionary = datas as NSMutableDictionary
                    var count:Int = data["count"] as Int
                    var player1:NSMutableDictionary = datas["player"] as NSMutableDictionary
                    var name = player1["name"] as String
                    //                    NSLog("걸린수 : \(count) 이름 : \(name)")
                    
                    var players:Players = Players()
                    var player:Player = Player()
                    player.name = player1["name"] as String
                    player.description = player1["description"] as String
                    player.deleted = player1["deleted"] as Bool
                    player.defaultAmunt = player1["defaultAmount"] as Int
                    players.player = player
                    players.count = count
                    
//                    NSLog("카운트 : \(players.count)")
//                    NSLog("이 름 : \(players.player.name)")
//                    NSLog("비 고 : \(players.player.description)")
//                    NSLog("삭 제 : \(players.player.deleted)")
                    result.append(players)
//                    NSLog("\(result.count)")
                }
                
                callback(error: nil, players: result)
            },
            failure: {(operation:AFHTTPRequestOperation!, error:NSError!) in
                callback(error: error, players: nil)
                NSLog("Error : \(error)")
        })
    }
    
    
    class func test(ymd:NSString, handler:Handler!) {
        var result = [Players]()
        
        let manager:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        var prameters:NSDictionary = ["from":ymd]
        manager.GET("http://my-sadari.herokuapp.com/api/statistics/players.json",
            parameters: prameters,
            success: {(operation:AFHTTPRequestOperation!, responseObject:AnyObject!) in
                var dic:NSDictionary = responseObject as NSDictionary
                var json:NSMutableArray = dic["data"] as NSMutableArray
                
                for datas in json {
                    var data:NSMutableDictionary = datas as NSMutableDictionary
                    var count:Int = data["count"] as Int
                    var player1:NSMutableDictionary = datas["player"] as NSMutableDictionary
                    var name = player1["name"] as String
                    //                    NSLog("걸린수 : \(count) 이름 : \(name)")
                    
                    var players:Players = Players()
                    var player:Player = Player()
                    player.name = player1["name"] as String
                    player.description = player1["description"] as String
                    player.deleted = player1["deleted"] as Bool
                    player.defaultAmunt = player1["defaultAmount"] as Int
                    players.player = player
                    players.count = count
        
                    result.append(players)
                }
                handler("연습 성공", true)

            },
            failure: {(operation:AFHTTPRequestOperation!, error:NSError!) in
                NSLog("Error : \(error)")
                handler("연습 실패", false)
        })
    }
    
    
    
    
    
}