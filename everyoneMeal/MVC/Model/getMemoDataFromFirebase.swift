//
//  getMemoDataFromFirebase.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2021/12/03.
//

import UIKit
import FSCalendar
import Firebase

//firestoreからメモのデータを取得する
func getMemoDataFromFirebase(eachMeal:String,memo:UITextView) {

guard let userID = Auth.auth().currentUser?.uid else {return}

    let ref = db.collection("users").document(userID)

    ref.getDocument { (document, error) in
        if let document = document, document.exists {
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            print("Document data: \(dataDescription)")
        } else {
            print("Document does not exist")
        }
        let MorningMemo = document?.data()?[eachMeal] as? String

        if MorningMemo != nil {
            memo.text = MorningMemo
        }else {
            memo.text = "メモを記入する"
        }
    }

}

