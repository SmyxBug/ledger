import 'package:flutter/material.dart';

class UserPrividerModel with ChangeNotifier {
  String _userId;
  String _nickName;
  get userId => _userId;
  get nickName => _nickName;

  void update(String userId, String nickName) {
    this._userId = userId;
    this._nickName = nickName;
    notifyListeners();
  }
}
