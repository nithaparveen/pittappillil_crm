import 'package:flutter/material.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';
import 'package:pittappillil_crm/presentation/display_screen/view/display_screen.dart';
import 'package:pittappillil_crm/presentation/inventory_screen/view/inventory_screen.dart';
import 'package:provider/provider.dart';
import '../controller/bottom_navigation_controller.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  @override
  void initState() {
    Provider.of<BottomNavigationController>(context, listen: false)
        .selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Consumer<BottomNavigationController>(
        builder: (context, provider, child) {
          return IndexedStack(
            index: provider.selectedIndex,
            children: const [
              InventoryScreen(),
              DisplayScreen(),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer<BottomNavigationController>(
        builder: (context, controller, _) {
          return BottomNavigationBar(
            backgroundColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.qr_code_scanner_outlined),
                  label: "Inventory Scanner"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.qr_code_scanner_outlined),
                  label: "Display Scanner"),
            ],
            onTap: (index) {
              controller.selectedIndex = index;
              setState(() {});
            },
            currentIndex: controller.selectedIndex,
            selectedItemColor: Color(0xffcc0033),
          );
        },
      ),
    );
  }
}
