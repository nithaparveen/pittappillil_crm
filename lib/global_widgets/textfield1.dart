import 'package:flutter/material.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool isPasswordField;
  final TextInputType? keyboardType;
  final double? width;
  final double? height;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText , // Default hint text
    this.prefixIcon,
    this.suffixIcon,
    this.isPasswordField = false, // Default is not a password field
    this.keyboardType,
    this.width,
    this.height, // Specify keyboard type
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        controller: controller,
        obscureText: isPasswordField, // Obscure text for password fields
        keyboardType: keyboardType ?? TextInputType.text, // Set input type
        style: GLTextStyles.montserratStyle(
          weight: FontWeight.w400,
          size: 14,
          color: const Color(0xff9c9c9c),
        ),
        cursorColor: Colors.greenAccent,
        decoration: InputDecoration(
          prefixIcon: prefixIcon, 
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 0.5,
              color: Color(0xff9c9c9c),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 0.5,
              color: Color(0xff9c9c9c),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 0.5,
              color: Color(0xff9c9c9c),
            ),
          ),
          focusColor: Colors.transparent,
          hintText: hintText,
          hintStyle: GLTextStyles.montserratStyle(
            weight: FontWeight.w400,
            size: 14,
            color: const Color(0xff9c9c9c),
          ),
        ),
      ),
    );
  }
}
