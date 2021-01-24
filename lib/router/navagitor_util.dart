import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:ledger/router/appliication.dart';
import 'package:ledger/router/routers.dart';

class NavigatorUtil {
  // 返回 其实这边调用的是 Navigator.pop(context);
  static void goBack(BuildContext context) {
    Application.router.pop(context);
  }

  // 带参数的返回
  static void goBackWithParams(BuildContext context, result) {
    Navigator.pop(context, result);
  }

  // 路由返回指定页面
  static void goBackSpecifyPage(BuildContext context, String routeName) {
    Navigator.popAndPushNamed(context, routeName);
  }

  // 跳转到主页面
  static void goIndex(BuildContext context) {
    Application.router.navigateTo(context, Routes.index,
        replace: true, transition: TransitionType.inFromLeft);
  }

  // 框架自带的有 native，nativeModal，inFromLeft，inFromRight，inFromBottom，fadeIn，custom
  static Future jumpLeft(BuildContext context, String routeName) {
    return Application.router
        .navigateTo(context, routeName, transition: TransitionType.inFromLeft);
  }

  // 框架自带的有 native，nativeModal，inFromLeft，inFromRight，inFromBottom，fadeIn，custom
  static Future jumpRight(BuildContext context, String routeName) {
    return Application.router
        .navigateTo(context, routeName, transition: TransitionType.inFromRight);
  }

  static Future jumpRightWithRemoveAllRoute(
      BuildContext context, String routeName) {
    return Application.router.navigateTo(context, routeName,
        transition: TransitionType.inFromRight, clearStack: true);
  }

  // 跳转到主页面并删除所有路由
  static void goToNewIndexRemoveAllRoute(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/newIndex', (route) => route == null);
  }

  // 跳转到登录页面并销毁除了首页(newIndexPage)的所有路由
  static void removeAllRouteWithOutNewIndex(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', ModalRoute.withName('/newIndex'));
  }

  // 自定义 转场动画
  static Future goTransitionCustom(BuildContext context, String routeName) {
    var transition = (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return new ScaleTransition(
        scale: animation,
        child: new RotationTransition(
          turns: animation,
          child: child,
        ),
      );
    };
    return Application.router.navigateTo(context, routeName,
        transition: TransitionType.custom,
        transitionBuilder: transition, // 指定是自定义动画
        transitionDuration: const Duration(milliseconds: 600)); // 自定义的动画
  }

  /// 使用 IOS 的 Cupertino 的转场动画，这个是修改了源码的 转场动画 Fluro本身不带，但是 Flutter自带
  static Future goTransitionIOSCupertino(
      BuildContext context, String routeName) {
    return Application.router
        .navigateTo(context, routeName, transition: TransitionType.cupertino);
  }
}
