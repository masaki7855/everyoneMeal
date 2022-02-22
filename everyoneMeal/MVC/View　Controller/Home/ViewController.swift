//
//  ViewController.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2021/09/09.
//

import UIKit
import FSCalendar
import Firebase




class HomeViewcontroller:UIViewController,FSCalendarDelegate,FSCalendarDelegateAppearance,FSCalendarDataSource{

    @IBOutlet weak var calendar: FSCalendar!


    override func viewDidLoad() {
        super.viewDidLoad()

        guard let Calendar = calendar else {return}
        
        //1.ホーム　Label
        let hometTitle = UILabel()
        hometTitle.text = "ホーム"
        hometTitle.font = UIFont(name: "Optima-Bold", size: 30)
        hometTitle.frame = CGRect(x: 200, y: 50, width: 200, height: 50)
        hometTitle.textAlignment = NSTextAlignment.center
        hometTitle.center.x = self.view.center.x
        self.view.addSubview(hometTitle)
        
        //FSCalendarのレイアウト
       
        Calendar.frame = CGRect(x: 0, y: 250, width: view.frame.width, height: 700)

        Calendar.center = self.view.center

        Calendar.appearance.headerDateFormat = "YYYY年MM月"

        Calendar.calendarWeekdayView.weekdayLabels[0].text = "日"
        Calendar.calendarWeekdayView.weekdayLabels[1].text = "月"
        Calendar.calendarWeekdayView.weekdayLabels[2].text = "火"
        Calendar.calendarWeekdayView.weekdayLabels[3].text = "水"
        Calendar.calendarWeekdayView.weekdayLabels[4].text = "木"
        Calendar.calendarWeekdayView.weekdayLabels[5].text = "金"
        Calendar.calendarWeekdayView.weekdayLabels[6].text = "土"

        Calendar.delegate = self
        
        //"Back"ボタン　文字非表示
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title:"",
            style: .plain,
            target: nil,
            action: nil
        )
    }

    


    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let selectDate = Calendar(identifier: .gregorian)
        let year = selectDate.component(.year, from: date)
        let month = selectDate.component(.month, from: date)
        let day = selectDate.component(.day, from: date)
        //カレンダーで選択した日付の情報
        appDelegate.calendarDate = "\(year)/\(month)/\(day)"


        let alert = UIAlertController(title: "選択した日付の記録、\nまたは確認をしますか？", message: "", preferredStyle: .alert)

        let selectDateSave = UIAlertAction(title: "記録する", style:.default){ (action) in
            
            self.performSegue(withIdentifier: "toSelectSave", sender: self)
        }
        let selectDateCheck = UIAlertAction(title: "確認する", style: .default){ (action) in
            self.performSegue(withIdentifier: "toSelectSave", sender: self)
        }
        let cancel = UIAlertAction(title: "キャンセル", style:.cancel){ (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(cancel)
        alert.addAction(selectDateSave)
        alert.addAction(selectDateCheck)
        self.present(alert, animated: true, completion: nil)


    }


}


class selectSaveViewcontroller: HomeViewcontroller {

    var leftButtonBack: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //バーに表示
        self.navigationItem.title = appDelegate.calendarDate

        //"朝食を記入する"ボタン
        makeMealButton.selectMeal(selectSaveClass: self, meal: "朝食", frameX: 200, frameY: 250, selectEachMeal: Selector("selectMorningSaveButton:"))

        //"昼食を記入する"ボタン
        makeMealButton.selectMeal(selectSaveClass: self, meal: "昼食", frameX: 200, frameY: 350, selectEachMeal: Selector("selectLunchSaveButton:"))

        //"夕食を記入する"ボタン
        makeMealButton.selectMeal(selectSaveClass: self, meal: "夕食", frameX: 200, frameY: 450, selectEachMeal: Selector("selectDinnerSaveButton:"))
        
        //"Back"ボタン　文字非表示
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title:"",
            style: .plain,
            target: nil,
            action: nil
        )
    }
    
    // "朝食を記入する"　ボタンのアクション内容 :画面遷移
    @objc func selectMorningSaveButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSelectMorningSave", sender: self)
    }

    //"昼食を記入する"　ボタンのアクション内容 :画面遷移
    @objc func selectLunchSaveButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSelectMorningSave", sender: self)
    }

    //"夕食を記入する"　ボタンのアクション内容 :画面遷移
    @objc func selectDinnerSaveButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSelectMorningSave", sender: self)
    }
    
    //”戻る”　ボタンのアクション内容
    @objc func backHome(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

class selectMorningSaveViewcontroller: UIViewController {
    
    var leftButtonClose: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //　"メモを記入する"ボタン
        let writeInButton = UIButton()
        
        writeInButton.setTitle("メモを記入する", for: UIControl.State.normal)
        
        writeInButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        writeInButton.frame = CGRect(x: 200, y: 550, width: 200, height: 50)
        writeInButton.center.x = self.view.center.x
        
        writeInButton.setTitleColor(UIColor.white, for: .normal)
        
        writeInButton.backgroundColor = UIColor.gray
        
        writeInButton.addTarget(self, action: #selector(selectSaveTextButton(_:)), for: .touchUpInside)
        
        self.view.addSubview(writeInButton)
        
        
        //"Back"ボタン　文字非表示
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title:"",
            style: .plain,
            target: nil,
            action: nil
        )
    }
    //"メモを記入する"ボタンのアクション内容　: 画面遷移
    @objc func selectSaveTextButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "toSaveMorning", sender: self)
    }
    
    //バー　"閉じる"ボタンのアクション内容
    @objc func backSelectSave(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

class saveMorningViewcontroller: UIViewController {
    
    var memo = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //firestroreからメモのデータを取得する

        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let ref = db.collection("users")

        ref.getDocuments { (querySnapshot, error) in
            if let error = error {
                print(error)
                return
            }else {
                for document in querySnapshot!.documents{
                    print("\(document.documentID) => \(document.data())")

                    let selectMorningMemo = document.data()["\(appDelegate.calendarDate!) morning"] as? String

                    if selectMorningMemo != nil {
                        self.memo.text = selectMorningMemo
                    }else {
                        self.memo.text = "メモを記入する"
                    }
                }
            }
        }
        
        //"メモを保存"ボタン
        let saveMemoButton = UIButton()

        saveMemoButton.setTitle("メモを保存する", for: UIControl.State.normal)

        saveMemoButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        saveMemoButton.frame = CGRect(x: 200, y: 650, width: 200, height: 50)
        saveMemoButton.center.x = self.view.center.x

        saveMemoButton.setTitleColor(UIColor.white, for: .normal)

        saveMemoButton.backgroundColor = UIColor.gray

        saveMemoButton.addTarget(self, action: #selector(saveMemoButtonTapped), for: .touchUpInside)

        self.view.addSubview(saveMemoButton)


       //メモ記入欄
        
        memo.frame = CGRect(x: 0, y: 350, width: 325, height: 250)
        
        memo.center.x = self.view.center.x
        
        memo.layer.borderWidth = 2
        
        memo.layer.borderColor = UIColor.gray.cgColor
        
        memo.layer.cornerRadius = 10
        
        self.view.addSubview(memo)
        
        //メモの記入時のキーボードを閉じるボタン
        
        
        let keyboardClose = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        
        keyboardClose.barStyle = UIBarStyle.default
        
        keyboardClose.sizeToFit()
        
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.closeButtonTapped))
        
        keyboardClose.items = [spacer,closeButton]
        
        memo.inputAccessoryView = keyboardClose
        
    }
    
    //キーボードを閉じるアクション
    @objc func closeButtonTapped() {
        self.view.endEditing(true)
    }
    
    //FireStoreへ　メモを保存


        @objc func saveMemoButtonTapped() {

        guard let userID = Auth.auth().currentUser?.uid else {return}
        guard let memoData = memo.text else {return}
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

            db.collection("users").document(userID).setData(["\(appDelegate.calendarDate!) morning" : memoData], merge: true) { err in
            if let err = err {
                print("エラーが起きました\(err)")
            } else {
                print("ドキュメントが保存されました")
                let saveAlert = UIAlertController(title: "保存しました", message: "", preferredStyle: .alert)
                saveAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(saveAlert, animated: true, completion: nil)

            }
        }
    }

}
   
    
   



