import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pittappillil_crm/app_config/app_config.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';
import 'package:pittappillil_crm/global_widgets/elevated_button.dart';
import 'package:pittappillil_crm/presentation/login_screen/view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon:
          const Icon(Icons.logout_outlined, size: 20, color: Color(0xff9c9c9c)),
      onPressed: () => _showLogoutConfirmation(context),
    );
  }

  Future<void> _logout(BuildContext context) async {
    log("Logout");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(AppConfig.token);
    await sharedPreferences.setBool(AppConfig.loggedIn, false);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: Text(
            'Confirm Logout',
            style: GLTextStyles.montserratStyle(
              color: ColorTheme.pRedOrange,
              size: 16,
              weight: FontWeight.w500,
            ),
          ),
          content: Text(
            'Are you sure you want to log out?',
            style: GLTextStyles.montserratStyle(
              color: ColorTheme.pBlue,
              size: 14,
              weight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            CustomButton(
              borderColor: ColorTheme.pRedOrange,
              backgroundColor: ColorTheme.white,
              text: "Cancel",
              textColor: ColorTheme.pRedOrange,
              onPressed: () => Navigator.of(context).pop(),
            ),
            CustomButton(
              borderColor: ColorTheme.white,
              backgroundColor: ColorTheme.pRedOrange,
              text: "Confirm",
              textColor: Colors.white,
              onPressed: () async {
                Navigator.of(context).pop();
                await _logout(context);
              },
            ),
          ],
        );
      },
    );
  }
}
