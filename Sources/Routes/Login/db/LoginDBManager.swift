//
//  LoginDBManager.swift
//  PerfectTemplate
//
//  Created by zhengzw on 2016/11/24.
//
//

import Foundation
import PerfectHTTP
import PerfectLib

class LoginDBManager: DBBaseManager {
    func insert(user : UserModel) ->  Bool {
        guard super.openDB() else{
            Log.info(message: "数据库打开失败")
            return false
        }
        defer {
            dataMysql.close() //这个延后操作能够保证在程序结束时无论什么结果都会自动关闭数据库连接
        }
        let sql = "INSERT INTO user VALUES ( 0 ,\(user.username), \(user.password),'\(user.createTime)')"
        Log.debug(message: sql)
        //插入数据
        let querySuccess_insert = dataMysql.query(statement: sql)

        guard querySuccess_insert  else{
            return false
        }
        
        return true
        
    }
    func select(user : UserModel) -> Bool {
        guard super.openDB() else{
            Log.info(message: "数据库打开失败")
            return false
        }
        defer {
            dataMysql.close() //这个延后操作能够保证在程序结束时无论什么结果都会自动关闭数据库连接
        }
        let sql = "select * from user where username = \(user.username) and password = \(user.password)"
        Log.debug(message: sql)
        //查询数据
        let querySuccess = dataMysql.query(statement:  sql)
        
        guard querySuccess  else{
            return false
        }
        
        // 在当前会话过程中保存查询结果
        let results = dataMysql.storeResults()! //因为上一步已经验证查询是成功的，因此这里我们认为结果记录集可以强制转换为期望的数据结果。当然您如果需要也可以用if-let来调整这一段代码。
        
        var ary = [[String:Any]]() //创建一个字典数组用于存储结果
        
        results.forEachRow { row in
            ary.append( ["\(row[0]!)" : row[0]!]) //保存到字典内
        }
        if(ary.count>0){
            return true
        }else{
            return false
        }
    }
    
}
