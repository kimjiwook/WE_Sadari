//
//  MenuTableViewController.swift
//  Sadari
//
//  Created by kimjiwook on 2014. 12. 10..
//  Copyright (c) 2014년 KimJiWook. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("MenuTableController")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.separatorColor = UIColor(red: 150/255.0, green: 161/255.0, blue: 177/255.0, alpha: 1.0)

        self.tableView.opaque = false
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.tableHeaderView = createheaderView()
        
        self.tableView.reloadData()
    }
    
    func createheaderView() -> UIView {
        var view:UIView = UIView(frame: CGRectMake(0, 0, 0, 184))
        var imageView:UIImageView = UIImageView(frame: CGRectMake(0, 40, 100, 100))
        imageView.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin
        imageView.image = UIImage(named: "02_01")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50.0
        imageView.layer.borderColor = UIColor.whiteColor().CGColor
        imageView.layer.borderWidth = 3.0
        imageView.layer.rasterizationScale = UIScreen.mainScreen().scale
        imageView.layer.shouldRasterize = true
        imageView.clipsToBounds = true
        
        var label:UILabel = UILabel(frame: CGRectMake(0, 150, 0, 24))
        label.text = "Sample"
        label.font = UIFont(name: "HelveticaNenu", size: 21)
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor(red: 62/255.0, green: 68/255.0, blue: 75/255.0, alpha: 1.0)
        label.sizeToFit()
        label.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin
        
        view.addSubview(imageView)
        view.addSubview(label)
        
        return view
    }
    ////// delegate
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor(red: 62/255.0, green: 68/255.0, blue: 75/255.0, alpha: 1.0)
        cell.textLabel?.font = UIFont(name: "HelveticaNaeue", size: 17)
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        
        var view:UIView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 34))
        view.backgroundColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 0.6)
        
        var label:UILabel = UILabel(frame: CGRectMake(10, 8, 0, 0))
        label.text = "Kim J.W info"
        label.font = UIFont.systemFontOfSize(15)
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.clearColor()
        label.sizeToFit()
        view.addSubview(label)
        
        return view
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 0
        }
        return 34
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var menuNavigationController:MenuNavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("contentController") as MenuNavigationController
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                NSLog("첫번째 (Home)")
                let calendarViewController:CalendarViewController = self.storyboard?.instantiateViewControllerWithIdentifier("calendarViewController") as CalendarViewController
                menuNavigationController.viewControllers = [calendarViewController]
            } else if (indexPath.row == 1) {
                NSLog("두번째 (Player)")
                let playersViewController:PlayersViewController = self.storyboard?.instantiateViewControllerWithIdentifier("playersViewController") as PlayersViewController
                menuNavigationController.viewControllers = [playersViewController]
            } else if (indexPath.row == 2) {
                NSLog("세번째 (Numbers")
            } else if (indexPath.row == 3) {
                NSLog("네번쨰 (Money")
            }
        } else{
            if (indexPath.row == 0) {
                NSLog("Intro 페이지")
                // Intro 일때만 팝업
                let introViewController:IntroViewController = self.storyboard?.instantiateViewControllerWithIdentifier("introViewController") as IntroViewController
//                menuNavigationController.viewControllers = [introViewController]
                self.presentViewController(introViewController, animated: true, completion:nil)
            } else {
                NSLog("Blog 페이지")
            }
        }
        
        self.frostedViewController.contentViewController = menuNavigationController
        self.frostedViewController.hideMenuViewController()
    }
    
    ////// datasource
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 54.0
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 4
        }
        return 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        
        var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        NSLog("section: \(indexPath.section),row: \(indexPath.row)")
        if (indexPath.section == 0) {
            var titles:[String] = ["Home", "Player", "Numbers", "Money"]
            cell.textLabel?.text = titles[indexPath.row]
        } else {
            var titles:[String] = ["Intro", "Blog"]
            cell.textLabel?.text = titles[indexPath.row]
        }
        
        return cell
    }
}
