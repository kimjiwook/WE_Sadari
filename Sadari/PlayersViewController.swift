//
//  PlayersViewController.swift
//  Sadari
//
//  Created by kimjiwook on 2014. 12. 18..
//  Copyright (c) 2014년 KimJiWook. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController, PNChartDelegate {
    
    var players = [Players]()
    @IBAction func showMenu(sender: AnyObject) {
        self.view.endEditing(true)
        self.frostedViewController.view.endEditing(true)
        self.frostedViewController.presentMenuViewController()
    }
    
    func setData(result:[Players]) {
//        for player in result {
//            NSLog("카운트 : \(player.count)")
//            NSLog("이 름 : \(player.player.name)")
//            NSLog("비 고 : \(player.player.description)")
//            NSLog("삭 제 : \(player.player.deleted)")
//        }
        self.players = result
        dispatch_sync(dispatch_get_main_queue(), {() in
            // 파이 차트 데이터 꾸미기
            var items:NSMutableArray! = NSMutableArray()
            for player in self.players {
                var dataItem:PNPieChartDataItem = PNPieChartDataItem()
                dataItem.value = CGFloat(player.count)
                
                switch items.count {
                case 0:
                    dataItem.color = UIColor(red: 0.0/255.0, green: 171.0/255.0, blue: 243.0/255.0, alpha: 1.0)
                case 1:
                    dataItem.color = UIColor(red: 245.0/255.0, green: 242.0/255.0, blue: 238.0/255.0, alpha: 1.0)
                case 2:
                    dataItem.color = UIColor(red: 200.0/255.0, green: 193.0/255.0, blue: 193.0/255.0, alpha: 1.0)
                case 3:
                    dataItem.color = UIColor(red: 242.0/255.0, green: 197.0/255.0, blue: 117.0/255.0, alpha: 1.0)
                case 4:
                    dataItem.color = UIColor(red: 77.0/255.0, green: 196.0/255.0, blue: 122.0/255.0, alpha: 1.0)
                case 5:
                    dataItem.color = UIColor(red: 77.0/255.0, green: 216.0/255.0, blue: 122.0/255.0, alpha: 1.0)
                case 6:
                    dataItem.color = UIColor(red: 94.0/255.0, green: 147.0/255.0, blue: 113.0/255.0, alpha: 1.0)
                default:
                    dataItem.color = UIColor(red: CGFloat(rand()%255)/255.0, green: CGFloat(rand()%255)/255.0, blue: CGFloat(rand()%255)/255.0, alpha: 1.0)
                }

                dataItem.textDescription = player.player.name + "(\(player.count))"
                items.addObject(dataItem)
            }
                
            var pieChart:PNPieChart = PNPieChart(frame: CGRectMake(0, 70, self.view.frame.width, self.view.frame.width), items: items)
            pieChart.strokeChart()
            self.view.addSubview(pieChart)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RESTAPI.players("\(NSDate())", completion:{(objects:AnyObject!, complet:Bool!) in
            if complet == true {
                NSLog("Players Complet")
                self.setData(objects as [Players])
            } else {
                NSLog("Platers Error")
            }
        })
    }
    
    func userClickedOnLineKeyPoint(point: CGPoint, lineIndex: Int, pointIndex: Int) {
        
    }
    
    func userClickedOnLinePoint(point: CGPoint, lineIndex: Int) {
        
    }
    
    func userClickedOnBarAtIndex(barIndex: Int) {
        
    }
}
