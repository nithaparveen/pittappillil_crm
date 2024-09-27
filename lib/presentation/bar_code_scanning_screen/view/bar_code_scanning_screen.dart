import 'package:flutter/material.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';
import 'package:pittappillil_crm/global_widgets/elevated_button.dart';
import 'package:pittappillil_crm/global_widgets/textfield.dart';
import 'package:pittappillil_crm/presentation/bar_code_scanning_screen/controller/scan_screen_controller.dart';
import 'package:provider/provider.dart';

class BarcodeScanScreen extends StatefulWidget {
  const BarcodeScanScreen({super.key});

  @override
  State<BarcodeScanScreen> createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends State<BarcodeScanScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScanScreenController>().fetchData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              left: -120,
              child: Transform.rotate(
                angle: -150,
                child: Container(
                  height: 70,
                  width: 280,
                  decoration: const BoxDecoration(
                    color: Color(0xffffeaea),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(90),
                      bottomRight: Radius.circular(90),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 35,
              left: 22,
              child: Container(
                height: 65,
                width: 58,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/logo2.png"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 200),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Brand and Category",
                          style: GLTextStyles.montserratStyle(
                              size: 15,
                              weight: FontWeight.w600,
                              color: ColorTheme.pBlue),
                        ),
                        const SizedBox(height: 18),
                        Consumer<ScanScreenController>(
                          builder: (context, controller, _) {
                            return Column(
                              children: [
                                CustomTextField(
                                  width: 307.0,
                                  height: 45.0,
                                  hintText: "Select Product",
                                  prefixIcon: const Icon(Icons.shopping_bag,
                                      size: 18, color: Color(0xff9c9c9c)),
                                  suffixIcon: const Icon(Icons.manage_search_rounded,
                                      size: 19, color: Color(0xff9c9c9c)),
                                  controller: controller.searchController,
                                  onChanged: (value) {
                                    controller.searchProducts(value);
                                  },
                                ),
                                if (controller.isListVisible)
                                  Container(
                                    width: 307.0,
                                    constraints: const BoxConstraints(maxHeight: 180),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          controller.filteredProductList.length,
                                      itemBuilder: (context, index) {
                                        final product = controller
                                            .filteredProductList[index];
                                        return ListTile(
                                          title: Text(
                                            product.productName ?? '',
                                            style: GLTextStyles.montserratStyle(
                                              weight: FontWeight.w500,
                                              size: 13,
                                              color: const Color.fromARGB(255, 131, 131, 131),
                                            ),
                                          ),
                                          subtitle: Text(
                                            product.category?.name ?? '',
                                            style: GLTextStyles.montserratStyle(
                                              weight: FontWeight.w400,
                                              size: 12,
                                              color: const Color(0xff9c9c9c),
                                            ),
                                          ),
                                          onTap: () {
                                            controller.selectProduct(product);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        const CustomTextField(
                          width: 307.0,
                          height: 45.0,
                          hintText: "Barcode Indoor",
                          prefixIcon: Icon(Icons.qr_code_scanner_outlined,
                              size: 18, color: Color(0xff9c9c9c)),
                        ),
                        const SizedBox(height: 10),
                        const CustomTextField(
                          width: 307.0,
                          height: 45.0,
                          hintText: "Barcode Outdoor",
                          prefixIcon: Icon(Icons.qr_code_scanner_outlined,
                              size: 18, color: Color(0xff9c9c9c)),
                        ),
                        const SizedBox(height: 10),
                        const CustomTextField(
                          width: 307.0,
                          height: 45.0,
                          hintText: "Remarks",
                          prefixIcon: Icon(Icons.category_sharp,
                              size: 18, color: Color(0xff9c9c9c)),
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          width: 307.0,
                          height: 48.0,
                          text: "Submit",
                          onPressed: () {},
                          backgroundColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
