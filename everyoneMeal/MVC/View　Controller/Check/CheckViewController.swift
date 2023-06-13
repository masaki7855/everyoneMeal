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
        let todayMeal = UILabel()
        todayMeal.text = "本日の食事を"
        todayMeal.font = UIFont(name: "Optima-Bold", size: 19)
        todayMeal.frame = CGRect(x: 200, y: 5, width: 200, height: 50)
        todayMeal.textAlignment = NSTextAlignment.center
        todayMeal.center.x = self.view.center.x
        self.CheckScrollView.addSubview(todayMeal)

        
        //今日の日付を表示する
        let checkLabel = UILabel()
        checkLabel.text = "確認する"
        checkLabel.font = UIFont(name: "Optima-Bold", size: 30)
        checkLabel.frame = CGRect(x: 200, y: 45, width: 250, height: 100)
        checkLabel.textAlignment = NSTextAlignment.center
        checkLabel.center.x = self.CheckScrollView.center.x
        self.CheckScrollView.addSubview(checkLabel)

        //"朝食を確認する"ボタン
        makeMealButton.selectCheckMeal(selectSaveClass: self, meal: "朝食", frameX: 200, frameY: 250, selectEachMeal: Selector("todayMorningSaveButton:"))

        //"昼食を確認する"ボタン
        makeMealButton.selectCheckMeal(selectSaveClass: self, meal: "昼食", frameX: 200, frameY: 250, selectEachMeal: Selector("todayMorningSaveButton:"))
        //"夕食を確認する"ボタン
        makeMealButton.selectCheckMeal(selectSaveClass: self, meal: "夕食", frameX: 200, frameY: 250, selectEachMeal: Selector("todayMorningSaveButton:"))

        //"Back"ボタン　文字非表示
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title:"",
            style: .plain,
            target: nil,
            action: nil
            )
    }
    //"朝食を確認する"　ボタンのアクション内容 :画面遷移
    @objc func todayMorningSaveButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSelectTodayMorningSave", sender: self)
    }
    //"昼食を確認する"　ボタンのアクション内容 :画面遷移
    @objc func todayLunchSaveButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSelectTodayLunchSave", sender: self)
    }
    //"夕食を確認する"　ボタンのアクション内容 :画面遷移
    @objc func todayDinnerSaveButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSelectTodayDinnerSave", sender: self)
    }
}
