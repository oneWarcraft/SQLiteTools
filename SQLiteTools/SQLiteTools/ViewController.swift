//
//  ViewController.swift
//  SQLiteTools
//
//  Created by 王继伟 on 16/7/17.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var status : [Student] = {
       
        var tempArray = [Student]()
        
        for i in 0..<100000
        {
            let stu = Student()
            stu.name = "sophia\(arc4random_uniform(100))"
            stu.age = 20 + Int(arc4random_uniform(10))
            tempArray.append(stu)
        }
        
        return tempArray
    }()
    
    
    
    var db : COpaquePointer = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openDatabase()
    }
}

// MARK:- 打开已经存在的或者创建新数据库
extension ViewController {
    func openDatabase() {
        // 1.打开数据库方法
        let flag = SQLiteManager.shareInstance.openDB("/Users/wangjiwei/Desktop/sophia.sqlite")
        print(flag)
    }
}

// MARK:- 创建/删除 数据库表  --- DDL语句操作
extension ViewController {
    
    //
    @IBAction func createTableClick_BTN(sender: AnyObject) {
        // 1.获取创建表的语句
        let createTableSQL = "CREATE TABLE IF NOT EXISTS t_student (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER);"

        // 2.将该语句进行执行
        SQLiteManager.shareInstance.execSQL(createTableSQL)

    }

    
    @IBAction func dropTableClick_BTN(sender: AnyObject) {
        // 1.获取删除表的语句
        let dropTableSQL = "DROP TABLE IF EXISTS t_student;"
        
        // 2.执行SQL语句
        SQLiteManager.shareInstance.execSQL(dropTableSQL)
    
    }
}

// MARK:- 插入/更新/删除数据  --- DML语句操作
extension ViewController {
    
    @IBAction func insertData(sender: AnyObject) {
        // 1.获取插入数据的SQL语句
        let insertSQL = "INSERT INTO t_student (name, age) VALUES ('wjw', 18);"
        
        // 2.执行语句
        SQLiteManager.shareInstance.execSQL(insertSQL)
    }
    
    
    @IBAction func updateData() {
        // 1.获取更新数据的SQL语句
        let updateSQL = "UPDATE t_student SET name = 'sophia', age = 23 where name = 'wjw';"
        
        // 2.执行语句
        SQLiteManager.shareInstance.execSQL(updateSQL)
    }
    
    
    @IBAction func deleteData() {
        // 1.获取删除数据的SQL语句
        let deleteSQL = "DELETE FROM t_student;"
        
        // 2.执行语句
        SQLiteManager.shareInstance.execSQL(deleteSQL)
    }
    
//    //插入10万条对象数据
//    @IBAction func InsertObjectsData()
//    {
//        
//        let startTime = CACurrentMediaTime()
//        
//        for stu in self.status {
//            stu.insertIntoDB()
//        }
//        
//        let endTime = CACurrentMediaTime()
//        
//        print(endTime - startTime)
//        
//    }

    //插入10条对象数据 - 提交事务方式
    @IBAction func InsertObjectsData()
    {
        dispatch_async(dispatch_get_global_queue(0, 0))
        {
            let startTime = CACurrentMediaTime()
            
            // 1.开启事务
            SQLiteManager.shareInstance.beginTransaction()
            
            // 2.插入数据
            for (_, stu) in self.status.enumerate() {
                stu.insertIntoDB()
            }
            
            // 3.提交事务
            SQLiteManager.shareInstance.commitTransaction()
            
            let endTime = CACurrentMediaTime()
            
            print(endTime - startTime)
        }
        
    }
}

// MARK:- DQL语句操作
extension ViewController {
        // 1.定义游标
    @IBAction func queryData() {
        // 1.获取查询的语句
        let querySQL = "SELECT * FROM t_student LIMIT 0, 30;"
        
        // 2.执行查询语句
        let resultArray = SQLiteManager.shareInstance.queryData(querySQL)
        
        // 3.将字典转成模型对象
        var tempArray = [Student]()
        
        for dict in resultArray {
            tempArray.append(Student(dict: dict))
        }
        
        print(tempArray)
        
    }

    
}
























