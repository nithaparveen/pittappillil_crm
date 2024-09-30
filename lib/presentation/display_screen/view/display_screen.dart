import 'package:flutter/material.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';
import 'package:pittappillil_crm/global_widgets/logout_button.dart';
import 'package:pittappillil_crm/presentation/display_screen/view/widgets/add_product_screen.dart';
import 'package:pittappillil_crm/presentation/display_screen/view/widgets/display_list_screen.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen>
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
                child: Text("ADD PRODUCT",
                    style: GLTextStyles.interStyle(
                        size: 13,
                        color: ColorTheme.pRed,
                        weight: FontWeight.w400))),
            Tab(
                child: Text("DISPLAY LIST",
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
          AddProductScreen(),
          DisplayListScreen(),
        ],
      ),
    );
  }
}
