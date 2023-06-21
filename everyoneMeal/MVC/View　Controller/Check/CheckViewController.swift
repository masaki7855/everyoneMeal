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

        //"本日の朝食を確認する"ボタン
        makeMealButton.selectCheckMeal(selectSaveClass: self, meal: "朝食", frameX: 200, frameY: 250, selectEachMeal: Selector("todayMorningCheckButton:"))

        //"本日の昼食を確認する"ボタン
        makeMealButton.selectCheckMeal(selectSaveClass: self, meal: "昼食", frameX: 200, frameY: 350, selectEachMeal: Selector("todayMorningCheckButton:"))
        //"本日の夕食を確認する"ボタン
        makeMealButton.selectCheckMeal(selectSaveClass: self, meal: "夕食", frameX: 200, frameY: 450, selectEachMeal: Selector("todayMorningCheckButton:"))

        //"Back"ボタン　文字非表示
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title:"",
            style: .plain,
            target: nil,
            action: nil
            )
    }
    //"本日の朝食を確認する"　ボタンのアクション内容 :画面遷移
    @objc func todayMorningCheckButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toTodayMorningCheck", sender: self)
    }
    //"本日の昼食を確認する"　ボタンのアクション内容 :画面遷移
    @objc func todayLunchCheckButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toTodayLunchCheck", sender: self)
    }
    //"本日の夕食を確認する"　ボタンのアクション内容 :画面遷移
    @objc func todayDinnerCheckButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toTodayDinnerCheck", sender: self)
    }
}

class todayMorningCheckViewController: UIViewController {


    var eachMeal = "\(getToday()) morning"
    var memo = UITextView()
    var eachMealPhotoData = "\(getToday(format: "y.M.d")) morning.jpeg"
    let selectImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         "選択した画像を表示するView"
         "メモ記入欄"

         */
        checkVCButtons.makeCheckVCButtons(selectImageView: selectImageView, self: self, memo: memo)

        //firestroreからメモのデータを取得する

        getMemoDataFromFirebase(eachMeal: self.eachMeal,memo: self.memo)

        //データ取得（保存している画像があれば読み込み、表示する）
        getPhotoDataFromFireStorage(eachMealPhotoData: self.eachMealPhotoData, photo: selectImageView)

    }
}

class todayLunchCheckViewController: UIViewController {


    var eachMeal = "\(getToday()) lunch"
    var memo = UITextView()
    var eachMealPhotoData = "\(getToday(format: "y.M.d")) lunch.jpeg"
    let selectImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         "選択した画像を表示するView"
         "メモ記入欄"

         */
        checkVCButtons.makeCheckVCButtons(selectImageView: selectImageView, self: self, memo: memo)

        //firestroreからメモのデータを取得する

        getMemoDataFromFirebase(eachMeal: self.eachMeal,memo: self.memo)

        //データ取得（保存している画像があれば読み込み、表示する）
        getPhotoDataFromFireStorage(eachMealPhotoData: self.eachMealPhotoData, photo: selectImageView)

    }
}

class todayDinnerCheckViewController: UIViewController {


    var eachMeal = "\(getToday()) dinner"
    var memo = UITextView()
    var eachMealPhotoData = "\(getToday(format: "y.M.d")) dinner.jpeg"
    let selectImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         "選択した画像を表示するView"
         "メモ記入欄"

         */
        checkVCButtons.makeCheckVCButtons(selectImageView: selectImageView, self: self, memo: memo)

        //firestroreからメモのデータを取得する

        getMemoDataFromFirebase(eachMeal: self.eachMeal,memo: self.memo)

        //データ取得（保存している画像があれば読み込み、表示する）
        getPhotoDataFromFireStorage(eachMealPhotoData: self.eachMealPhotoData, photo: selectImageView)

    }
}
