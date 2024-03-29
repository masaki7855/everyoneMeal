//
//  ViewController.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2021/09/09.
//

import UIKit
import FSCalendar
import Firebase




class HomeViewcontroller:UIViewController,FSCalendarDelegate,FSCalendarDelegateAppearance,FSCalendarDataSource{

    @IBOutlet weak var calendar: FSCalendar!


    override func viewDidLoad() {
        super.viewDidLoad()

        guard let Calendar = calendar else {return}
        
        //1.ホーム　Label
        let hometTitle = UILabel()
        hometTitle.text = "ホーム"
        hometTitle.font = UIFont(name: "Optima-Bold", size: 30)
        hometTitle.frame = CGRect(x: 200, y: 50, width: 200, height: 50)
        hometTitle.textAlignment = NSTextAlignment.center
        hometTitle.center.x = self.view.center.x
        self.view.addSubview(hometTitle)
        
        //FSCalendarのレイアウト
       
        Calendar.frame = CGRect(x: 0, y: 250, width: view.frame.width, height: 700)

        Calendar.center = self.view.center

        Calendar.appearance.headerDateFormat = "YYYY年MM月"

        Calendar.calendarWeekdayView.weekdayLabels[0].text = "日"
        Calendar.calendarWeekdayView.weekdayLabels[1].text = "月"
        Calendar.calendarWeekdayView.weekdayLabels[2].text = "火"
        Calendar.calendarWeekdayView.weekdayLabels[3].text = "水"
        Calendar.calendarWeekdayView.weekdayLabels[4].text = "木"
        Calendar.calendarWeekdayView.weekdayLabels[5].text = "金"
        Calendar.calendarWeekdayView.weekdayLabels[6].text = "土"

        Calendar.delegate = self
        
        //"Back"ボタン　文字非表示
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title:"",
            style: .plain,
            target: nil,
            action: nil
        )
    }

    


    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let selectDate = Calendar(identifier: .gregorian)
        let year = selectDate.component(.year, from: date)
        let month = selectDate.component(.month, from: date)
        let day = selectDate.component(.day, from: date)
        //カレンダーで選択した日付の情報
        appDelegate.calendarDate = "\(year).\(month).\(day)"


        let alert = UIAlertController(title: "選択した日付の記録、\nまたは確認をしますか？", message: "", preferredStyle: .alert)

        let selectDateSave = UIAlertAction(title: "記録する", style:.default){ (action) in
            
            self.performSegue(withIdentifier: "toSelectSave", sender: self)
        }
        let selectDateCheck = UIAlertAction(title: "確認する", style: .default){ (action) in
            self.performSegue(withIdentifier: "toSelectSave", sender: self)
        }
        let cancel = UIAlertAction(title: "キャンセル", style:.cancel){ (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(cancel)
        alert.addAction(selectDateSave)
        alert.addAction(selectDateCheck)
        self.present(alert, animated: true, completion: nil)


    }


}

//以下"記録する"を押した際の処理・コード
class selectEachMealViewcontroller: HomeViewcontroller {

    var leftButtonBack: UIBarButtonItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        

        //選択した日付を表示する
        let selectDay = UILabel()
        selectDayLabel(uiLabel: selectDay, uiViewController: self)
        
        //"朝食を記入する"ボタン
        makeMealButton.selectSaveMeal(selectSaveClass: self, meal: "朝食", frameX: 200, frameY: 250, selectEachMeal: #selector(self.theMorningSaveButton(_:)))

        //"昼食を記入する"ボタン
        makeMealButton.selectSaveMeal(selectSaveClass: self, meal: "昼食", frameX: 200, frameY: 350, selectEachMeal: #selector(self.theLunchSaveButton(_:)))

        //"夕食を記入する"ボタン
        makeMealButton.selectSaveMeal(selectSaveClass: self, meal: "夕食", frameX: 200, frameY: 450, selectEachMeal: #selector(self.theDinnerSaveButton(_:)))
        
        //"Back"ボタン　文字非表示
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title:"",
            style: .plain,
            target: nil,
            action: nil
        )
    }
    
    // "朝食を記入する"　ボタンのアクション内容 :画面遷移
    @objc func theMorningSaveButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSelectTheMorningSave", sender: self)
    }

    // "昼食を記入する"　ボタンのアクション内容 :画面遷移
    @objc func theLunchSaveButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSelectTheLunchSave", sender: self)
    }

    // "夕食を記入する"　ボタンのアクション内容 :画面遷移
    @objc func theDinnerSaveButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSelectTheDinnerSave", sender: self)
    }
    
    //”戻る”　ボタンのアクション内容
    @objc func backHome(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
//下記　朝食を記録するコード
class selectTheMorningSaveViewcontroller: cameraViewcontroller {
    
    var leftButtonClose: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        //Modelから各ボタンのUIコードを参照
        thedaySelectSaveoptions.makeOptions(mainVC: self, meal:"朝食", mainSelectSaveTextButton: #selector(self.selectSaveTextButton(_:)), mainSelectSavePhotoButton: #selector(self.selectSavePhotoButton(_:)))
        
    }

    //"メモを記入する"ボタンのアクション内容　: 画面遷移
    @objc func selectSaveTextButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "toThedayMorningSaveMemo", sender: self)
    }

    //"画像を選択する"ボタンのアクション内容　: 画面遷移
    @objc func selectSavePhotoButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "toThedayMorningSavePhoto", sender: self)
    }
    
    //バー　"閉じる"ボタンのアクション内容
    @objc func backSelectSave(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

class thedayMorningSaveMemoViewcontroller: UIViewController {

    

    var eachMeal = "\(appDelegate.calendarDate!) morning"
    var memo = UITextView()
    var eachMealPhotoData = "\(appDelegate.calendarDate!) morning.jpeg"
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

class thedayMorningSavePhotoViewController: HomeViewcontroller {

    let selectImageView = UIImageView()
    let imagePicker = UIImagePickerController()
    var eachMealPhotoData = "\(appDelegate.calendarDate!) morning.jpeg"
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

        let storageRef = storage.child(userID).child("\(appDelegate.calendarDate!) morning.jpeg")

        let metaData = StorageMetadata()

        metaData.contentType = "image/jpeg"

        var uploadData  = Data()

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
extension thedayMorningSavePhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

class selectTheLunchSaveViewcontroller: cameraViewcontroller {

    var leftButtonClose: UIBarButtonItem!


    override func viewDidLoad() {
        super.viewDidLoad()


        //Modelから各ボタンのUIコードを参照
        thedaySelectSaveoptions.makeOptions(mainVC: self, meal:"昼食", mainSelectSaveTextButton: #selector(self.selectSaveTextButton(_:)), mainSelectSavePhotoButton: #selector(self.selectSavePhotoButton(_:)))

    }

    //"メモを記入する"ボタンのアクション内容　: 画面遷移
    @objc func selectSaveTextButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "toThedayLunchSaveMemo", sender: self)
    }

    //"画像を選択する"ボタンのアクション内容　: 画面遷移
    @objc func selectSavePhotoButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "toThedayLunchSavePhoto", sender: self)
    }

    //バー　"閉じる"ボタンのアクション内容
    @objc func backSelectSave(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

class thedayLunchSaveMemoViewcontroller: UIViewController {



    var eachMeal = "\(appDelegate.calendarDate!) lunch"
    var memo = UITextView()
    var eachMealPhotoData = "\(appDelegate.calendarDate!) lunch.jpeg"
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

class thedayLunchSavePhotoViewController: HomeViewcontroller {

    let selectImageView = UIImageView()
    let imagePicker = UIImagePickerController()
    var eachMealPhotoData = "\(appDelegate.calendarDate!) lunch.jpeg"



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

        let storageRef = storage.child(userID).child("\(appDelegate.calendarDate!) lunch.jpeg")

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
                let saveAlert = UIAlertController(title: "画像を記録しました", message: "", preferredStyle: .alert)
                saveAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(saveAlert, animated: true, completion: nil)

            }
        }
    }
}

//ピックされた画像をビューへ表示する
extension thedayLunchSavePhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

class selectTheDinnerSaveViewcontroller: cameraViewcontroller {

    var leftButtonClose: UIBarButtonItem!


    override func viewDidLoad() {
        super.viewDidLoad()


        //Modelから各ボタンのUIコードを参照
        thedaySelectSaveoptions.makeOptions(mainVC: self, meal:"夕食", mainSelectSaveTextButton: #selector(self.selectSaveTextButton(_:)), mainSelectSavePhotoButton: #selector(self.selectSavePhotoButton(_:)))

    }

    //"メモを記入する"ボタンのアクション内容　: 画面遷移
    @objc func selectSaveTextButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "toThedayDinnerSaveMemo", sender: self)
    }

    //"画像を選択する"ボタンのアクション内容　: 画面遷移
    @objc func selectSavePhotoButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "toThedayDinnerSavePhoto", sender: self)
    }

    //バー　"閉じる"ボタンのアクション内容
    @objc func backSelectSave(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

class thedayDinnerSaveMemoViewcontroller: UIViewController {



    var eachMeal = "\(appDelegate.calendarDate!) dinner"
    var memo = UITextView()
    var eachMealPhotoData = "\(appDelegate.calendarDate!) dinner.jpeg"
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

class thedayDinnerSavePhotoViewController: HomeViewcontroller {

    let selectImageView = UIImageView()
    let imagePicker = UIImagePickerController()
    var eachMealPhotoData = "\(appDelegate.calendarDate!) dinner.jpeg"



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

        let storageRef = storage.child(userID).child("\(appDelegate.calendarDate!) dinner.jpeg")

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
                let saveAlert = UIAlertController(title: "画像を記録しました", message: "", preferredStyle: .alert)
                saveAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(saveAlert, animated: true, completion: nil)

            }
        }
    }
}

//ピックされた画像をビューへ表示する
extension thedayDinnerSavePhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

