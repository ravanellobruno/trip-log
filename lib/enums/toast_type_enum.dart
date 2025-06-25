import 'package:flutter/material.dart';

enum ToastTypeEnum { success, error, info }

extension ToastTypeEnumExtension on ToastTypeEnum {
  Color get color {
    switch (this) {
      case ToastTypeEnum.success:
        return Colors.green;
      case ToastTypeEnum.error:
        return Colors.red;
      case ToastTypeEnum.info:
        return Colors.blue;
    }
  }
}
