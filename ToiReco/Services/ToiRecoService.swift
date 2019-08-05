//
//  ToiRecoService.swift
//  ToiReco
//
//  Created by 辻真緒 on 2019/08/04.
//  Copyright © 2019 辻真緒. All rights reserved.
//
import Foundation
import RealmSwift

class ToiRecoService {
    
    // toirecoのリポジトリ
    let repository = ToiRecoRepository()
    
    // ToiRecoを新規作成する
    func create(logDate: Date, place:String, type: String) {
        let toireco = Todo()
        let maxId = repository.getMaxId()
        
        toireco.id = maxId
        toireco.logDate = logDate
        toireco.place = place
        toireco.type = type
        toireco.date = Date()
        
        repository.create(toireco: toireco)
    }
    
    // Todoを全件取得する
    func findAll() -> [Todo] {
        return repository.findAll()
    }
    
    // 更新メソッド
    func update(id: Int, newLogDate:Date ,newPlace: String, newType: String) {
        let toireco = Todo()
        
        toireco.id = id
        toireco.logDate = newLogDate
        toireco.place = newPlace
        toireco.type = newType
        
        repository.update(newToireco: toireco)
        
    }
    
    func delete(id: Int) {
        repository.delete(id: id)
    }
    
}


