//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by kudo koki on 2021/03/31.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    // プロパティ
    var meals = [Meal]() // TableViewで表示するのでリストで返す
    
    // 追加した料理データをテーブルビューに反映
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
        // segueのソースをMealViewControllerにダウンキャストし、追加した料理データを定数に格納
        if let sourceViewController = sender.source as? MealViewController,
           let meal = sourceViewController.meal {
            
            // 保存時に編集か新規作成かを判断する
            // 編集の場合はインデックスパスが存在しているのでリストからタップされたことがわかる
            // インデックスパスがない場合は新規登録
            // 編集の場合は変更したデータを反映させ、新規登録の場合は追加する
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
           
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 左上にEditボタンを設置
        navigationItem.leftBarButtonItem = editButtonItem

        // サンプルデータをロード
        loadSampleMeals()
    }

    // MARK: - Table view data source

    // セクション（セルをまとめたもの）の数を指定。今回はセルを一覧表示するだけなので1でOK。
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // セルの数を指定。料理の数の分だけ表示
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }

    // セルを生成
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルIDを指定してセルを作成。
        // カスタムセルサブクラスMealTableViewCellにダウンキャスト。失敗したらfatalError(エラー文を表示しアプリを落とす)。
        let cellIdentifier = "MealTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // meals配列から適切な料理を取得
        let meal = meals[indexPath.row]
        
        // セルに各オブジェクトの値を代入
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        // セルを返す
        return cell
    }
    

    
    // 編集をサポートするためにオーバーライドされた関数
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // エディットモードの各処理
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // meals内のデータとインデックスを削除
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // segueのIdentifierによって処理を変える
        switch segue.identifier ?? "" {
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        // 編集の場合
        case "ShowDetail":
            
            // 宛先をビューコントローラに設定
            guard let mealDetailViewController = segue.destination as? MealViewController
            else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            // セルを取得
            guard let selectedMealCell = sender as? MealTableViewCell
            else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            // インデックスパスを取得
            guard let indexPath = tableView.indexPath(for: selectedMealCell)
            else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            // タップされた料理データを取得
            let selectedModel = meals[indexPath.row]
            mealDetailViewController.meal = selectedModel
        
        default:
            fatalError("Unecpected Seque Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
    // サンプルデータをアプリに読み込むためのヘルパーメソッド
    private func loadSampleMeals() {
        
        //　アセットカタログから画像をロード
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        // インスタンス化。失敗するとエラーになる処理
        guard let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5) else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3) else {
            fatalError("Unable to instantiate meal3")
        }
        
        // mealsに追加
        meals += [meal1, meal2, meal3]
    }
}
