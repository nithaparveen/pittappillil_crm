import 'package:flutter/material.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';
import 'package:pittappillil_crm/global_widgets/elevated_button.dart';
import 'package:pittappillil_crm/global_widgets/textfield.dart';
import 'package:pittappillil_crm/presentation/bar_code_scanning_screen/view/bar_code_scanning_screen.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class AddInvoiceScreen extends StatefulWidget {
  const AddInvoiceScreen({super.key});

  @override
  State<AddInvoiceScreen> createState() => _AddInvoiceScreenState();
}

class _AddInvoiceScreenState extends State<AddInvoiceScreen> {
  var invoiceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          children: [
            Text(
              "Scan your Invoice Number",
              style: GLTextStyles.montserratStyle(
                  size: 16, weight: FontWeight.w600, color: ColorTheme.pBlue),
            ),
            const SizedBox(height: 15),
            Image.asset("assets/scan_invoice.png"),
            const SizedBox(height: 15),
            Text(
              "Type Your Invoice Number",
              style: GLTextStyles.montserratStyle(
                  size: 14, weight: FontWeight.w400, color: ColorTheme.pBlue),
            ),
            const SizedBox(height: 15),
            CustomTextField(
              controller: invoiceController,
              hintText: "Invoice No.",
            ),
            const SizedBox(height: 15),
            CustomButton(
              width: 307.0,
              height: 48.0,
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
