//
//  RESTAPI.swift
//  Sadari
//
//  Created by kimjiwook on 2014. 12. 12..
//  Copyright (c) 2014년 KimJiWook. All rights reserved.
//

import Foundation

class RESTAPI {
    
    class func players(ymd:NSString) -> [Players] {
        // http://my-sadari.herokuapp.com/api/statistics/players.json?from=2014-12-01
        var result = [Players]()
        
        let manager:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        var prameters:NSDictionary = ["from":ymd]
        let serializer:AFJSONRequestSerializer = AFJSONRequestSerializer()

        manager.requestSerializer = serializer
//        manager.operationQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
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
    
    class func sync_players(ymd:NSString) -> String {
        let url:NSURL = NSURL(string:"http://my-sadari.herokuapp.com/api/statistics/players.json")!
        let request:NSURLRequest = NSURLRequest(URL: url)
        let op:AFHTTPRequestOperation = AFHTTPRequestOperation(request: request)
        var str:NSString = "계산된 뒤 넘어가야함"
        op.responseSerializer = AFJSONResponseSerializer()
        op.setCompletionBlockWithSuccess({(opertion:AFHTTPRequestOperation!, responseObject:AnyObject!) in
            str = str + "(추가된 데이터)"
            NSLog("\(str)")
        }, failure: nil)
        NSOperationQueue.mainQueue().addOperation(op)
        return str
    }
    
    class func test_players(ymd:NSString, completion:(NSString) -> String){
        
//        NSLog("\(completion)")
        var str = "Sample"
        let url:NSURL = NSURL(string:"http://my-sadari.herokuapp.com/api/statistics/players.json")!
        let request:NSURLRequest = NSURLRequest(URL: url)
        let op:AFHTTPRequestOperation = AFHTTPRequestOperation(request: request)
        op.responseSerializer = AFJSONResponseSerializer()
        op.setCompletionBlockWithSuccess({(opertion:AFHTTPRequestOperation!, responseObject:AnyObject!) in
            str = str + "(추가된 데이터)"
            NSLog("내부 \(str)")
            // 클로저 함수
            str = completion(str)
            NSLog("내부 클로저 \(str)")
            
            }, failure: nil)
    }
    
    
    
    
    
    
    
    
}