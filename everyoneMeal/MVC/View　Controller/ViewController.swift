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
        let HomeLabel = UILabel()
        HomeLabel.text = "1.ホーム"
        HomeLabel.font = UIFont(name: "Optima-Bold", size: 30)
        HomeLabel.frame = CGRect(x: 200, y: 50, width: 200, height: 50)
        HomeLabel.textAlignment = NSTextAlignment.center
        HomeLabel.center.x = self.view.center.x
        self.view.addSubview(HomeLabel)
        
        //FSCalendarのレイアウト
       
        Calendar.frame = CGRect(x: 0, y: 250, width: view.frame.width, height: 700)

        Calendar.center = self.view.center
        
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
        /*
        let selectDate = Calendar(identifier: .gregorian)
        let year = selectDate.component(.year, from: date)
        let month = selectDate.component(.month, from: date)
        let day = selectDate.component(.day, from: date)
        let selectSaveBarDate = "\(year)/\(month)/\(day)です"
 */

        let alert = UIAlertController(title: "選択した日付の記録、\nまたは確認をしますか？", message: "", preferredStyle: .alert)

        let selectDateSave = UIAlertAction(title: "記録する", style:.default){ (action) in
            /*
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(identifier: "SelectSaveViewController") as! selectSaveViewcontroller
            nextView.barDate = selectSaveBarDate
             */
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

        //バーに表示
        self.navigationItem.title = "食事を記録する"

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
        let saveTextButton = UIButton()
        
        saveTextButton.setTitle("メモを記入する", for: UIControl.State.normal)
        
        saveTextButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        saveTextButton.frame = CGRect(x: 200, y: 200, width: 200, height: 50)
        saveTextButton.center.x = self.view.center.x
        
        saveTextButton.setTitleColor(UIColor.white, for: .normal)
        
        saveTextButton.backgroundColor = UIColor.gray
        
        saveTextButton.addTarget(self, action: #selector(selectSaveTextButton(_:)), for: .touchUpInside)
        
        self.view.addSubview(saveTextButton)
        
        
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
        self.performSegue(withIdentifier: "toSaveMemo", sender: self)
    }
    
    //バー　"閉じる"ボタンのアクション内容
    @objc func backSelectSave(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

class saveMemoViewcontroller: UIViewController, UITextViewDelegate,UITextFieldDelegate {
    
    let memo = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //メモ記入欄
        
        memo.frame = CGRect(x: 0, y: 425, width: 350, height: 300)
        
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
    
    //Firebaseへ　メモを保存
    
}

   
    
   



