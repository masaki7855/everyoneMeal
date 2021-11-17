//
//  selectEachMeal.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2021/11/13.
//

import UIKit
import FSCalendar

class selectMealButton: selectSaveViewcontroller {


    func selectMeal(selectSaveClass: selectSaveViewcontroller,meal: String, frameX: Int, frameY: Int, selectEachMeal: Selector) {
        
        let selectSaveButton = UIButton()


        selectSaveButton.setTitle("\(meal)を記入する", for: UIControl.State.normal)

        selectSaveButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        selectSaveButton.frame = CGRect(x: frameX, y: frameY, width: 200, height: 50)

        selectSaveButton.center.x = selectSaveClass.view.center.x

        selectSaveButton.setTitleColor(UIColor.white, for: .normal)

        selectSaveButton.backgroundColor = UIColor.gray

        selectSaveButton.addTarget(selectSaveClass, action: selectEachMeal, for: .touchUpInside)

        selectSaveClass.view.addSubview(selectSaveButton)
    }
}
let makeMealButton = selectMealButton()

