//
//  ToiReco.swift
//  ToiReco
//
//  Created by 辻真緒 on 2019/08/04.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import RealmSwift
// オブジェクトを継承したTodoクラスを作成
class Todo: Object {
    // ID （連番）
    @objc dynamic var id: Int = 0
    // 記録したい日時
    @objc dynamic var logDate: Date = Date()
    // 場所
    @objc dynamic var place: String = ""
    // 種類
    @objc dynamic var type: String = ""
    // nilを許容したくないから、?は取り除いた
    // 登録日時
    @objc dynamic var date:Date = Date()
    
}
