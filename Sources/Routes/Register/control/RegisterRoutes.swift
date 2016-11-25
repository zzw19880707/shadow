//
//  RegisterRo.swift
//  PerfectTemplate
//
//  Created by zhengzw on 2016/11/24.
//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import Foundation
class RegisterRoutes {
    class func create() -> Routes {
        var routes = Routes(baseUri: "register")
        routes.add(method: .post , uri: "", handler: {
            request, response in
            //设置编码集
            response.setHeader(.contentType, value: "text/html; charset=UTF-8")
            //接收参数
            let username = request.param(name: "username")
            let password = request.param(name: "password")?.md5()
            if let u = username, let p = password {
                print("username :" + u + "password :" + p)
                let user = UserModel(userId: 0, username: u, password: p, createTime: "\(NSDate())" )
                let result = LoginDBManager().insert(user: user)
                if result {
                    response.setBody(string:try!  ["msg":"成功","code":code.success.rawValue].jsonEncodedString())
                }else {
                    response.setBody(string: try!   ["msg":"用户名重复","code":code.用户名重复.rawValue].jsonEncodedString())
                }
            }else{
                Log.warning(message: "用户名密码未输入 ")
                response.setBody(string: try!  ["msg":"用户名密码为空","code":code.用户名密码为空.rawValue].jsonEncodedString())
            }
            response.completed()
        })
        return routes
    }
    
}
