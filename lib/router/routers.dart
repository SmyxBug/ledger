import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:ledger/router/routers_handler.dart';

class Routes {
  static String index = '/index';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = new Handler(
      // ignore: missing_return
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('>>>>>>>>>>>>>>>>>>>>>>>>>> 找不到路由，404'); // 找不到路由，跳转404页面
      },
    );

    // 路由页面配置
    router.define(index, handler: indexHanderl); // 首页
    
  }
}
