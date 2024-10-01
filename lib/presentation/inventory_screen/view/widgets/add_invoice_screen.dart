import 'package:flutter/material.dart';
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
  var invoiceController = TextEditingController(text: "EDDG-F6SI");

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
              width: 200.w, // Set width using w method (optional)
              height: 200.h, // Set height using h method (optional)
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
              width: 300.w, // Set width using w method (if needed)
            ),
            SizedBox(height: 15.h),
            CustomButton(
              width: 307.0.w, // Use w method for width
              height: 48.0.h, // Use h method for height
              text: "Submit",
              onPressed: () async {
                await storeInvoiceNumber();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BarcodeScanScreen(),
                  ),
                );
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
    print("Invoice Number Saved: ${invoiceController.text}");
  }
}
