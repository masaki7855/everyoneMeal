//
//  getMemoDataFromFirebase.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2021/12/03.
//

import UIKit
import FSCalendar
import Firebase

//firestroreからメモのデータを取得する
func getMemoDataFromFirebase(memo:UITextView) {

let ref = db.collection("users")

ref.getDocuments { (querySnapshot, error) in
    if let error = error {
        print(error)
        return
    }else {
        for document in querySnapshot!.documents{
            print("\(document.documentID) => \(document.data())")

            let MorningMemo = document.data()["\(getToday()) morning"] as? String

            if MorningMemo != nil {
                memo.text = MorningMemo
            }else {
                memo.text = "メモを記入する"
            }
        }
    }
}
}
