//
//  Signin.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2021/10/25.
//

import UIKit
import Firebase

class signInViewController:UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //アクティビティインジケーター
        func activityIndicator(){

            ActivityIndicator.center = self.view.center
            self.view.addSubview(ActivityIndicator)
        }
        activityIndicator()

        let keyboardClose = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 30))

        keyboardClose.barStyle = UIBarStyle.default

        keyboardClose.sizeToFit()

        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)

        let closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.closeButtonTapped))

        keyboardClose.items = [spacer,closeButton]

        signInEmailTextField.inputAccessoryView = keyboardClose
        signInPasswordTextField.inputAccessoryView = keyboardClose

        //キーボードが開いた際、viewを移動
         NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        //キーボードが閉じた際、viewを移動
         NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @IBOutlet weak var signInEmailTextField: UITextField!
    @IBOutlet weak var signInPasswordTextField: UITextField!

    @IBOutlet weak var signInButton: UIButton!

    @IBAction func signInButtonTapped(_ sender: Any) {
        let email = signInEmailTextField.text ?? ""
        let password = signInPasswordTextField.text ?? ""
        //アクティビティインジケーターをスタート
        ActivityIndicator.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in guard let strongSelf = self else {return}
            if authResult?.user != nil {
                print("ログインに成功しました。")
                //アクティビティインジケーターをストップ
                ActivityIndicator.stopAnimating()
                self?.performSegue(withIdentifier: "toHomeTabBarControllerfromSignIn", sender: self)

            }else {
                print("ログインに失敗しました。")
                //アクティビティインジケーターをストップ
                ActivityIndicator.stopAnimating()
                //ユーザーに[失敗]のアラート表示
                let failedSignIn = UIAlertController(title: "ログインに失敗しました", message: "もう一度入力してください", preferredStyle: .alert)
                failedSignIn.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(failedSignIn, animated: true, completion: nil)
            }
        }
    }
    //画面タップ時にキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    //キーボードを閉じるアクション
    @objc func closeButtonTapped() {
        self.view.endEditing(true)
    }
    //キーボードが開いた際に起こるアクション内容
    @objc func showKeyboard(notification:Notification) {
        let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue

        guard let keyboardFrameMinY = keyboardFrame?.minY else {return}
        let signInButtonFrameMaxY = signInButton.frame.maxY
        let distance = signInButtonFrameMaxY - keyboardFrameMinY + 15

        let transform = CGAffineTransform(translationX: 0, y: -distance)

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.view.transform = transform
        }, completion: nil)
    }
    //キーボードが閉じた際に起こるアクション内容
    @objc func hideKeyboard() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.view.transform = .identity
        }, completion: nil)
    }
}
