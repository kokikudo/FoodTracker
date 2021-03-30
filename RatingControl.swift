//
//  RatingControl.swift
//  FoodTracker
//
//  Created by kudo koki on 2021/03/30.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //プロパティ
    private var ratingButtons = [UIButton]() //このクラス外にアクセスすることがないためprivate
    
    var rating = 0 { // 評価点。更新されるたびに星の状態を変更する関数を実行
        didSet {
            updateButtonSelectionSates()
        }
    }

    //init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    // 必須イニシャライザ
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    // ボタンアクション
    @objc func ratingButtonTapped(button: UIButton) {
        
        // 選択されたボタンの要素数を返す
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // 要素数は0からスタートするので＋1する
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // レートと同じ場合は0にする
            rating = 0
        } else {
            //　そうじゃなければレートを更新する
            rating = selectedRating
        }
    }
    // privateメソッド
    private func setupButtons() {
        
        //古いボタンをクリア
        for button in ratingButtons {
            removeArrangedSubview(button) //スタックビューで管理していたビューのリストからボタンを削除
            button.removeFromSuperview() // スタックビューからボタンを削除
        }
        ratingButtons.removeAll() //リストを空にする
        
        // Assetsカタログからイメージ画像を変数にセット
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        // ボタンを作成
        for index in 0..<starCount {
            // Button作成
            let button = UIButton()
            
            // イメージをセット
            button.setImage(emptyStar, for: .normal) // デフォルト
            button.setImage(filledStar, for: .selected) // 選択された時の状態
            button.setImage(highlightedStar, for: .highlighted) // 強調表示された状態
            button.setImage(highlightedStar, for: [.highlighted, .selected]) // 選択・強調表示の状態
            
            // 制約
            button.translatesAutoresizingMaskIntoConstraints = false // 自動生成された制約を無効
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true // 高さ
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true // 幅
            
            // アクセシビリティラベルをセット
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            // ボタンのアクションを設定
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // ビューに追加
            addArrangedSubview(button)
            
            // ボタンをratingButtons: [UIButton]()に追加
            ratingButtons.append(button)
        }
    }
    
    // 評価（星）のサイズと数
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    // ratingより左の星の状態をratingと同じにする
    private func updateButtonSelectionSates() {
        for (index, button) in ratingButtons.enumerated() {
            // 各ボタンがratingより左かどうか
            button.isSelected = index < rating
            
            // 現在選択されているボタンか確認
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            //　評価点に応じて文字列を指定
            let valueString: String
            switch rating {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
            
            //　アクセシビリティを追加
            button.accessibilityHint = hintString // アクションの結果を説明
            button.accessibilityValue = valueString //　ラベルがなくても要素の値を表示できる
        }
    }
}
