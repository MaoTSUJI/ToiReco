//
//  addNewViewController.swift
//  ToiReco
//
//  Created by 辻真緒 on 2019/08/04.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var textPlaceField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    
    var toireco: Todo? = nil
    
    let types = ["排尿","排便"]
    var selectType = "排尿"
    var logDate:Date = Date()
    var place = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if toireco != nil {
            textPlaceField.text = toireco?.place
            // ボタン追加してから
            button.setTitle("更新", for: .normal)
        }
        
    }

    // 保存ボタン
    @IBAction func didClickLog(_ sender: UIButton) {
        // インスタンス化　
        let toirecoService = ToiRecoService()

        if let place = textPlaceField.text {
            if toireco == nil {
                toirecoService.create(logDate: logDate, place: place, type: selectType)
            } else {
                toirecoService.update(id: toireco!.id, newLogDate:logDate ,newPlace: place, newType: selectType)
            }
            
            navigationController?.popViewController(animated: true)
        } else {
            print("場所が入力されていません")
        }

    }
    
    // 日付
    @IBAction func didChangeDate(_ sender: UIDatePicker) {
        // DatePickerが変更された時の処理
        logDate = sender.date
        print("logDate: \(logDate)")
        
    }
    
}

extension AddNewViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // PickerViewの列数を設定する
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // PickerViewの行数を設定する
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    // PickerViewに表示する内容を設定する
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    
    // PickerViewが選択された時の、選択値を出力する
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectType = types[row]
        print("selectType: \(selectType)")
    }
    
    
}
