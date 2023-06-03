//
//  NoNeme.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2023/06/03.
//

import UIKit
import FSCalendar
import Firebase

/*
 各食事の画像選択時のボタン
　”ライブラリーから画像を選択する”、”表示している画像で記録する”
 */

class savePhotoButtonClass:UIViewController{

    func makeSavePhotoButton(self:UIViewController,toImagePicker:Selector,savePhoto:Selector){
//"ライブラリーから画像を選択する"ボタン
let selectPhotoButton = UIButton()

selectPhotoButton.setTitle("ライブラリーから画像を選択する", for: UIControl.State.normal)

selectPhotoButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)

selectPhotoButton.frame = CGRect(x: 200, y: 500, width: 300, height: 50)
selectPhotoButton.center.x = self.view.center.x

selectPhotoButton.setTitleColor(UIColor.white, for: .normal)

selectPhotoButton.backgroundColor = UIColor.gray

        selectPhotoButton.addTarget(self, action: toImagePicker, for: .touchUpInside)

self.view.addSubview(selectPhotoButton)


//"表示している画像で記録する"　ボタン
let savePhotoButton = UIButton()

savePhotoButton.setTitle("表示している画像で記録する", for: UIControl.State.normal)

savePhotoButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)

savePhotoButton.frame = CGRect(x: 200, y: 600, width: 300, height: 50)
savePhotoButton.center.x = self.view.center.x

savePhotoButton.setTitleColor(UIColor.white, for: .normal)

savePhotoButton.backgroundColor = UIColor.gray

savePhotoButton.addTarget(self, action: savePhoto, for: .touchUpInside)

self.view.addSubview(savePhotoButton)

    }
}
let savePhotoButton = savePhotoButtonClass()
