import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';
import 'package:pittappillil_crm/global_widgets/elevated_button.dart';
import 'package:pittappillil_crm/presentation/inventory_screen/view/widgets/add_invoice_screen.dart';
import 'package:pittappillil_crm/presentation/inventory_screen/view/widgets/inventory_list_screen.dart';
import 'package:pittappillil_crm/presentation/login_screen/view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_config/app_config.dart';
import 'widgets/inventory_list_screen_copy.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: SizedBox(
            height: 15, width: 20, child: Image.asset("assets/logo2.png")),
        title: Text(
          "PACE-X !",
          style: GLTextStyles.montserratStyle(
            size: 32,
            weight: FontWeight.w700,
            color: ColorTheme.pink,
            // height: 68 / 39,
            letterSpacing: -0.3,
          ),
          textAlign: TextAlign.left,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              size: 20,
              color: Colors.black,
            ),
            onPressed: () => logoutConfirmation(),
          ),
        ],
        centerTitle: true,
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: tabController,
          labelColor: ColorTheme.pRed,
          indicatorColor: ColorTheme.pRed,
          indicatorWeight: 1,
          tabs: [
            Tab(
                child: Text("ADD INVOICE",
                    style: GLTextStyles.interStyle(
                        size: 13,
                        color: ColorTheme.pRed,
                        weight: FontWeight.w400))),
            Tab(
                child: Text("INVENTORY LIST",
                    style: GLTextStyles.interStyle(
                        size: 13,
                        color: ColorTheme.pRed,
                        weight: FontWeight.w400))),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          AddInvoiceScreen(),
          InventoryListScreenV2(),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    log("Logout");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(AppConfig.token);
    sharedPreferences.setBool(AppConfig.loggedIn, false);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }

  void logoutConfirmation() {
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
                weight: FontWeight.w500),
          ),
          content: Text('Are you sure you want to log out?',
              style: GLTextStyles.montserratStyle(
                  color: ColorTheme.pBlue, size: 14, weight: FontWeight.w400)),
          actions: <Widget>[
            CustomButton(
              borderColor: ColorTheme.pRed,
              backgroundColor: ColorTheme.white,
              text: "Cancel",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CustomButton(
              borderColor: ColorTheme.white,
              backgroundColor: ColorTheme.pRed,
              text: "Confirm",
              textColor: Colors.white,
              onPressed: () async {
                Navigator.of(context).pop();
                await logout(context);
              },
            ),
          ],
        );
      },
    );
  }
}