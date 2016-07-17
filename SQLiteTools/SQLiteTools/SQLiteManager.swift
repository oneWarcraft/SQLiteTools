//
//  SQLiteManager.swift
//  SQLiteTools
//
//  Created by 王继伟 on 16/7/17.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import Foundation

class SQLiteManager: NSObject {
    // 将类设计成单例对象
    static let shareInstance : SQLiteManager = SQLiteManager()
    
    // MARK:- 定义数据库对象
    var db : COpaquePointer = nil
}

// MARK:- 打开数据库的操作
extension SQLiteManager {
    func openDB(dbPath : String) -> Bool {
        // 1.获取C语言字符串路径
        let cDBPath = dbPath.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        // 2.打开数据库
        return sqlite3_open(cDBPath, &db) == SQLITE_OK
    }
}

// MARK:- 执行SQL语句的操作
extension SQLiteManager {
    func execSQL(sqlString : String) -> Bool {
        // 1.将sqlString转成C语言字符串
        
        let cSQLString = sqlString.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        // 2.执行SQL语句
        return sqlite3_exec(db, cSQLString, nil, nil, nil) == SQLITE_OK
    }
}










