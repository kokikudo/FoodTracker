//
//  MealViewController.swift
//  FoodTracker
//
//  Created by kudo koki on 2021/03/29.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // プロパティ
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var meal: Meal? // 追加された料理データ
    
    //4
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // textFieldの処理をデリゲートで対応
        nameTextField.delegate = self
        
        // 既存の料理を編集する場合、白紙のページに各プロパティの値をセット
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        // 料理名を入力するまで「保存ボタン」無効
        updateSaveButtomState()
    }
    
    // ナビゲーション
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // 保存ボタンが押された場合のみ宛先ViewControllerを設定
        guard let button = sender as? UIBarButtonItem,
              button === saveButton else { // 押されなかった時はコンソールに表示し戻る
            os_log("The save button was not pressed, canselling", log: OSLog.default, type: .debug)
            return
        }
        
        // 保存した料理名、写真、評価点を格納
        let name = nameTextField.text ?? "" // ?? = null合体演算子。値がある場合はオプショナル型で値を返し、nilの場合はデフォルト値（""）を返す
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        // アンワインドセグエの後にMealTableViewContorollerに渡すMealインスタンスを生成
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
    // UITextFieldDelegateの関数。textField編集前後の処理
    //　テキスト編集中は「保存」ボタンを無効にする
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    // リターンキーを押した時の処理。基本的に戻り値はtrueで良い。
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 編集を完了する　→　ファーストレスポンダをやめる
        textField.resignFirstResponder()
        return true
    }
    // textFieldの編集が完了した時に実行
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // テキストが空かどうか確認し、テキスト内容をナビゲーションのタイトルに設定
        updateSaveButtomState()
        navigationItem.title = textField.text
    }
    // 写真タップ時の処理
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // textFieldに入力中に写真をタップした場合、キーボードが閉じるようにする
        nameTextField.resignFirstResponder()
        // インスタンス生成
        let imagePickerController = UIImagePickerController()
        // 「ライブラリから選択」のみ実装
        imagePickerController.sourceType = .photoLibrary
        // imagePickerControllerデリゲート
        imagePickerController.delegate = self
        // UIImagePickerControllerに遷移させる
        present(imagePickerController, animated: true, completion: nil)
    }
    // imagePickerのキャンセルボタンを押した時の処理
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 処理を却下する
        dismiss(animated: true, completion: nil)
    }
    // imagePickerで写真を選択した時に実行。
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 選択した写真がUIImageに変換可能か確認
        guard let selectedImage = info[.originalImage] as? UIImage
        else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // 適用する
        photoImageView.image = selectedImage
        // imagePickerを閉じる
        dismiss(animated: true, completion: nil)
    }
    
    // キャンセルボタンで戻る
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        // このページを開いたのがUINavigationControllerタイプか確認
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        // UINavigationControllerタイプであればそのまま何も出ず閉じる
        // そうでなければナビゲーションスタックにプッシュされている（編集している）のでpopViewController()でリストに戻る
        // このメソッドは、コントローラーをナビゲーションスタックから除外することで編集中の内容をキャンセルしている
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The MealViewController is not inside a navigation controller.") 
        }
    }
    
    // プライベートメソッド
    private func updateSaveButtomState() {
        
        // textが空の場合は保存ボタンを無効にする
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

