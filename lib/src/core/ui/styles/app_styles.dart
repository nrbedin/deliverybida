import 'package:flutter/material.dart';

import 'package:deliverydigital/src/core/ui/styles/colors_app.dart';
import 'package:deliverydigital/src/core/ui/styles/text_styles.dart';

class AppStyles {
  static AppStyles? _instance;

  AppStyles._();
  static AppStyles get instance {
    _instance ??= AppStyles._();
    return _instance!;
  }

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      //backgroundColor: ColorsApp.instance.primary,
      shadowColor: ColorsApp.instance.secondary,
      textStyle: TextStyles.instance.textButtonLabel);
}

extension AppStylesExtension on BuildContext {
  AppStyles get appStyles => AppStyles.instance;
}
