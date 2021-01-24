import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ledger/page/index.dart';
import 'package:ledger/provider/user_provider.dart';
import 'package:ledger/router/appliication.dart';
import 'package:ledger/router/routers.dart';
import 'package:ledger/utils/http.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

class AppInit {
  static void run() async {
    WidgetsFlutterBinding.ensureInitialized(); // provider状态管理配置
    await SpUtil.getInstance(); // 本地存储实例对象加载
    final userProvider = UserPrividerModel();
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: userProvider),
      ],
      child: MyApp(),
    ));
    XHttp.init(); // 初始化http请求
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 路由配置
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
    return MaterialApp(
      title: '沐瑶纪',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // 路由配置
      onGenerateRoute: Application.router.generator,
      home: Index(),
    );
  }
}
