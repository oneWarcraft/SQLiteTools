//
//  student.swift
//  SQLiteTools
//
//  Created by 王继伟 on 16/7/17.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit


class Student: NSObject {
    var name : String = ""
    var age : Int = 0
}

extension Student {
    
    func insertIntoDB() {
        // 1.拼接插入语句
        let inserSQL = "INSERT INTO t_student (name, age) values('\(name)', \(age));"
        
        // 2.执行sql语句
        SQLiteManager.shareInstance.execSQL(inserSQL)
     }
    
}


