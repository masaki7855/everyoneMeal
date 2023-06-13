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
        makeMealButton.selectSaveMeal(selectSaveClass: self, meal: "朝食", frameX: 200, frameY: 250, selectEachMeal: Selector("todayMorningSaveButton:"))

        //"昼食を記入する"ボタン
        makeMealButton.selectSaveMeal(selectSaveClass: self, meal: "昼食", frameX: 200, frameY: 350, selectEachMeal: Selector("todayLunchSaveButton:"))

        //"夕食を記入する"ボタン
        makeMealButton.selectSaveMeal(selectSaveClass: self, meal: "夕食", frameX: 200, frameY: 450, selectEachMeal: Selector("todayDinnerSaveButton:"))

        //"Back"ボタン　文字非表示
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title:"",
            style: .plain,
            target: nil,
            action: nil
        )

    }
    //"朝食を記入する"　ボタンのアクション内容 :画面遷移
    @objc func todayMorningSaveButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSelectTodayMorningSave", sender: self)
    }
    //"昼食を記入する"　ボタンのアクション内容 :画面遷移
    @objc func todayLunchSaveButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSelectTodayLunchSave", sender: self)
    }
    //"夕食を記入する"　ボタンのアクション内容 :画面遷移
    @objc func todayDinnerSaveButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSelectTodayDinnerSave", sender: self)
    }
}


//下記 朝食を記録するコード
class selectTodayMorningSaveViewController: cameraViewcontroller {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Model から"selectSaveoptions.swift"のコードを参照
        todaySelectSaveoptions.makeOptions(mainVC: self,meal: "朝食", mainSelectSaveTextButton: #selector(self.selectSaveTextButton(_:)), mainSelectSavePhotoButton: #selector(self.selectSavePhotoButton(_:)))
    }

    //"メモを記入する"ボタンのアクション内容　: 画面遷移
    @objc func selectSaveTextButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "toTodayMorningSaveMemo", sender: self)
    }

    //"画像を選択する"ボタンのアクション内容　: 画面遷移
    @objc func selectSavePhotoButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "toTodayMorningSavePhoto", sender: self)
    }
}

class todayMorningSaveMemoViewController: UIViewController {

    
    var eachMeal = "\(getToday()) morning"
    var memo = UITextView()
    var eachMealPhotoData = "\(getToday(format: "y.M.d")) morning.jpeg"
    let selectImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         "選択した画像を表示するView"
         "メモを保存するボタン"
         "メモ記入欄"
         "メモ記入時のキーボードを閉じるボタン"
         */
        saveMemoButton.makeSaveMemoButton(selectImageView: selectImageView, self: self, saveMorningMemoDataToFirestore: #selector(self.saveMorningMemoDataToFirestore(_:)), memo: memo, closeButtonTapped: #selector(self.closeButtonTapped))

        //firestroreからメモのデータを取得する

        getMemoDataFromFirebase(eachMeal: self.eachMeal,memo: self.memo)

        //データ取得（保存している画像があれば読み込み、表示する）
        getPhotoDataFromFireStorage(eachMealPhotoData: self.eachMealPhotoData, photo: selectImageView)




    }
    //キーボードを閉じるアクション
    @objc func closeButtonTapped() {
        self.view.endEditing(true)
    }
    
    //FireStoreへ　メモを保存
    @objc func saveMorningMemoDataToFirestore(_ sender: Any) {


guard let userID = Auth.auth().currentUser?.uid else {return}
        guard let memoData = memo.text else {return}

        db.collection("users").document(userID).setData(["\(eachMeal)" : memoData], merge: true) { err in
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
    var eachMealPhotoData = "\(getToday(format: "y.M.d")) morning.jpeg"
    var selectPictures = UIImageView()


    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         "選択した画像を表示するView"
         "ライブラリーから画像を選択する"
         "表示している画像で記録する"
         */
        savePhotoButton.makeSavePhotoButton(selectImageView:selectImageView,self: self, toImagePicker:#selector(self.toImagePicker(_:)), savePhoto: #selector(self.savePhoto))

        imagePicker.delegate = self

        //データ取得（保存している画像があれば読み込み、表示する）
        getPhotoDataFromFireStorage(eachMealPhotoData: self.eachMealPhotoData, photo: selectImageView)

    }

    /*"画像を選択する"ボタンのアクション内容
    （ライブラリーに移動し画像を選択する）*/
    @objc func toImagePicker(_ sender: Any) {
        imagePicker.allowsEditing = true

        imagePicker.sourceType = .photoLibrary

        present(imagePicker, animated: true, completion:
        nil)
    }
    //firestorageに画像を保存する
    @objc func savePhoto () {

        guard let userID = Auth.auth().currentUser?.uid else {return}
        //ストレージサーバーのURL
        let storage = Storage.storage().reference(forURL: "gs://everyonemeal.appspot.com")

        let storageRef = storage.child(userID).child("\(getToday(format: "y.M.d")) morning.jpeg")

        let metaData = StorageMetadata()

        metaData.contentType = "image/jpeg"

        var uploadData  = Data()

        selectPictures.image = UIImage(named: "selectPictures")!

        uploadData = (selectImageView.image?.jpegData(compressionQuality: 0.9)) ?? selectPictures.image!.jpegData(compressionQuality: 1)!

        storageRef.putData(uploadData, metadata: metaData) {
            metaData, Error in
            if Error != nil {
                print("アップに失敗しました。\(Error.debugDescription)")
                return
            }else {
                print("アップに成功しました。")

                //保存時にアラート表示
                let saveAlert = UIAlertController(title: "画像を記録しました", message: "", preferredStyle: .alert)
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
//以上　朝食を記録するコード

//下記　昼食を記録するコード

class selectTodayLunchSaveViewController: cameraViewcontroller {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Modelから各ボタンのUIコードを参照
        todaySelectSaveoptions.makeOptions(mainVC: self,meal: "昼食", mainSelectSaveTextButton: #selector(self.selectSaveTextButton(_:)), mainSelectSavePhotoButton: #selector(self.selectSavePhotoButton(_:)))
    }

    //"メモを記入する"ボタンのアクション内容　: 画面遷移
    @objc func selectSaveTextButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "toTodayLunchSaveMemo", sender: self)
    }

    //"画像を選択する"ボタンのアクション内容　: 画面遷移
    @objc func selectSavePhotoButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "toTodayLunchSavePhoto", sender: self)
    }
}

class todayLunchSaveMemoViewController: UIViewController {


    var eachMeal = "\(getToday()) lunch"
    var memo = UITextView()
    var eachMealPhotoData = "\(getToday(format: "y.M.d")) lunch.jpeg"
    let selectImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()



        //選択した画像を表示するView
        selectImageView.frame = CGRect(x: 0, y: 120, width: 275, height: 275)
        selectImageView.center.x = self.view.center.x

        selectImageView.layer.borderWidth = 2

        selectImageView.layer.borderColor = UIColor.gray.cgColor

        selectImageView.layer.cornerRadius = 5

        self.view.addSubview(selectImageView)

        //firestroreからメモのデータを取得する

        getMemoDataFromFirebase(eachMeal: self.eachMeal,memo: self.memo)

        //データ取得（保存している画像があれば読み込み、表示する）
        getPhotoDataFromFireStorage(eachMealPhotoData: self.eachMealPhotoData, photo: selectImageView)


        //"メモを保存する"ボタン
        let saveMemoButton = UIButton()

        saveMemoButton.setTitle("メモを保存する", for: UIControl.State.normal)

        saveMemoButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        saveMemoButton.frame = CGRect(x: 200, y: 700, width: 200, height: 50)
        saveMemoButton.center.x = self.view.center.x

        saveMemoButton.setTitleColor(UIColor.white, for: .normal)

        saveMemoButton.backgroundColor = UIColor.gray

        saveMemoButton.addTarget(self, action: #selector(saveLunchMemoDataToFirestore(_:)), for: .touchUpInside)

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
    @objc func saveLunchMemoDataToFirestore(_ sender: Any) {


guard let userID = Auth.auth().currentUser?.uid else {return}
        guard let memoData = memo.text else {return}

        db.collection("users").document(userID).setData(["\(eachMeal)" : memoData], merge: true) { err in
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

class todayLunchSavePhotoViewController: UIViewController {

    let selectImageView = UIImageView()
    let imagePicker = UIImagePickerController()
    var eachMealPhotoData = "\(getToday(format: "y.M.d")) lunch.jpeg"
    var selectPictures = UIImageView()


    override func viewDidLoad() {
        super.viewDidLoad()

        //選択した画像を表示するView
        selectImageView.frame = CGRect(x: 0, y: 175, width: 275, height: 275)
        selectImageView.center.x = self.view.center.x

        selectImageView.layer.borderWidth = 2

        selectImageView.layer.borderColor = UIColor.gray.cgColor

        selectImageView.layer.cornerRadius = 5

        self.view.addSubview(selectImageView)

        //"画像を選択する"ボタン
        let selectPhotoButton = UIButton()

        selectPhotoButton.setTitle("画像を選択する", for: UIControl.State.normal)

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
        getPhotoDataFromFireStorage(eachMealPhotoData: self.eachMealPhotoData, photo: selectImageView)

    }

    /*"画像を選択する"ボタンのアクション内容
    （ライブラリーに移動し写真を選択する）*/
    @objc func toImagePicker(_ sender: Any) {
        imagePicker.allowsEditing = true

        imagePicker.sourceType = .photoLibrary

        present(imagePicker, animated: true, completion:
        nil)
    }
    //firestorageに画像を保存する
    @objc func savePhoto () {

        guard let userID = Auth.auth().currentUser?.uid else {return}
        //ストレージサーバーのURL
        let storage = Storage.storage().reference(forURL: "gs://everyonemeal.appspot.com")

        let storageRef = storage.child(userID).child("\(getToday(format: "y.M.d")) lunch.jpeg")

        let metaData = StorageMetadata()

        metaData.contentType = "image/jpeg"

        var uploadData  = Data()

        selectPictures.image = UIImage(named: "selectPictures")!

        uploadData = (selectImageView.image?.jpegData(compressionQuality: 0.9)) ?? selectPictures.image!.jpegData(compressionQuality: 1)!

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
extension todayLunchSavePhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
//以上　昼食を記録するコード

//下記　夕食を記録するコード

class selectTodayDinnerSaveViewController: cameraViewcontroller {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Modelから各ボタンのUIコードを参照
        todaySelectSaveoptions.makeOptions(mainVC: self,meal: "夕食", mainSelectSaveTextButton: #selector(self.selectSaveTextButton(_:)), mainSelectSavePhotoButton: #selector(self.selectSavePhotoButton(_:)))
    }

    //"メモを記入する"ボタンのアクション内容　: 画面遷移
    @objc func selectSaveTextButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "toTodayDinnerSaveMemo", sender: self)
    }

    //"画像を選択する"ボタンのアクション内容　: 画面遷移
    @objc func selectSavePhotoButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "toTodayDinnerSavePhoto", sender: self)
    }
}

class todayDinnerSaveMemoViewController: UIViewController {


    var eachMeal = "\(getToday()) dinner"
    var memo = UITextView()
    var eachMealPhotoData = "\(getToday(format: "y.M.d")) dinner.jpeg"
    let selectImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()



        //選択した画像を表示するView
        selectImageView.frame = CGRect(x: 0, y: 120, width: 275, height: 275)
        selectImageView.center.x = self.view.center.x

        selectImageView.layer.borderWidth = 2

        selectImageView.layer.borderColor = UIColor.gray.cgColor

        selectImageView.layer.cornerRadius = 5

        self.view.addSubview(selectImageView)

        //firestroreからメモのデータを取得する

        getMemoDataFromFirebase(eachMeal: self.eachMeal,memo: self.memo)

        //データ取得（保存している画像があれば読み込み、表示する）
        getPhotoDataFromFireStorage(eachMealPhotoData: self.eachMealPhotoData, photo: selectImageView)


        //"メモを保存する"ボタン
        let saveMemoButton = UIButton()

        saveMemoButton.setTitle("メモを保存する", for: UIControl.State.normal)

        saveMemoButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        saveMemoButton.frame = CGRect(x: 200, y: 700, width: 200, height: 50)
        saveMemoButton.center.x = self.view.center.x

        saveMemoButton.setTitleColor(UIColor.white, for: .normal)

        saveMemoButton.backgroundColor = UIColor.gray

        saveMemoButton.addTarget(self, action: #selector(saveDinnerMemoDataToFirestore(_:)), for: .touchUpInside)

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
    @objc func saveDinnerMemoDataToFirestore(_ sender: Any) {


guard let userID = Auth.auth().currentUser?.uid else {return}
        guard let memoData = memo.text else {return}

        db.collection("users").document(userID).setData(["\(eachMeal)" : memoData], merge: true) { err in
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

class todayDinnerSavePhotoViewController: UIViewController {

    let selectImageView = UIImageView()
    let imagePicker = UIImagePickerController()
    var eachMealPhotoData = "\(getToday(format: "y.M.d")) dinner.jpeg"
    var selectPictures = UIImageView()


    override func viewDidLoad() {
        super.viewDidLoad()

        //選択した画像を表示するView
        selectImageView.frame = CGRect(x: 0, y: 175, width: 275, height: 275)
        selectImageView.center.x = self.view.center.x

        selectImageView.layer.borderWidth = 2

        selectImageView.layer.borderColor = UIColor.gray.cgColor

        selectImageView.layer.cornerRadius = 5

        self.view.addSubview(selectImageView)

        //"画像を選択する"ボタン
        let selectPhotoButton = UIButton()

        selectPhotoButton.setTitle("画像を選択する", for: UIControl.State.normal)

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
        getPhotoDataFromFireStorage(eachMealPhotoData: self.eachMealPhotoData, photo: selectImageView)

    }

    /*"画像を選択する"ボタンのアクション内容
    （ライブラリーに移動し写真を選択する）*/
    @objc func toImagePicker(_ sender: Any) {
        imagePicker.allowsEditing = true

        imagePicker.sourceType = .photoLibrary

        present(imagePicker, animated: true, completion:
        nil)
    }
    //firestorageに画像を保存する
    @objc func savePhoto () {

        guard let userID = Auth.auth().currentUser?.uid else {return}
        //ストレージサーバーのURL
        let storage = Storage.storage().reference(forURL: "gs://everyonemeal.appspot.com")

        let storageRef = storage.child(userID).child("\(getToday(format: "y.M.d")) dinner.jpeg")

        let metaData = StorageMetadata()

        metaData.contentType = "image/jpeg"

        var uploadData  = Data()

        selectPictures.image = UIImage(named: "selectPictures")!

        uploadData = (selectImageView.image?.jpegData(compressionQuality: 0.9)) ?? selectPictures.image!.jpegData(compressionQuality: 1)!

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
extension todayDinnerSavePhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
//以上　夕食を記録するコード
