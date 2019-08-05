//
//  ToiRecoRepository.swift
//  ToiReco
//
//  Created by 辻真緒 on 2019/08/04.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import RealmSwift

class ToiRecoRepository {
    
    let realm = try! Realm()
    
    // ToiRecoを新規作成する
    func create(toireco: Todo) {
        
        // realmデータ確認用
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        try! realm.write {
            realm.add(toireco)
        }
    }
    
    // 最大IDを取得するメソッドを追記
    func getMaxId() -> Int {
        let realm = try! Realm()
        let maxId = (realm.objects(Todo.self).max(ofProperty: "id") as Int? ?? 0) + 1
        
        return maxId
    }
    
    // Toirecoのタスクを全件取得する
    func findAll() -> [Todo] {
        let toirecos = realm.objects(Todo.self)
        return toirecos.reversed()
    }
    
    // 更新メソッド
    func update(newToireco: Todo) {
        let realm = try! Realm()
        let toireco = findById(id: newToireco.id)
        
        try! realm.write {
            toireco?.logDate = newToireco.logDate
            toireco?.place = newToireco.place
            toireco?.type = newToireco.type
            toireco?.date = newToireco.date
        }
    }
    
    func findById(id: Int) -> Todo! {
        let realm = try! Realm()
        let toireco = realm.objects(Todo.self).filter("id = \(id)").first
        return toireco
    }
    
    func delete(id: Int) {
        let realm = try! Realm()
        let toireco = findById(id: id)
        
        try! realm.write {
            realm.delete(toireco!)
        }
        
    }
    
}
