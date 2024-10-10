import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordField;
  final TextInputType? keyboardType;
  final double? width;
  final double? height;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPasswordField = false,
    this.keyboardType,
    this.width,
    this.height,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.validator,
    this.focusNode,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: height,
          width: width,
          child: TextFormField(
            controller: controller,
            obscureText: isPasswordField,
            keyboardType: keyboardType ?? TextInputType.text,
            style: GLTextStyles.montserratStyle(
              weight: FontWeight.w400,
              size: 14,
              color: const Color.fromARGB(255, 105, 105, 105),
            ),
            validator: validator,
            cursorColor: ColorTheme.pRedOrange,
            onChanged: onChanged,
            onTap: onTap,
            readOnly: readOnly,
            focusNode: focusNode,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
              errorStyle: const TextStyle(height: 0),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  width: 0.5,
                  color: Colors.red,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  width: 0.5,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
        if (validator != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 8),
            child: Builder(
              builder: (BuildContext context) {
                final errorText = validator!(controller?.text ?? '');
                return errorText != null
                    ? Text(
                        errorText,
                        style: GLTextStyles.montserratStyle(
                          weight: FontWeight.w400,
                          size: 12,
                          color: ColorTheme.pRedOrange,
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
          ),
      ],
    );
  }
}
