//
//  getPhotoDataFromFirestorage.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2021/12/29.
//

import UIKit
import Firebase
import FirebaseStorage
import SDWebImage


//fireStorageから写真のデータを取得する
let storage = Storage.storage().reference(forURL: "gs://everyonemeal.appspot.com")

func getPhotoDataFromFireStorage (eachMealPhotoData:String,photo:UIImageView){

    guard let userID = Auth.auth().currentUser?.uid else {return}

let storageRef = storage.child(userID).child(eachMealPhotoData)

    storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
        if error != nil{
            print("画像の読み込みに失敗しました。")
        }else {
            photo.image = UIImage(data: data!)
            print("画像を読み込みました。")
        }
    }
}
