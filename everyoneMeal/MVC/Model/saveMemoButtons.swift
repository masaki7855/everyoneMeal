//
//  saveMemoButtons.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2023/06/04.
//

import UIKit
import FSCalendar
import Firebase

/*
 "選択した画像を表示するView"
 "メモを保存するボタン"
 "メモ記入欄"
 "メモ記入時のキーボードを閉じるボタン"
 */

class saveMemoButtonClass:UIViewController{
    func makeSaveMemoButton(selectImageView:UIImageView,self:UIViewController,saveMorningMemoDataToFirestore:Selector,memo:UITextView,closeButtonTapped:Selector){

        //選択した画像を表示するView
        selectImageView.frame = CGRect(x: 0, y: 120, width: 275, height: 275)
        selectImageView.center.x = self.view.center.x

        selectImageView.layer.borderWidth = 2

        selectImageView.layer.borderColor = UIColor.gray.cgColor

        selectImageView.layer.cornerRadius = 5

        self.view.addSubview(selectImageView)

        //"メモを保存する"ボタン
        let saveMemoButton = UIButton()

        saveMemoButton.setTitle("メモを保存する", for: UIControl.State.normal)

        saveMemoButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        saveMemoButton.frame = CGRect(x: 200, y: 700, width: 200, height: 50)
        saveMemoButton.center.x = self.view.center.x

        saveMemoButton.setTitleColor(UIColor.white, for: .normal)

        saveMemoButton.backgroundColor = UIColor.gray

        saveMemoButton.addTarget(self, action: saveMorningMemoDataToFirestore, for: .touchUpInside)

        self.view.addSubview(saveMemoButton)



        //メモ記入欄

         memo.frame = CGRect(x: 0, y: 420, width: 325, height: 250)

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

        let closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: closeButtonTapped)

        keyboardClose.items = [spacer,closeButton]

        memo.inputAccessoryView = keyboardClose
    }
}

let saveMemoButton = saveMemoButtonClass()
