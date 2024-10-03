import 'package:flutter/material.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';
import 'package:pittappillil_crm/global_widgets/logout_button.dart';
import 'package:pittappillil_crm/presentation/inventory_screen/view/widgets/add_invoice_screen.dart';
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
          height: 15,
          width: 20,
          child: Image.asset("assets/logo2.png"),
        ),
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
        actions: const [LogoutButton()],
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
}
