import 'package:flutter/material.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';
import 'package:pittappillil_crm/global_widgets/elevated_button.dart';
import 'package:pittappillil_crm/global_widgets/textfield.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
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
            const CustomTextField(
              width: 307.0,
              height: 45.0,
              hintText: "Select Product",
              prefixIcon:
                  Icon(Icons.shopping_bag, size: 18, color: Color(0xff9c9c9c)),
              suffixIcon: Icon(Icons.arrow_drop_down,
                  size: 18, color: Color(0xff9c9c9c)),
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
            const CustomTextField(
              width: 307.0,
              height: 45.0,
              hintText: "Barcode",
              prefixIcon: Icon(Icons.qr_code_scanner_outlined,
                  size: 18, color: Color(0xff9c9c9c)),
            ),
            const SizedBox(height: 10),
            const CustomTextField(
              width: 307.0,
              height: 45.0,
              hintText: "Date of Display",
              prefixIcon: Icon(Icons.date_range_outlined,
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
                backgroundColor: Colors.white)
          ],
        ),
      ),
    );
  }
}
