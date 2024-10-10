import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pittappillil_crm/global_widgets/elevated_button.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';
import 'package:pittappillil_crm/presentation/bar_code_scanning_screen/controller/scan_screen_controller.dart';

class ThankYouScreen extends StatefulWidget {
  final String productName;
  final String barcode;
  final String color;

  const ThankYouScreen({
    super.key,
    required this.productName,
    required this.barcode,
    required this.color,
  });

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
              Positioned(
                top: 35,
                right: 22,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.cancel_outlined,
                        color: Color(0xff9c9c9c))),
              ),
              Consumer<ScanScreenController>(builder: (context, controller, _) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       SizedBox(height: 130.h),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/successlottie.json',
                              width: 150.w,
                              height: 170.h,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Here you go! Your ",
                                    style: GLTextStyles.montserratStyle(
                                      color: ColorTheme.pBlue,
                                      size: 15.sp,
                                      weight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "product \nhas been added ",
                                    style: GLTextStyles.montserratStyle(
                                      color: ColorTheme.pBlue,
                                      size: 15.sp,
                                      weight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "to the list",
                                    style: GLTextStyles.montserratStyle(
                                      color: ColorTheme.pBlue,
                                      size: 15.sp,
                                      weight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Card(
                              color: const Color(0xfffff6f6),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "PRODUCT",
                                              style: GLTextStyles.robotoStyle(
                                                color: const Color(0xff868686),
                                                size: 10.sp,
                                                weight: FontWeight.w400,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.arrow_right,
                                                  size: 16.sp,
                                                  color: ColorTheme.pRedOrange,
                                                ),
                                                const SizedBox(width: 4),
                                                Flexible(
                                                  child: Text(
                                                    widget.productName,
                                                    style: GLTextStyles
                                                        .robotoStyle(
                                                      color: ColorTheme.pBlue,
                                                      size: 14.sp,
                                                      weight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                         SizedBox(height: 5.h),
                                         Divider(thickness: 0.5.sp),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "BARCODE:",
                                                  style:
                                                      GLTextStyles.robotoStyle(
                                                          color: ColorTheme
                                                              .pRedOrange,
                                                          size: 12.sp,
                                                          weight:
                                                              FontWeight.w500),
                                                ),
                                                SizedBox(height: 4.h),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons.barcode,
                                                      size: 16.sp,
                                                      color: Colors.grey[700],
                                                    ),
                                                   SizedBox(width: 4.w),
                                                    Text(
                                                      widget.barcode,
                                                      style: GLTextStyles
                                                          .robotoStyle(
                                                              color: ColorTheme
                                                                  .pBlue,
                                                              size: 12.sp,
                                                              weight: FontWeight
                                                                  .w400),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "COLOR:",
                                                  style:
                                                      GLTextStyles.robotoStyle(
                                                          color: ColorTheme
                                                              .pRedOrange,
                                                          size: 12.sp,
                                                          weight:
                                                              FontWeight.w500),
                                                ),
                                               SizedBox(height: 4.h),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons
                                                          .color_filter,
                                                      size: 16.sp,
                                                      color: Colors.grey[700],
                                                    ),
                                                   SizedBox(width: 4.w),
                                                    Text(
                                                      widget.color,
                                                      style: GLTextStyles
                                                          .robotoStyle(
                                                              color: ColorTheme
                                                                  .pBlue,
                                                              size: 12.sp,
                                                              weight: FontWeight
                                                                  .w400),
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
                            SizedBox(height: 35.h),
                            Text(
                              "Scan another product using",
                              style: GLTextStyles.montserratStyle(
                                  size: 14.sp,
                                  weight: FontWeight.w500,
                                  color: ColorTheme.pBlue),
                            ),
                            SizedBox(height: 12.h),
                            CustomButton(
                              width: 180.0.w,
                              height: 48.0.h,
                              text: "Add a new product",
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              backgroundColor: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
