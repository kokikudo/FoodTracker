//
//  Meal.swift
//  FoodTracker
//
//  Created by kudo koki on 2021/03/31.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    // プロパティ 変更する可能性があるので変数
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // アーカイブからデータを送受信するためのパスを設定
    // アプリのドキュメントディレクトリのURLを取得
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    // ドキュメントURLの最後にmealsを追加してファイルのURLを生成
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    // init
    init?(name: String, photo: UIImage?, rating: Int) {
        
        //名前が空の場合にnilを返す
        if name.isEmpty {
            return nil
        }
        // 評価が0~5の範囲外の場合にnilを返す
        guard case 0...5 = rating else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    
    // エンコード、デコードの際に必要なキー
    struct PropertyKey {
        
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    // NSCoding
    // 3つの値を該当するキーで登録してエンコード
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: PropertyKey.name)
        coder.encode(photo, forKey: PropertyKey.photo)
        coder.encode(rating, forKey: PropertyKey.rating)
    }
    
    // デコード処理。
    // required init = サブクラスが独自のinitを定義した場合、この初期化を全てのサブクラスに実装する必要があるという意味合いを持つ
    required convenience init?(coder: NSCoder) {
        
        // 各値をデコードして定数化
        guard let name = coder.decodeObject(forKey: PropertyKey.name) as? String
        else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let photo = coder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = coder.decodeInteger(forKey: PropertyKey.rating)
        
        //　初期化必須
        self.init(name: name, photo: photo, rating: rating)
    }
    
    
}
