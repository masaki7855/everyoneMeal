//
//  File.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2021/11/04.
//

import UIKit
import FSCalendar

class SaveViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //2.記録する
        let SaveLabel = UILabel()
        SaveLabel.text = "2.記録する"
        SaveLabel.font = UIFont(name: "Optima-Bold", size: 30)
        SaveLabel.frame = CGRect(x: 200, y: 150, width: 200, height: 50)
        SaveLabel.textAlignment = NSTextAlignment.center
        SaveLabel.center.x = self.view.center.x
        self.view.addSubview(SaveLabel)

        //当日の日付を提示
        self.navigationItem.title = getToday(format: "yyyy-MM-dd")
    }
}
