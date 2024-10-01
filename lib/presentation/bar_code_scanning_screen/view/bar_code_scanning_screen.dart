import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';
import 'package:pittappillil_crm/global_widgets/elevated_button.dart';
import 'package:pittappillil_crm/global_widgets/textfield.dart';
import 'package:pittappillil_crm/presentation/bar_code_scanning_screen/controller/scan_screen_controller.dart';

class BarcodeScanScreen extends StatefulWidget {
  const BarcodeScanScreen({super.key});

  @override
  State<BarcodeScanScreen> createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends State<BarcodeScanScreen> {
  TextEditingController indoorController = TextEditingController();
  TextEditingController outdoorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScanScreenController>().fetchData(context);
    });
  }

  @override
  void dispose() {
    indoorController.dispose();
    outdoorController.dispose();
    super.dispose();
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
            Consumer<ScanScreenController>(
              builder: (context, controller, _) {
                return Padding(
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
                            Column(
                              children: [
                                CustomTextField(
                                  width: 307.0,
                                  height: 45.0,
                                  hintText: "Select Product",
                                  prefixIcon: const Icon(Icons.shopping_bag,
                                      size: 18, color: Color(0xff9c9c9c)),
                                  suffixIcon: const Icon(
                                      Icons.manage_search_rounded,
                                      size: 19,
                                      color: Color(0xff9c9c9c)),
                                  controller: controller.searchController,
                                  onChanged: (value) {
                                    controller.searchProducts(value);
                                  },
                                ),
                                if (controller.isListVisible)
                                  Container(
                                    width: 307.0,
                                    constraints:
                                        const BoxConstraints(maxHeight: 180),
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
                                              color: const Color.fromARGB(
                                                  255, 131, 131, 131),
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
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              width: 307.0,
                              height: 45.0,
                              hintText: "Barcode Indoor",
                              prefixIcon: const Icon(
                                  Icons.qr_code_scanner_outlined,
                                  size: 18,
                                  color: Color(0xff9c9c9c)),
                              readOnly: true,
                              controller: indoorController,
                              onTap: () {
                                openBarcodeScanner(
                                    controller: indoorController);
                              },
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              width: 307.0,
                              height: 45.0,
                              hintText: "Barcode Outdoor",
                              prefixIcon: const Icon(
                                  Icons.qr_code_scanner_outlined,
                                  size: 18,
                                  color: Color(0xff9c9c9c)),
                              readOnly: true,
                              controller: outdoorController,
                              onTap: () {
                                openBarcodeScanner(
                                    controller: outdoorController);
                              },
                            ),
                            const SizedBox(height: 10),
                            const CustomTextField(
                              width: 307.0,
                              height: 45.0,
                              hintText: "Remarks",
                              prefixIcon: Icon(Icons.sticky_note_2_rounded,
                                  size: 18, color: Color(0xff9c9c9c)),
                            ),
                            const SizedBox(height: 10),
                            CustomButton(
                              width: 307.0,
                              height: 48.0,
                              text: "Submit",
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              backgroundColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void openBarcodeScanner({required TextEditingController controller}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: 300,
          height: 300,
          child: MobileScanner(
            onDetect: (BarcodeCapture capture) {
              final String? code = capture.barcodes.first.rawValue;
              if (code != null) {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
                if (mounted) {
                  setState(() {
                    controller.text = code;
                  });
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
