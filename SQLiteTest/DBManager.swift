//
//  DBManager.swift
//  SQLiteTest
//
//  Created by Nick Lin on 2018/1/31.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation
import SQLManager

let DBM = SQLiteManager(delegate: DBHelp())

final class DBHelp: NSObject, SQLDelegate {

    func tablePrimaryKey(table: String) -> String {
        return "id"
    }

    var SQLsyntaxs: [String] = []

    var dbPathName: String {
        return "/SQLiteTest.db"
    }

}

enum Todo {
    static let tableName = "todo"
    static let id = "id"

    static let title = "title"
    static let createTime = "createtime"
    static let isDone = "isdone"

    static func createTodoItem(with dic: [String: Any]) {
        DBM.instert(table: Todo.tableName, data: dic)
    }

    static func updateTodoItem(with dic: [String: Any]) {
        DBM.update(table: Todo.tableName, data: dic)
    }

    static func deleteTodoItem(with dic: [String: Any]) {
        DBM.delete(table: Todo.tableName, data: dic)
    }
}
