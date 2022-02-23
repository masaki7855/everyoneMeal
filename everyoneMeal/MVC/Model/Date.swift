//
//  Date.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2021/10/21.
//

import UIKit
import FSCalendar

let appDelegate = UIApplication.shared.delegate as! AppDelegate

func getToday(format:String = "y/M/d") -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }

//選択した日付を表示する
func selectDayLabel(uiLabel: UILabel,uiViewController: UIViewController) {
    uiLabel.text = "\(appDelegate.calendarDate!)"
    uiLabel.font = UIFont(name: "Optima-Bold", size: 25)
    uiLabel.frame = CGRect(x: 200, y: 100, width: 250, height: 100)
    uiLabel.textAlignment = NSTextAlignment.center
    uiLabel.center.x = uiViewController.view.center.x
    uiViewController.view.addSubview(uiLabel)
}

//今日の日付を表示する
func getTodayLabel(uiLabel: UILabel,uiViewController: UIViewController) {
    uiLabel.text = "\(getToday())"
    uiLabel.font = UIFont(name: "Optima-Bold", size: 25)
    uiLabel.frame = CGRect(x: 200, y: 100, width: 250, height: 100)
    uiLabel.textAlignment = NSTextAlignment.center
    uiLabel.center.x = uiViewController.view.center.x
    uiViewController.view.addSubview(uiLabel)
}





