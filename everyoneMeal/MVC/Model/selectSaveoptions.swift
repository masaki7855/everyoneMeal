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

//食事選択後のオプション（写真を撮影する,写真を選択する、メモを記入する）

class selectSaveoptionsClass: cameraViewcontroller {
    func makeOptions (mainVC:UIViewController,mainSelectSaveTextButton: Selector){
        //今日の日付を表示する
        let SaveLabel = UILabel()
        getTodayLabel(uiLabel: SaveLabel, uiViewController: mainVC)

        //　"写真を撮影する"ボタン
        let takePicturesAndSave = UIButton()

        takePicturesAndSave.setTitle("写真を撮影する", for: UIControl.State.normal)

        takePicturesAndSave.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        takePicturesAndSave.frame = CGRect(x: 200, y: 250, width: 200, height: 50)
        takePicturesAndSave.center.x = self.view.center.x

        takePicturesAndSave.setTitleColor(UIColor.white, for: .normal)

        takePicturesAndSave.backgroundColor = UIColor.gray

        takePicturesAndSave.addTarget(mainVC, action: #selector(callUiimagePickerController(_:)), for: .touchUpInside)

        mainVC.view.addSubview(takePicturesAndSave)

        //　"メモを記入する"ボタン
        let writeInButton = UIButton()

        writeInButton.setTitle("メモを記入する", for: UIControl.State.normal)

        writeInButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        writeInButton.frame = CGRect(x: 200, y: 450, width: 200, height: 50)
        writeInButton.center.x = self.view.center.x

        writeInButton.setTitleColor(UIColor.white, for: .normal)

        writeInButton.backgroundColor = UIColor.gray

        writeInButton.addTarget(mainVC, action: mainSelectSaveTextButton, for: .touchUpInside)

        mainVC.view.addSubview(writeInButton)

    }
}
