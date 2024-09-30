import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';
import 'package:pittappillil_crm/global_widgets/elevated_button.dart';
import 'package:pittappillil_crm/global_widgets/textfield.dart';
import 'package:pittappillil_crm/presentation/bar_code_scanning_screen/controller/scan_screen_controller.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController barCodeController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScanScreenController>().fetchData(context);
    });
  }

  @override
  void dispose() {
    barCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScanScreenController>(builder: (context, controller, _) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Brand and Category",
                style: GLTextStyles.montserratStyle(
                    size: 15, weight: FontWeight.w600, color: ColorTheme.pBlue),
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
                        itemCount: controller.filteredProductList.length,
                        itemBuilder: (context, index) {
                          final product = controller.filteredProductList[index];
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
              ),
              const SizedBox(height: 10),
              const CustomTextField(
                width: 307.0,
                height: 45.0,
                hintText: "Color",
                prefixIcon: Icon(Icons.category_sharp,
                    size: 18, color: Color(0xff9c9c9c)),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                width: 307.0,
                height: 45.0,
                hintText: "Barcode",
                prefixIcon: const Icon(Icons.qr_code_scanner_outlined,
                    size: 18, color: Color(0xff9c9c9c)),
                readOnly: true,
                controller: barCodeController,
                onTap: () {
                  openBarcodeScanner(controller: barCodeController);
                },
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => showDatePicker(context),
                child: AbsorbPointer(
                  child: CustomTextField(
                    width: 307.0,
                    height: 45.0,
                    hintText: "Date of Display",
                    prefixIcon: const Icon(
                      Icons.date_range_rounded,
                      size: 18,
                      color: Color(0xff9c9c9c),
                    ),
                    controller: dateController,
                  ),
                ),
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
                  onPressed: () {},
                  backgroundColor: Colors.white)
            ],
          ),
        ),
      );
    });
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
              if (mounted) {  
                setState(() {
                  controller.text = code;
                });
                Navigator.of(context).pop();
              }
            }
          },
        ),
      ),
    ),
  );
}

  void showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 180,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime newDate) {
                    String formattedDate =
                        "${newDate.year}-${newDate.month}-${newDate.day}";
                    dateController.text = formattedDate;
                  },
                ),
              ),
              CustomButton(
                borderColor: ColorTheme.pRed,
                backgroundColor: ColorTheme.white,
                text: "Done",
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
