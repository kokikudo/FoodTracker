//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by kudo koki on 2021/03/31.
//

// 各メソッドを単体でテストするためのファイル
// File - Target - iosタグのiosUnitTestingBundleから作成できる
// プロジェクト新規作成時にinclude Unit Tests にチェックを入れると自動で作成できる

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {

    // Mealクラス初期化のテスト
    
    //初期化成功。
    func testMealInitializationSucceeds() {
        // 評価が0と満点の場合の2種類のケースでテスト
        // 0
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal) // オブジェクトがnilでないか確認
        
        // 満点
        let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    //初期化失敗。
    func testMealInitializationFails() {
        
        // 評価が-1の場合
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal) // オブジェクトがnilか確認
        
        // 評価が最大値を超える場合
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
        
        // 名前が空の場合
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
    }
}
