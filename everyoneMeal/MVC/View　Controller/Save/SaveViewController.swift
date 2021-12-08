//
//  File.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2021/11/04.
//

import UIKit
import FSCalendar
import Firebase

class SaveViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //記録する　Label
        let saveTitle = UILabel()
        saveTitle.text = "記録する"
        saveTitle.font = UIFont(name: "Optima-Bold", size: 30)
        saveTitle.frame = CGRect(x: 200, y: 50, width: 200, height: 50)
        saveTitle.textAlignment = NSTextAlignment.center
        saveTitle.center.x = self.view.center.x
        self.view.addSubview(saveTitle)

        //2.記録する（今日の日付で記録）
        let SaveLabel = UILabel()
        SaveLabel.text = "\(getToday())"
        SaveLabel.font = UIFont(name: "Optima-Bold", size: 25)
        SaveLabel.frame = CGRect(x: 200, y: 100, width: 250, height: 100)
        SaveLabel.textAlignment = NSTextAlignment.center
        SaveLabel.center.x = self.view.center.x
        self.view.addSubview(SaveLabel)

        //"朝食を記入する"ボタン
        makeMealButton.SaveVCselectMeal(selectSaveClass: self, meal: "朝食", frameX: 200, frameY: 250, selectEachMeal: Selector("todayMorningSaveButton:"))

        //"昼食を記入する"ボタン
        makeMealButton.SaveVCselectMeal(selectSaveClass: self, meal: "昼食", frameX: 200, frameY: 350, selectEachMeal: Selector("selectLunchSaveButton:"))

        //"夕食を記入する"ボタン
        makeMealButton.SaveVCselectMeal(selectSaveClass: self, meal: "夕食", frameX: 200, frameY: 450, selectEachMeal: Selector("selectDinnerSaveButton:"))

        //"Back"ボタン　文字非表示
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title:"",
            style: .plain,
            target: nil,
            action: nil
        )

    }
    //"今日の朝食を記入する"　ボタンのアクション内容 :画面遷移
    @objc func todayMorningSaveButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSelectTodayMorningSave", sender: self)
    }
}

class selectTodayMorningSaveViewController: UIViewController{

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

        //　"写真を選択する"ボタン
        let selectSavePhoto = UIButton()

        selectSavePhoto.setTitle("写真を選択する", for: UIControl.State.normal)

        selectSavePhoto.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        selectSavePhoto.frame = CGRect(x: 200, y: 350, width: 200, height: 50)
        selectSavePhoto.center.x = self.view.center.x

        selectSavePhoto.setTitleColor(UIColor.white, for: .normal)

        selectSavePhoto.backgroundColor = UIColor.gray

        selectSavePhoto.addTarget(self, action: #selector(selectSavePhotoButton(_:)), for: .touchUpInside)

        self.view.addSubview(selectSavePhoto)

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
        self.performSegue(withIdentifier: "toTodayMorningSaveMemo", sender: self)
    }

    //"写真を選択する"ボタンのアクション内容　: 画面遷移
    @objc func selectSavePhotoButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "toTodayMorningSavePhoto", sender: self)
    }
}

class todayMorningSaveMemoViewController: UIViewController {

    var memo = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //firestroreからメモのデータを取得する

        getMemoDataFromFirebase(memo: self.memo)

        //"メモを保存する"ボタン
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

            db.collection("users").document(userID).setData(["\(getToday()) morning" : memoData], merge: true) { err in
            if let err = err {
                print("エラーが起きました\(err)")
            } else {
                print("ドキュメントが保存されました")
                
                //保存時にアラート表示
                let saveAlert = UIAlertController(title: "保存しました", message: "", preferredStyle: .alert)
                saveAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(saveAlert, animated: true, completion: nil)

            }
        }
    }
}

class todayMorningSavePhotoViewController: UIViewController {

    let selectImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        selectImageView.frame = CGRect(x: 0, y: 175, width: 275, height: 275)
        selectImageView.center.x = self.view.center.x

        selectImageView.layer.borderWidth = 2

        selectImageView.layer.borderColor = UIColor.gray.cgColor

        selectImageView.layer.cornerRadius = 5

        self.view.addSubview(selectImageView)
    }


    func savePhoto () {
        //ストレージサーバーのURL
        let storage = Storage.storage().reference(forURL: "gs://everyonemeal.appspot.com")
    }
}
