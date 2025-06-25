import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../enums/toast_type_enum.dart';

class ToastUtils {
  static void showToast(String msg, ToastTypeEnum type) {
    Color color = type.color;
    Fluttertoast.cancel();

    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16,
    );
  }
}
