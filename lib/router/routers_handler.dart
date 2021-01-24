import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:ledger/page/index.dart';

// 首页
Handler indexHanderl = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return Index();
  },
);
