//
//  settingViewController.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2021/10/27.
//

import UIKit
import Firebase

class settingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{


    @IBOutlet weak var settingTableView: UITableView!


    var settingArray: [String] = ["サインアウトする","パスワードを変更する"]

    //TableViewCellIdentifierの名前
    let tableViewCellIdentifier = "SettingUITableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        settingTableView = UITableView(frame: self.view.frame, style: UITableView.Style.grouped)

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)

        cell.textLabel!.text = settingArray[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch  indexPath.row {
        case 0:
            do {
                 try Auth.auth().signOut()
                print("サインアウトしました")
                self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
                 } catch let signOutError as NSError {
                     print("サインアウトに失敗しました:", signOutError)
                 }
        case 1:
            print("パスワードを変更する")
        default:
            break
        }
    }
}
