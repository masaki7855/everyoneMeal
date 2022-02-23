//
//  File.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2021/11/04.
//

import UIKit
import FSCalendar
import Firebase
import FirebaseStorage
import FirebaseStorageUI
import SDWebImage

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

        //今日の日付を表示する
        let TodayLabel = UILabel()
        getTodayLabel(uiLabel: TodayLabel, uiViewController: self)
        //"朝食を記入する"ボタン
        makeMealButton.selectMeal(selectSaveClass: self, meal: "朝食", frameX: 200, frameY: 250, selectEachMeal: Selector("todaySaveButton:"))

        //"昼食を記入する"ボタン
        makeMealButton.selectMeal(selectSaveClass: self, meal: "昼食", frameX: 200, frameY: 350, selectEachMeal: Selector("todaySaveButton:"))

        //"夕食を記入する"ボタン
        makeMealButton.selectMeal(selectSaveClass: self, meal: "夕食", frameX: 200, frameY: 450, selectEachMeal: Selector("todaySaveButton:"))

        //"Back"ボタン　文字非表示
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title:"",
            style: .plain,
            target: nil,
            action: nil
        )

    }
    //"各食を記入する"　ボタンのアクション内容 :画面遷移
    @objc func todaySaveButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSelectTodaySave", sender: self)
    }
}

class selectTodaySaveViewController: cameraViewcontroller {

    override func viewDidLoad() {
        super.viewDidLoad()

        //今日の日付を表示する
        let SaveLabel = UILabel()
        getTodayLabel(uiLabel: SaveLabel, uiViewController: self)

        //　"写真を撮影する"ボタン
        let takePicturesAndSave = UIButton()

        takePicturesAndSave.setTitle("写真を撮影する", for: UIControl.State.normal)

        takePicturesAndSave.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        takePicturesAndSave.frame = CGRect(x: 200, y: 350, width: 200, height: 50)
        takePicturesAndSave.center.x = self.view.center.x

        takePicturesAndSave.setTitleColor(UIColor.white, for: .normal)

        takePicturesAndSave.backgroundColor = UIColor.gray

        takePicturesAndSave.addTarget(self, action: #selector(callUiimagePickerController(_:)), for: .touchUpInside)

        self.view.addSubview(takePicturesAndSave)

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

        selectSavePhoto.frame = CGRect(x: 200, y: 450, width: 200, height: 50)
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
    let selectImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

       

        //選択した写真を表示するView
        selectImageView.frame = CGRect(x: 0, y: 120, width: 275, height: 275)
        selectImageView.center.x = self.view.center.x

        selectImageView.layer.borderWidth = 2

        selectImageView.layer.borderColor = UIColor.gray.cgColor

        selectImageView.layer.cornerRadius = 5

        self.view.addSubview(selectImageView)

        //firestroreからメモのデータを取得する

        getMemoDataFromFirebase(memo: self.memo)

        //データ取得（保存している画像があれば読み込み、表示する）
    getPhotoDataFromFireStorage(photo: selectImageView)


        //"メモを保存する"ボタン
        let saveMemoButton = UIButton()

        saveMemoButton.setTitle("メモを保存する", for: UIControl.State.normal)

        saveMemoButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        saveMemoButton.frame = CGRect(x: 200, y: 700, width: 200, height: 50)
        saveMemoButton.center.x = self.view.center.x

        saveMemoButton.setTitleColor(UIColor.white, for: .normal)

        saveMemoButton.backgroundColor = UIColor.gray

        saveMemoButton.addTarget(self, action: #selector(saveMemoToFirestore(_:)), for: .touchUpInside)

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

        let closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.closeButtonTapped))

        keyboardClose.items = [spacer,closeButton]

        memo.inputAccessoryView = keyboardClose
        
    }
    //キーボードを閉じるアクション
    @objc func closeButtonTapped() {
        self.view.endEditing(true)
    }
    
    //FireStoreへ　メモを保存
    @objc func saveMemoToFirestore(_ sender: UIButton) {


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
    let imagePicker = UIImagePickerController()



    override func viewDidLoad() {
        super.viewDidLoad()

        //選択した写真を表示するView
        selectImageView.frame = CGRect(x: 0, y: 175, width: 275, height: 275)
        selectImageView.center.x = self.view.center.x

        selectImageView.layer.borderWidth = 2

        selectImageView.layer.borderColor = UIColor.gray.cgColor

        selectImageView.layer.cornerRadius = 5

        self.view.addSubview(selectImageView)

        //"写真を選択する"ボタン
        let selectPhotoButton = UIButton()

        selectPhotoButton.setTitle("写真を選択する", for: UIControl.State.normal)

        selectPhotoButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        selectPhotoButton.frame = CGRect(x: 200, y: 500, width: 275, height: 50)
        selectPhotoButton.center.x = self.view.center.x

        selectPhotoButton.setTitleColor(UIColor.white, for: .normal)

        selectPhotoButton.backgroundColor = UIColor.gray

        selectPhotoButton.addTarget(self, action: #selector(toImagePicker), for: .touchUpInside)

        self.view.addSubview(selectPhotoButton)


        //"表示している画像で記録する"　ボタン
        let savePhotoButton = UIButton()

        savePhotoButton.setTitle("表示している画像で記録する", for: UIControl.State.normal)

        savePhotoButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        savePhotoButton.frame = CGRect(x: 200, y: 600, width: 275, height: 50)
        savePhotoButton.center.x = self.view.center.x

        savePhotoButton.setTitleColor(UIColor.white, for: .normal)

        savePhotoButton.backgroundColor = UIColor.gray

        savePhotoButton.addTarget(self, action: #selector(savePhoto), for: .touchUpInside)

        self.view.addSubview(savePhotoButton)

        imagePicker.delegate = self

        //データ取得（保存している画像があれば読み込み、表示する）
    getPhotoDataFromFireStorage(photo: selectImageView)

    }

    /*"写真を選択する"ボタンのアクション内容
    （ライブラリーに移動し写真を選択する）*/
    @objc func toImagePicker(_ sender: Any) {
        imagePicker.allowsEditing = true

        imagePicker.sourceType = .photoLibrary

        present(imagePicker, animated: true, completion:
        nil)
    }
    //firestorageに写真を保存する
    @objc func savePhoto () {

        guard let userID = Auth.auth().currentUser?.uid else {return}
        //ストレージサーバーのURL
        let storage = Storage.storage().reference(forURL: "gs://everyonemeal.appspot.com")

        let storageRef = storage.child(userID).child("\(getToday(format: "y.M.d")) morning.jpeg")

        let metaData = StorageMetadata()

        metaData.contentType = "image/jpeg"

        var uploadData  = Data()

        uploadData = (selectImageView.image?.jpegData(compressionQuality: 0.9))!

        storageRef.putData(uploadData, metadata: metaData) {
            metaData, Error in
            if Error != nil {
                print("アップに失敗しました。\(Error.debugDescription)")
                return
            }else {
                print("アップに成功しました。")

                //保存時にアラート表示
                let saveAlert = UIAlertController(title: "写真を記録しました", message: "", preferredStyle: .alert)
                saveAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(saveAlert, animated: true, completion: nil)

            }
        }
    }
}

//ピックされた画像をビューへ表示する
extension todayMorningSavePhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectImageView.contentMode = .scaleAspectFit
            selectImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
