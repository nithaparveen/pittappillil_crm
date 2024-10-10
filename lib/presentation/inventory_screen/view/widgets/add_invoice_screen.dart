import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';
import 'package:pittappillil_crm/global_widgets/elevated_button.dart';
import 'package:pittappillil_crm/global_widgets/textfield.dart';
import 'package:pittappillil_crm/presentation/bar_code_scanning_screen/view/bar_code_scanning_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddInvoiceScreen extends StatefulWidget {
  const AddInvoiceScreen({super.key});

  @override
  State<AddInvoiceScreen> createState() => _AddInvoiceScreenState();
}

class _AddInvoiceScreenState extends State<AddInvoiceScreen> {
  final String fixedInvoicePrefix = "EDDG-F6SI-";
  var invoiceController = TextEditingController(text: "EDDG-F6SI-");
  bool isSubmitPressed = false;
  FocusNode invoiceFocusNode = FocusNode();

  String? validateInvoice(String? value) {
    if (isSubmitPressed) {
      if (value == null || value.isEmpty) {
        return 'Please enter the remaining invoice number';
      }
      if (value == fixedInvoicePrefix) {
        return 'Please enter the remaining invoice number';
      }
      if (value.length != 16) {
        return 'Invoice number must be exactly 16 digits';
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    invoiceFocusNode = FocusNode();

    // Adding a listener to control the text input behavior
    invoiceController.addListener(() {
      String currentText = invoiceController.text;

      // Ensure the prefix stays intact and cannot be edited or deleted
      if (!currentText.startsWith(fixedInvoicePrefix)) {
        invoiceController.text = fixedInvoicePrefix;
      }

      // Prevent cursor from moving into the prefix part
      if (invoiceController.selection.start < fixedInvoicePrefix.length) {
        invoiceController.selection = TextSelection.fromPosition(
          TextPosition(offset: fixedInvoicePrefix.length),
        );
      }
    });
  }

  @override
  void dispose() {
    invoiceFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(35.0.w),
        child: Column(
          children: [
            Text(
              "Scan your Invoice Number",
              style: GLTextStyles.montserratStyle(
                  size: 16.sp,
                  weight: FontWeight.w600,
                  color: ColorTheme.pBlue),
            ),
            SizedBox(height: 15.h),
            Image.asset(
              "assets/scan_invoice.png",
              width: 150.w,
              height: 170.h,
            ),
            SizedBox(height: 15.h),
            Text(
              "Type Your Invoice Number",
              style: GLTextStyles.montserratStyle(
                  size: 14.sp,
                  weight: FontWeight.w400,
                  color: ColorTheme.pBlue),
            ),
            SizedBox(height: 15.h),
            CustomTextField(
              controller: invoiceController,
              hintText: "Invoice No.",
              width: 300.w,
              validator: validateInvoice,
              focusNode: invoiceFocusNode,
              inputFormatters: [
                LengthLimitingTextInputFormatter(16),
              ],
            ),
            SizedBox(height: 15.h),
            CustomButton(
              width: 307.0.w,
              height: 48.0.h,
              text: "Submit",
              onPressed: () async {
                setState(() {
                  isSubmitPressed = true;
                });
                if (invoiceController.text.isNotEmpty &&
                    invoiceController.text != fixedInvoicePrefix &&
                    invoiceController.text.length == 16) {
                  await storeInvoiceNumber();
                  invoiceFocusNode.unfocus();
                  String invoiceId = invoiceController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BarcodeScanScreen(invoiceId: invoiceId),
                    ),
                  );
                }
              },
              backgroundColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Future<void> storeInvoiceNumber() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('invoice_id', invoiceController.text);
    log("Invoice Number Saved: ${invoiceController.text}");
  }
}
