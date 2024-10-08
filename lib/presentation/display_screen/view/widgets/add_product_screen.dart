import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';
import 'package:pittappillil_crm/global_widgets/elevated_button.dart';
import 'package:pittappillil_crm/global_widgets/textfield.dart';
import 'package:pittappillil_crm/presentation/bar_code_scanning_screen/controller/scan_screen_controller.dart';
import 'package:pittappillil_crm/presentation/display_screen/controller/display_screen_controller.dart';
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

  bool isListVisible = false;
  List<dynamic> filteredProductList = [];
  dynamic selectedProduct;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<ScanScreenController>();
      controller.fetchProducts("", context);
    });
  }

  @override
  void dispose() {
    barCodeController.dispose();
    colorController.dispose();
    dateController.dispose();
    remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Consumer<DisplayScreenController>(builder: (context, controller, _) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(35.0).w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Brand and Category",
                style: GLTextStyles.montserratStyle(
                    size: 15.sp,
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
                    prefixIcon: const Icon(CupertinoIcons.bag,
                        size: 18, color: Color(0xff9c9c9c)),
                    suffixIcon: const Icon(Icons.manage_search_rounded,
                        size: 19, color: Color(0xff9c9c9c)),
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.fetchProducts(value, context);
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
              CustomTextField(
                width: 307.0,
                height: 45.0,
                hintText: "Color",
                prefixIcon: const Icon(CupertinoIcons.color_filter,
                    size: 18, color: Color(0xff9c9c9c)),
                controller: colorController,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                width: 307.0,
                height: 45.0,
                hintText: "Barcode",
                prefixIcon: const Icon(CupertinoIcons.barcode_viewfinder,
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
                      CupertinoIcons.calendar,
                      size: 18,
                      color: Color(0xff9c9c9c),
                    ),
                    controller: dateController,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                width: 307.0,
                height: 45.0,
                hintText: "Remarks",
                prefixIcon: const Icon(CupertinoIcons.square_grid_2x2,
                    size: 18, color: Color(0xff9c9c9c)),
                controller: remarkController,
              ),
              const SizedBox(height: 10),
              CustomButton(
                  width: 307.0,
                  height: 48.0,
                  text: "Submit",
                  onPressed: () {
                    final selectedProductId = controller.productId;
                    if (selectedProductId != null) {
                      Provider.of<DisplayScreenController>(context,
                              listen: false)
                          .storeData(
                              remarkController.text.trim(),
                              barCodeController.text.trim(),
                              dateController.text.trim(),
                              selectedProductId,
                              colorController.text.trim(),
                              context);
                      remarkController.clear();
                      barCodeController.clear();
                      dateController.clear();
                      colorController.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please select a product")),
                      );
                    }
                  },
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
                        "${newDate.year}-${newDate.month.toString().padLeft(2, '0')}-${newDate.day.toString().padLeft(2, '0')}";
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
