//
//  MealViewController.swift
//  FoodTracker
//
//  Created by kudo koki on 2021/03/29.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // プロパティ
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    //4
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
}

