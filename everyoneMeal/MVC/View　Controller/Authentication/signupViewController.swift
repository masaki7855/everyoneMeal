//
//  signupViewController.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2021/10/11.
//

import UIKit
import Firebase
import FSCalendar

class signUpViewController:UIViewController, UITextFieldDelegate {

    var handle: AuthStateDidChangeListenerHandle!

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet private weak var nameTextField: UITextField!
    
    @IBOutlet private weak var emailTextField: UITextField!
    
    @IBOutlet private weak var passwordTextField: UITextField!

    @IBAction func signUpButtonTapped(_ sender: Any) {
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        //アクティビティインジケーターをスタート
        ActivityIndicator.startAnimating()
        //サインアップの処理
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("サインアップに失敗しました。\(error)")
                //アクティビティインジケーターをストップ
                ActivityIndicator.stopAnimating()
                //ユーザーに[失敗]のアラート表示
                let failedSignUp = UIAlertController(title: "サインアップに失敗しました", message: "もう一度入力してください", preferredStyle: .alert)
                failedSignUp.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(failedSignUp, animated: true, completion: nil)
                return
            }
            if let user = authResult {
                print("サインアップに成功しました。")
                //アクティビティインジケーターをストップ
                ActivityIndicator.stopAnimating()
                
                self.performSegue(withIdentifier: "toHomeTabBarcontroller", sender: self)
            }
        }
        
    }
    //ログイン画面への画面遷移
    @IBAction func toLoginButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toLogin", sender: self)
    }
    //ユーザーがログインしている状態の場合、ホーム画面へ画面遷移
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        handle = Auth.auth().addStateDidChangeListener {
        (auth, user) in
            if user == nil {
            }else {
                self.performSegue(withIdentifier: "toHomeTabBarcontroller", sender: self)
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        Auth.auth().removeStateDidChangeListener(handle!)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //アクティビティインジケーター
        func activityIndicator() {

            ActivityIndicator.center = self.view.center
            self.view.addSubview(ActivityIndicator)
        }

        activityIndicator()

        //キーボードを閉じるボタン
        
        let keyboardClose = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        
        keyboardClose.barStyle = UIBarStyle.default
        
        keyboardClose.sizeToFit()
        
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.closeButtonTapped))
        
        keyboardClose.items = [spacer,closeButton]
        
        nameTextField.inputAccessoryView = keyboardClose
        emailTextField.inputAccessoryView = keyboardClose
        passwordTextField.inputAccessoryView = keyboardClose
        
       //キーボードが開いた際、viewを移動
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
       //キーボードが閉じた際、viewを移動
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //画面タップ時にキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    //キーボードが開いた際に起こるアクション内容
    @objc func showKeyboard(notification:Notification) {
        let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue

        guard let keyboardFrameMinY = keyboardFrame?.minY else {return}
        let signUpButtonFrameMaxY = signUpButton.frame.maxY
        let distance = signUpButtonFrameMaxY - keyboardFrameMinY + 15

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
    //キーボードを閉じるアクション
    @objc func closeButtonTapped() {
        self.view.endEditing(true)
    }
    
    
    
}
