//
//  CalendarViewController.swift
//  Sadari
//
//  Created by kimjiwook on 2014. 12. 10..
//  Copyright (c) 2014년 KimJiWook. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, JTCalendarDataSource {

    @IBOutlet weak var calendarContentView: JTCalendarContentView!
    @IBOutlet weak var calendarMenuView: JTCalendarMenuView!
    var calendar:JTCalendar! = JTCalendar()
    
    var eventsByDate:NSMutableDictionary = NSMutableDictionary()

    @IBAction func showMenu(sender: AnyObject) {
        self.view.endEditing(true)
        self.frostedViewController.view.endEditing(true)
        self.frostedViewController.presentMenuViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calendar.calendarAppearance.calendar().firstWeekday = 1
        self.calendar.calendarAppearance.dayCircleRatio = 9.0/10.0
        self.calendar.calendarAppearance.ratioContentMenu = 2.0
    
        self.calendar.calendarAppearance.monthBlock = {(date:NSDate!, jt_calendar:JTCalendar!) -> String! in
            var b_calendar:NSCalendar = jt_calendar.calendarAppearance.calendar()
            var comps:NSDateComponents = b_calendar.components(NSCalendarUnit.YearCalendarUnit|NSCalendarUnit.MonthCalendarUnit, fromDate: date)
            var currentMonthIndex:NSInteger = comps.month
            
            var dateFormatter:NSDateFormatter?
            
            if (dateFormatter == nil) {
                dateFormatter = NSDateFormatter()
                dateFormatter?.timeZone = jt_calendar.calendarAppearance.calendar().timeZone
            }
            
            while(currentMonthIndex <= 0) {
                currentMonthIndex += 12
            }
            
            var dates:NSArray! = dateFormatter?.standaloneMonthSymbols as [AnyObject]!
            var monthText:NSString! = dates[currentMonthIndex-1].capitalizedString
            return "\(comps.year)\n\(monthText)"
        }
        
        self.calendar.menuMonthsView = self.calendarMenuView
        self.calendar.contentView = self.calendarContentView
        self.calendar.dataSource = self
        
        self.createRandomEvents()
        
        self.calendar.currentDate = NSDate()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.calendar.reloadData()
    }
    
    func calendarHaveEvent(calendar: JTCalendar!, date: NSDate!) -> Bool {
        var key = self.dateFormatter().stringFromDate(date)
        if (eventsByDate[key] != nil && (eventsByDate[key]?.count > 0)) {
            return true
        }
        return false
    }
    
    func calendarDidDateSelected(calendar: JTCalendar!, date: NSDate!) {
        var key = self.dateFormatter().stringFromDate(date)
        var events:NSArray? = eventsByDate[key] as? NSArray
        NSLog("Date:\(date) - event : \(events?.count)")
    }
    
    func calendarDidLoadPreviousPage() {
        NSLog("이전 페이지")
    }
    
    func calendarDidLoadNextPage() {
        NSLog("다음 페이지")
    }
    
    func dateFormatter() -> NSDateFormatter {
        var dateFormatter:NSDateFormatter?
        if (dateFormatter == nil) {
            dateFormatter = NSDateFormatter()
            dateFormatter?.dateFormat = "yyyy-MM-dd"
        }
        return dateFormatter!
    }
    
    @IBAction func selectToday(sender: AnyObject) {
        self.calendar.currentDate = NSDate()
    }
    
    func createRandomEvents() {
        for (var i = 0; i < 30; ++i) {
            var randomDate:NSDate = NSDate(timeInterval: NSTimeInterval(rand()%(3600*24*60)), sinceDate: NSDate())
            
            var key:NSString = self.dateFormatter().stringFromDate(randomDate)
            if(eventsByDate[key] == nil) {
                eventsByDate[key] = NSMutableArray()
            }
            
            eventsByDate[key]?.addObject(randomDate)
        }
    }
}