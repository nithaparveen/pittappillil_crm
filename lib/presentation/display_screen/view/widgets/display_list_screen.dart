import 'package:flutter/material.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';

class DisplayListScreen extends StatefulWidget {
  const DisplayListScreen({super.key});

  @override
  State<DisplayListScreen> createState() => _DisplayListScreenState();
}

class _DisplayListScreenState extends State<DisplayListScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
      child: ListView.builder(
        itemBuilder: (context, index) => Card(
          color: const Color(0xfffff6f6),
          child: Column(
            children: [
              Align(
                alignment: FractionalOffset.topCenter,
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                      color: ColorTheme.pRedOrange,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 3, bottom: 3, left: 50, right: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.sticky_note_2_outlined,
                            size: 12, color: Colors.white),
                        Text(
                          "1234567890",
                          style: GLTextStyles.robotoStyle(
                              size: 12,
                              weight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "BRAND",
                              style: GLTextStyles.robotoStyle(
                                  color: const Color(0xff868686),
                                  size: 10,
                                  weight: FontWeight.w400),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.branding_watermark_outlined,
                                  size: 16,
                                  color: Color(0xff868686),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "Realme",
                                  style: GLTextStyles.robotoStyle(
                                      color: ColorTheme.pBlue,
                                      size: 14,
                                      weight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CATEGORY",
                              style: GLTextStyles.robotoStyle(
                                  color: const Color(0xff868686),
                                  size: 10,
                                  weight: FontWeight.w400),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.category,
                                    size: 16, color: Color(0xff868686)),
                                const SizedBox(width: 4),
                                Text(
                                  "Home Appliances",
                                  style: GLTextStyles.robotoStyle(
                                      color: ColorTheme.pBlue,
                                      size: 14,
                                      weight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Divider(
                      thickness: 0.5
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "BARCODE:",
                              style: GLTextStyles.robotoStyle(
                                  color: ColorTheme.pRedOrange,
                                  size: 12,
                                  weight: FontWeight.w500),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.qr_code_scanner,
                                  size: 16,
                                  color: Colors.grey[700],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "00123456789012",
                                  style: GLTextStyles.robotoStyle(
                                      color: ColorTheme.pBlue,
                                      size: 12,
                                      weight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "COLOR:",
                              style: GLTextStyles.robotoStyle(
                                  color: ColorTheme.pRedOrange,
                                  size: 12,
                                  weight: FontWeight.w500),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.qr_code_scanner,
                                  size: 16,
                                  color: Colors.grey[700],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "00123456789012",
                                  style: GLTextStyles.robotoStyle(
                                      color: ColorTheme.pBlue,
                                      size: 12,
                                      weight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        itemCount: 4,
      ),
    );
  }
}
