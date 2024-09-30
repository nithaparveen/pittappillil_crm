import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config/app_config.dart';
import '../constants/colors.dart';
import '../constants/textstyles.dart';

class AppUtils {
  static Future<String?> getToken() async {
     log("getUserToken()");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(AppConfig.token);
    log("getUserToken -> $token");
    return token;
  }

  static oneTimeSnackBar(
      String? message, {
        int time = 2,
        Color? bgColor,
        TextStyle? textStyle,
        required BuildContext context,
        bool showOnTop = false,
      }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ///To CLEAR PREVIOUS SNACK BARS
    return ScaffoldMessenger.of(context)
    // ScaffoldMessenger.of(context??Routes.router.routerDelegate.navigatorKey.currentState!.context)
        .showSnackBar(
      SnackBar(
        /*action:SnackBarAction(label: "Ok",
        onPressed: (){
          SystemSettings.internalStorage();
        },
        ) ,*/

        behavior: showOnTop ? SnackBarBehavior.floating : null,
        backgroundColor: bgColor ?? Colors.white60,
        content: Text(message!,
            style:
            textStyle ?? GLTextStyles.cabinStyle(color: ColorTheme.white , weight: FontWeight.w500,size: 14)),
        duration: Duration(seconds: time),
        margin: showOnTop
            ? EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20)
            : null,
      ),
    );
  }
}
