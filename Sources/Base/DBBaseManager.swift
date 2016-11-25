//
//  DBBaseManager.swift
//  PerfectTemplate
//
//  Created by zhengzw on 2016/11/23.
//
//

import PerfectLib
import PerfectHTTP
import MySQL

let testHost = "127.0.0.1"
let testUser = "root"
let testPassword = ""
let testDB = "test"

class DBBaseManager {
    // 创建一个MySQL连接实例
    let dataMysql = MySQL()
    func openDB() -> Bool {
        
        
        let connected = dataMysql.connect(host: testHost, user: testUser, password: testPassword, db: testDB)
        
        guard connected else {
            // 验证一下连接是否成功
            Log.info(message: dataMysql.errorMessage())
            return false
        }
        
        return true




    }
    
    func createTable() -> Void {
        guard self.openDB() else{
            Log.info(message: "数据库打开失败")
            return 
        }
        defer {
            dataMysql.close() //这个延后操作能够保证在程序结束时无论什么结果都会自动关闭数据库连接
        }
        // 创建表格
        let querySuccess_create = dataMysql.query(statement: "CREATE TABLE user ("
            + "id INT(11) NOT NULL AUTO_INCREMENT,"
            + "username VARCHAR(100) NOT NULL unique,"
            + "password VARCHAR(100) NOT NULL,"
            + "createTime VARCHAR(100) NOT NULL,"
            + "PRIMARY KEY (id)"
            + ") ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;"
        )
        guard querySuccess_create  else{
            Log.info(message: "建表失败")
                return
        }
        Log.info(message: "建表成功")
    }
}
