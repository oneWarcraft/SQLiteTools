//
//  ViewController.swift
//  SQLiteTools
//
//  Created by 王继伟 on 16/7/17.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var db : COpaquePointer = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.打开数据库方法
        let flag = SQLiteManager.shareInstance.openDB("/Users/wangjiwei/Desktop/wjw.sqlite")
        print(flag)
    }
}

// MARK:- DDL语句操作
extension ViewController {
    
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




