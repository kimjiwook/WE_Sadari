//
//  REST_Players.swift
//  Sadari
//
//  Created by kimjiwook on 2014. 12. 11..
//  Copyright (c) 2014년 KimJiWook. All rights reserved.
//

import Foundation


class REST_Players {
    
    class func getMonthPlayers(ymd:NSString) -> String {
// http://my-sadari.herokuapp.com/api/statistics/players.json?from=2014-12-01
        let manager:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        var prameters:NSDictionary = ["from":ymd]
        let serializer:AFJSONRequestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer = serializer
        manager.GET("http://my-sadari.herokuapp.com/api/statistics/players.json",
            parameters: prameters,
            success: {(operation:AFHTTPRequestOperation!, responseObject:AnyObject!) in
                var dic:NSDictionary = responseObject as NSDictionary
                var json:NSMutableArray = dic["data"] as NSMutableArray
                
                for datas in json {
                    var data:NSMutableDictionary = datas as NSMutableDictionary
                    var count:Int = data["count"] as Int
                    var player:NSMutableDictionary = datas["player"] as NSMutableDictionary
                    var name = player["name"] as String
                    NSLog("걸린수 : \(count) 이름 : \(name)")
                    
                    
                    
                }
                
            },
            failure: {(operation:AFHTTPRequestOperation!, error:NSError!) in
                NSLog("Error : \(error)")
        })
        
        return "Hi"
    }
}