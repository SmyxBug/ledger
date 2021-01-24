class Validator {
  // 注册校验账户
  static checkAccount(value) {
    if (value.isEmpty) return false;
    // 只可以输入数字大小写字母以及部分特殊字符
    if (!isMatchReg(value)) return false;
    // 判断是邮箱还是手机号
    if (value.toString().indexOf("@") > -1) {
      return isEmial(value);
    } else {
      return isMobilePhone(value);
    }
  }

  // 校验手机号
  static isMobilePhone(value) {
    return RegExp(r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$").hasMatch(value);
  }

  // 校验邮箱
  static isEmial(value) {
    return RegExp(r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$").hasMatch(value);
  }

  // 数字大小写字母以及@ _ .特殊字符
  static isMatchReg(value) {
    return RegExp(r"^[a-zA-Z0-9@_.]+$").hasMatch(value);
  }

  // 判断字符串是否是数字
  static isNumeric(value) {
    try {
      double.parse(value);
      return true;
    } on FormatException {
      return false;
    }
  }

  // 校验密码 8-16位 数字+字母
  static checkPassword(value) {
    return RegExp(r"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$").hasMatch(value);
  }
}
