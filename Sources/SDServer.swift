//
//  SDServer.swift
//  PerfectTemplate
//
//  Created by zhengzw on 2016/11/24.
//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer


class SDServer {
    // 创建 HTTP server.
    let server :HTTPServer = HTTPServer()
    
    init() {
        // 监听8188端口
        server.serverPort = 8188
        server.documentRoot = "./webroot"
        configureServer(server)
        //登陆
        server.addRoutes(LoginRoutes.create())
        //注册
        server.addRoutes(RegisterRoutes.create())

        var routes = Routes()
        routes.add(method: .get, uri: "", handler: {
            request, response in
            response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world4444!</body></html>")
            response.completed()
        }
        )
        server.addRoutes(routes)
    }
    func startup() throws -> Void{
            // 启动HTTP服务器
        try server.start()
    }
    
}
