//
//  CheckVCButtons.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2023/06/21.
//

import UIKit
import FSCalendar
import Firebase

class checkVCButtonsClass:UIViewController{
    func makeCheckVCButtons(selectImageView:UIImageView,self:UIViewController,memo:UITextView){
        //選択した画像を表示するView
        selectImageView.frame = CGRect(x: 0, y: 120, width: 275, height: 275)
        selectImageView.center.x = self.view.center.x

        selectImageView.layer.borderWidth = 2

        selectImageView.layer.borderColor = UIColor.gray.cgColor

        selectImageView.layer.cornerRadius = 5

        self.view.addSubview(selectImageView)

        //メモ記入欄

         memo.frame = CGRect(x: 0, y: 420, width: 325, height: 250)

         memo.center.x = self.view.center.x

         memo.layer.borderWidth = 2

         memo.layer.borderColor = UIColor.gray.cgColor

         memo.layer.cornerRadius = 10

         self.view.addSubview(memo)

    }
}

let checkVCButtons = checkVCButtonsClass()
