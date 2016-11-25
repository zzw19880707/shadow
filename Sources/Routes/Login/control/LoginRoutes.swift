//
//  Login.swift
//  PerfectTemplate
//
//  Created by zhengzw on 2016/11/24.
//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer// Register your own routes and handlers
import Foundation
class LoginRoutes {
    class func create() -> Routes {
        var routes = Routes(baseUri: "login")
        routes.add(method: .post, uri: "", handler: {
            request, response in
            //设置编码集
            response.setHeader(.contentType, value: "text/html; charset=UTF-8")
            //接收参数
            let username = request.param(name: "username")
            let password = request.param(name: "password")?.md5()
            if let u = username, let p = password {
                print("username :" + u + "password :" + p)
                let user = UserModel(userId: 0, username: u, password: p, createTime: "\(NSDate())" )
                let result = LoginDBManager().select(user: user)
                if result {
                    response.setBody(string:try!  ["msg":"登陆成功","code":code.success.rawValue].jsonEncodedString())
                }else {
                    response.setBody(string: try!  ["msg":"用户名或密码错误","code":code.用户名或密码错误.rawValue].jsonEncodedString())
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
//routes.add(method: .get, uri: "/", handler: {
//    request, response in
//    response.setHeader(.contentType, value: "text/html")
//    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
//    response.completed()
//}
//)
//routes.add(method: .get, uri: "/hello", handler: {
//    request, response in
//    //接收参数
//    let test = request.param(name: "test")!
//    print(test);
//    response.setHeader(.contentType, value: "text/html")
//    response.appendBody(string: "hello " + test)
//    //    response.completed()
//    //插入数据库
//    DBBaseManager().inserData(request, response: response)
//})
//
//
//routes.add(method: .post, uri: "/post", handler:{
//    request, response in
//    //    response.setHeader("contentType", "text/html; charset=utf-8”);
//    let test = request.param(name: "test")!
//    response.setHeader(.contentType, value: "text/html")
//    response.appendBody(string: "hello " + test)
//    response.completed()
//}
//)
