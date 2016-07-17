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


// MARK:- 事务相关的操作
extension SQLiteManager {
    func beginTransaction() {
        // 1.开启事务的语句
        let beginTransaction = "BEGIN TRANSACTION"
        
        // 2.执行
        execSQL(beginTransaction)
    }
    
    func commitTransaction() {
        // 1.提交事务的语句
        let commitTransaction = "COMMIT TRANSACTION"
        
        // 2.执行
        execSQL(commitTransaction)
    }
    
    func rollbackTransaction() {
        // 1.回滚事务的语句
        let rollbackTransaction = "ROLLBACK TRANSACTION"
        
        // 2.执行
        execSQL(rollbackTransaction)
    }
    
}

// MARK:- 查询数据操作
extension SQLiteManager {
    func queryData(querySQLString : String) -> [[String : NSObject]] {
        // 0.将querySQLString转成C语言字符串
        
        let cQuerySQLString = querySQLString.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        // 1.定义游标(指针)
        var stmt : COpaquePointer = nil
        
        // 2.准备查询,并且给游标赋值
        sqlite3_prepare_v2(db, cQuerySQLString, -1, &stmt, nil)
        
        // 3.开始查询
        // 3.1.取出列数
        let count = sqlite3_column_count(stmt)
        
        // 3.2.定义数组
        var tempArray = [[String : NSObject]]()
        
        // 3.3.查询数据
        while sqlite3_step(stmt) == SQLITE_ROW {
            
            // 遍历所有的键值对
            var dict = [String : NSObject]()
            for i in 0..<count {
                let cKey = sqlite3_column_name(stmt, i)
                let key = String(CString: cKey, encoding: NSUTF8StringEncoding)!
                let cValue = UnsafePointer<Int8>(sqlite3_column_text(stmt, i))
                let value = String(CString: cValue, encoding: NSUTF8StringEncoding)
                
                dict[key] = value
            }
            // 将字典放入到数组中
            tempArray.append(dict)
        }
        return tempArray
    }
}
































