//
//  ViewController.swift
//  FoodTracker
//
//  Created by kudo koki on 2021/03/29.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    // プロパティ
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    //4
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // textFieldの処理をデリゲートで対応
        nameTextField.delegate = self
    }
    
    // UITextFieldDelegateの関数。各イベントに対する処理を記述
    // texFieldShouldReturn: リターンキーを押した時の処理。基本的に戻り値はtrueで良い。
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 編集を完了する　→　ファーストレスポンダをやめる
        textField.resignFirstResponder()
        return true
    }
    // textFieldDidEndEditing: textFieldの編集が完了した時に実行
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealName.text = textField.text
    }
    
    //setDefaultLabelTextボタンを押した時に実行
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealName.text = "Default Text"
    }
    
}

