//
//  RESTAPI.swift
//  Sadari
//
//  Created by kimjiwook on 2014. 12. 12..
//  Copyright (c) 2014년 KimJiWook. All rights reserved.
//

import Foundation

class RESTAPI {
    
    typealias Completion = (AnyObject!, Bool!) -> Void
    
    class func players(ymd:NSString, completion:Completion){
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
                completion(result,true)
            },
            failure: {(operation:AFHTTPRequestOperation!, error:NSError!) in
                NSLog("Error : \(error)")
                completion(result,false)
        })
    }
}