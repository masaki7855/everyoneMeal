//
//  selectSaveoptions.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2022/08/12.
//

import UIKit
import FSCalendar
import Firebase


//FireStoreへ　朝食のメモを保存
//    使用不可能

//今日の食事選択後のオプション（写真を撮影する,写真を選択する、メモを記入する）ボタン

class todaySelectSaveoptionsClass: cameraViewcontroller {
    func makeOptions (mainVC:UIViewController,meal:String,mainSelectSaveTextButton: Selector,mainSelectSavePhotoButton: Selector){
        //日付を表示する
        let SaveLabel = UILabel()
        getTodayLabel(uiLabel: SaveLabel, uiViewController: mainVC)

        //各食事のラベル
        let eachMealLabel = UILabel()
        eachMealLabel.text = meal
        eachMealLabel.font = UIFont(name: "Optima-Bold", size: 25)
        eachMealLabel.frame = CGRect(x: 200, y: 65, width: 200, height: 50)
        eachMealLabel.textAlignment = NSTextAlignment.center
        eachMealLabel.center.x = mainVC.view.center.x
        mainVC.view.addSubview(eachMealLabel)

        //　"写真を撮影する"ボタン
        let takePicturesAndSave = UIButton()

        takePicturesAndSave.setTitle("写真を撮影する", for: UIControl.State.normal)

        takePicturesAndSave.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        takePicturesAndSave.frame = CGRect(x: 200, y: 250, width: 200, height: 50)
        takePicturesAndSave.center.x = mainVC.view.center.x

        takePicturesAndSave.setTitleColor(UIColor.white, for: .normal)

        takePicturesAndSave.backgroundColor = UIColor.gray

        takePicturesAndSave.addTarget(mainVC, action: #selector(callUiimagePickerController(_:)), for: .touchUpInside)

        mainVC.view.addSubview(takePicturesAndSave)

        //　"メモを記入する"ボタン
        let writeInButton = UIButton()

        writeInButton.setTitle("メモを記入する", for: UIControl.State.normal)

        writeInButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        writeInButton.frame = CGRect(x: 200, y: 450, width: 200, height: 50)
        writeInButton.center.x = mainVC.view.center.x

        writeInButton.setTitleColor(UIColor.white, for: .normal)

        writeInButton.backgroundColor = UIColor.gray

        writeInButton.addTarget(mainVC, action: mainSelectSaveTextButton, for: .touchUpInside)

        mainVC.view.addSubview(writeInButton)

        //　"写真を選択する"ボタン
        let selectSavePhoto = UIButton()

        selectSavePhoto.setTitle("写真を選択する", for: UIControl.State.normal)

        selectSavePhoto.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        selectSavePhoto.frame = CGRect(x: 200, y: 350, width: 200, height: 50)
        selectSavePhoto.center.x = mainVC.view.center.x

        selectSavePhoto.setTitleColor(UIColor.white, for: .normal)

        selectSavePhoto.backgroundColor = UIColor.gray

        selectSavePhoto.addTarget(mainVC, action: mainSelectSavePhotoButton, for: .touchUpInside)

        mainVC.view.addSubview(selectSavePhoto)

        //"Back"ボタン　文字非表示
        mainVC.navigationItem.backBarButtonItem = UIBarButtonItem(
            title:"",
            style: .plain,
            target: nil,
            action: nil
        )

    }
}
let todaySelectSaveoptions = todaySelectSaveoptionsClass()

//選択した日付の食事選択後のオプション（写真を撮影する,写真を選択する、メモを記入する）ボタン

class thedaySelectSaveoptionsClass: cameraViewcontroller {
    func makeOptions (mainVC:UIViewController,meal:String,mainSelectSaveTextButton: Selector,mainSelectSavePhotoButton: Selector){
        //日付を表示する
        let SaveLabel = UILabel()
        selectDayLabel(uiLabel: SaveLabel, uiViewController: mainVC)
        //各食事のラベル
        let eachMealLabel = UILabel()
        eachMealLabel.text = meal
        eachMealLabel.font = UIFont(name: "Optima-Bold", size: 25)
        eachMealLabel.frame = CGRect(x: 200, y: 65, width: 200, height: 50)
        eachMealLabel.textAlignment = NSTextAlignment.center
        eachMealLabel.center.x = mainVC.view.center.x
        mainVC.view.addSubview(eachMealLabel)

        //　"写真を撮影する"ボタン
        let takePicturesAndSave = UIButton()

        takePicturesAndSave.setTitle("写真を撮影する", for: UIControl.State.normal)

        takePicturesAndSave.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        takePicturesAndSave.frame = CGRect(x: 200, y: 250, width: 200, height: 50)
        takePicturesAndSave.center.x = mainVC.view.center.x

        takePicturesAndSave.setTitleColor(UIColor.white, for: .normal)

        takePicturesAndSave.backgroundColor = UIColor.gray

        takePicturesAndSave.addTarget(mainVC, action: #selector(callUiimagePickerController(_:)), for: .touchUpInside)

        mainVC.view.addSubview(takePicturesAndSave)

        //　"メモを記入する"ボタン
        let writeInButton = UIButton()

        writeInButton.setTitle("メモを記入する", for: UIControl.State.normal)

        writeInButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        writeInButton.frame = CGRect(x: 200, y: 450, width: 200, height: 50)
        writeInButton.center.x = mainVC.view.center.x

        writeInButton.setTitleColor(UIColor.white, for: .normal)

        writeInButton.backgroundColor = UIColor.gray

        writeInButton.addTarget(mainVC, action: mainSelectSaveTextButton, for: .touchUpInside)

        mainVC.view.addSubview(writeInButton)

        //　"写真を選択する"ボタン
        let selectSavePhoto = UIButton()

        selectSavePhoto.setTitle("写真を選択する", for: UIControl.State.normal)

        selectSavePhoto.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        selectSavePhoto.frame = CGRect(x: 200, y: 350, width: 200, height: 50)
        selectSavePhoto.center.x = mainVC.view.center.x

        selectSavePhoto.setTitleColor(UIColor.white, for: .normal)

        selectSavePhoto.backgroundColor = UIColor.gray

        selectSavePhoto.addTarget(mainVC, action: mainSelectSavePhotoButton, for: .touchUpInside)

        mainVC.view.addSubview(selectSavePhoto)

        //"Back"ボタン　文字非表示
        mainVC.navigationItem.backBarButtonItem = UIBarButtonItem(
            title:"",
            style: .plain,
            target: nil,
            action: nil
        )

    }
}
let thedaySelectSaveoptions = thedaySelectSaveoptionsClass()


/*  
//今日の日付を表示する
let SaveLabel = UILabel()
getTodayLabel(uiLabel: SaveLabel, uiViewController: self)

//　"写真を撮影する"ボタン
let takePicturesAndSave = UIButton()

takePicturesAndSave.setTitle("写真を撮影する", for: UIControl.State.normal)

takePicturesAndSave.titleLabel?.font = UIFont.systemFont(ofSize: 20)

takePicturesAndSave.frame = CGRect(x: 200, y: 250, width: 200, height: 50)
takePicturesAndSave.center.x = self.view.center.x

takePicturesAndSave.setTitleColor(UIColor.white, for: .normal)

takePicturesAndSave.backgroundColor = UIColor.gray

takePicturesAndSave.addTarget(self, action: #selector(callUiimagePickerController(_:)), for: .touchUpInside)

self.view.addSubview(takePicturesAndSave)

//　"メモを記入する"ボタン
let writeInButton = UIButton()

writeInButton.setTitle("メモを記入する", for: UIControl.State.normal)

writeInButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)

writeInButton.frame = CGRect(x: 200, y: 450, width: 200, height: 50)
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
 */
