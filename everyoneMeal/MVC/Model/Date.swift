//
//  Date.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2021/10/21.
//

import UIKit
import FSCalendar

func getToday(format:String = "yyyy/MM/dd HH:mm:ss") -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }




