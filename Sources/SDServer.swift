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

    }
    func startup() throws -> Void{
            // 启动HTTP服务器
        try server.start()
    }
    
}
