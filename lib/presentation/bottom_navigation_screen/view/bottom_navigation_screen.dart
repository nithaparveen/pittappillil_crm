import 'package:flutter/material.dart';
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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BottomNavigationController>(context, listen: false)
          .selectedIndex = 0;
    });
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
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.qr_code_scanner_outlined),
                  label: "Inventory Scanner"),
              BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner_outlined),
                label: "Display Scanner",
              ),
            ],
            onTap: (index) {
              controller.selectedIndex = index;
              setState(() {});
            },
            currentIndex: controller.selectedIndex,
            selectedItemColor: const Color(0xffcc0033),
            selectedLabelStyle: GLTextStyles.montserratStyle(
              weight: FontWeight.w500,
              size: 12,
            ),
            unselectedLabelStyle: GLTextStyles.montserratStyle(
              weight: FontWeight.w400,
              size: 12,
              color: const Color(0xff9c9c9c),
            ),
            iconSize: 22,
            backgroundColor: Colors.white,
          );
        },
      ),
    );
  }
}
