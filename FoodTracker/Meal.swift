//
//  Meal.swift
//  FoodTracker
//
//  Created by kudo koki on 2021/03/31.
//

import UIKit

class Meal {
    
    // プロパティ 変更する可能性があるので変数
    var name: String
    var photo: UIImage?
    var rating: Int
    
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
}
