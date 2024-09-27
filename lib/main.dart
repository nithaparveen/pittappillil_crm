import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pittappillil_crm/app_config/app_config.dart';
import 'package:pittappillil_crm/presentation/bar_code_scanning_screen/controller/scan_screen_controller.dart';
import 'package:pittappillil_crm/presentation/bottom_navigation_screen/controller/bottom_navigation_controller.dart';
import 'package:pittappillil_crm/presentation/bottom_navigation_screen/view/bottom_navigation_screen.dart';
import 'package:pittappillil_crm/presentation/inventory_screen/controller/inventory_controller.dart';
import 'package:pittappillil_crm/presentation/login_screen/controller/login_controller.dart';
import 'package:pittappillil_crm/presentation/login_screen/view/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? loggedIn = prefs.getBool(AppConfig.loggedIn);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => BottomNavigationController()),
    ChangeNotifierProvider(create: (context) => LoginController()),
    ChangeNotifierProvider(create: (context) => InventoryListController()),
    ChangeNotifierProvider(create: (context) => ScanScreenController()),
  ], child: MyApp(isLoggedIn: loggedIn ?? false)));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 783), 
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLoggedIn ? const NavigationBarScreen() : const LoginScreen(),
      ),
    );
  }
}
