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
        var manager:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        var prameters:NSDictionary = ["from":ymd]
        manager.GET("http://my-sadari.herokuapp.com/api/statistics/players.json",
            parameters: prameters,
            success: {(operation:AFHTTPRequestOperation!, responseObject:AnyObject!) in
                NSLog("Success : \(responseObject)")
                
//                let dic
            },
            failure: {(operation:AFHTTPRequestOperation!, error:NSError!) in
                NSLog("Error : \(error)")
        })
        
        return "Hi"
    }
}