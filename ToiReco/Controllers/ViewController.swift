//
//  ViewController.swift
//  ToiReco
//
//  Created by 辻真緒 on 2019/08/04.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import UIKit
import RevealingSplashView

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // テーブルに表示するToireco の配列
    var toirecos: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // スプラッシュ
        //Initialize a revealing Splash with with the iconImage, the initial size and the background color
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "Logo_pink")!,iconInitialSize: CGSize(width: 70, height: 70), backgroundColor: UIColor(red:0.11, green:0.56, blue:0.95, alpha:1.0))
        
        revealingSplashView.animationType = SplashAnimationType.rotateOut
//        revealingSplashView.delay = 3.0
        
        //Adds the revealing splash view as a sub view
        self.view.addSubview(revealingSplashView)
        
        //Starts animation
        revealingSplashView.startAnimation(){
            print("Completed")
        }
        
        
    }
    
    // このページに来たら何回でも処理する
    override func viewWillAppear(_ animated: Bool) {
        // RealmにあるTodoを全件取得
        let toirecoService = ToiRecoService()
        toirecos = toirecoService.findAll()
        
        tableView.reloadData()
    }

    @IBAction func didClickAddNew(_ sender: UIButton) {
        performSegue(withIdentifier: "toAddNew", sender: nil)
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {

    // 行数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toirecos.count
    }
    // 中身を挿入
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // セルのタイトルにToirecoのタイトルを設定
        let toireco = toirecos[indexPath.row]
        
        // 日付の出力方法
        let date = toireco.logDate
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.string(from: date)
        // 入力データのまとめ
        let str = String(format: "%@に%@で%@した", formatter.string(from: date), toireco.place,toireco.type)
        // セルのテキストに、入力したデータのまとめを代入
        cell.textLabel?.text = str
        // セルに改行を許す
        cell.textLabel?.numberOfLines=0
        
        // セルに右矢印を追加する
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // セルクリック時の処理を追記する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let toireco = toirecos[indexPath.row]
        performSegue(withIdentifier: "toAddNew", sender: toireco)
        
        print("送る値:\(toireco)")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toAddNew" {
            let inputVC = segue.destination as! AddNewViewController
            inputVC.toireco = sender as? Todo
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // セルをスワイプし、Deleteが選ばれた場合、
            let id = toirecos[indexPath.row].id
            
            // Realmから該当のTodoを削除
            let toirecoService = ToiRecoService()
            toirecoService.delete(id: id)
            
            // 配列から削除
            toirecos.remove(at: indexPath.row)
            
            // 画面から削除
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
    }
    
    
}
