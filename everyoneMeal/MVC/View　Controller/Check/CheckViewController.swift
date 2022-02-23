//
//  CheckViewController.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2022/02/03.
//

import UIKit
import FSCalendar
import Firebase
import FirebaseStorage
import FirebaseStorageUI
import SDWebImage

class CheckViewController: UIViewController {

    @IBOutlet weak var CheckScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //確認する　Label
        let saveTitle = UILabel()
        saveTitle.text = "確認する"
        saveTitle.font = UIFont(name: "Optima-Bold", size: 30)
        saveTitle.frame = CGRect(x: 200, y: 5, width: 200, height: 50)
        saveTitle.textAlignment = NSTextAlignment.center
        saveTitle.center.x = self.view.center.x
        self.CheckScrollView.addSubview(saveTitle)

        
        //今日の日付を表示する
        let SaveLabel = UILabel()
        SaveLabel.text = "\(getToday())"
        SaveLabel.font = UIFont(name: "Optima-Bold", size: 25)
        SaveLabel.frame = CGRect(x: 200, y: 55, width: 250, height: 100)
        SaveLabel.textAlignment = NSTextAlignment.center
        SaveLabel.center.x = self.CheckScrollView.center.x
        self.CheckScrollView.addSubview(SaveLabel)

    }
}
