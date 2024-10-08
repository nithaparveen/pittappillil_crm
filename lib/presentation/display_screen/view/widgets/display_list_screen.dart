import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';
import 'package:pittappillil_crm/global_widgets/shimmer_effect.dart';
import 'package:pittappillil_crm/presentation/display_screen/controller/display_screen_controller.dart';
import 'package:provider/provider.dart';

class DisplayListScreen extends StatefulWidget {
  const DisplayListScreen({super.key});

  @override
  State<DisplayListScreen> createState() => _DisplayListScreenState();
}

class _DisplayListScreenState extends State<DisplayListScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });

    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchMoreData();
    }
  }

  void fetchData() async {
    await Provider.of<DisplayScreenController>(context, listen: false)
        .fetchData(context);
  }

  void fetchMoreData() async {
    await Provider.of<DisplayScreenController>(context, listen: false)
        .fetchMoreData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DisplayScreenController>(builder: (context, controller, _) {
      var size = MediaQuery.of(context).size;
      return controller.isListLoading
          ? ShimmerEffect(size: size)
          : RefreshIndicator(
              strokeWidth: 1.8,
              backgroundColor: Colors.white,
              color: ColorTheme.pRedOrange,
              onRefresh: () async {
                await Provider.of<DisplayScreenController>(context,
                        listen: false)
                    .fetchData(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: controller.displayList.length + 1,
                  itemBuilder: (context, index) {
                    if (index < controller.displayList.length) {
                      return Card(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(CupertinoIcons.calendar_today,
                                          size: 12, color: Colors.white),
                                      Text(
                                        controller.displayList[index]
                                                    .dateOfDisplay !=
                                                null
                                            ? DateFormat('dd-MM-yyyy').format(
                                                controller.displayList[index]
                                                    .dateOfDisplay!)
                                            : "N/A",
                                        style: GLTextStyles.robotoStyle(
                                          size: 12,
                                          weight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "PRODUCT",
                                        style: GLTextStyles.robotoStyle(
                                          color: const Color(0xff868686),
                                          size: 10,
                                          weight: FontWeight.w400,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                           Icon(
                                            Icons.arrow_right,
                                            size: 16,
                                            color:
                                                ColorTheme.pRedOrange,
                                          ),
                                          const SizedBox(width: 4),
                                          Flexible(
                                            child: Text(
                                              controller.displayList[index]
                                                      .product?.productName ??
                                                  "N/A",
                                              style: GLTextStyles.robotoStyle(
                                                color: ColorTheme.pBlue,
                                                size: 14,
                                                weight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  const Divider(thickness: 0.5),
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
                                            style: GLTextStyles.robotoStyle(
                                                color: ColorTheme.pRedOrange,
                                                size: 12,
                                                weight: FontWeight.w500),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.barcode,
                                                size: 16,
                                                color: Colors.grey[700],
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                "${controller.displayList[index].barcodeNumber ?? "N/A"} ",
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                CupertinoIcons.color_filter,
                                                size: 16,
                                                color: Colors.grey[700],
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                "${controller.displayList[index].colorCode ?? "N/A"} ",
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
                      );
                    } else if (controller.isMoreLoading) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LoadingAnimationWidget.horizontalRotatingDots(
                            color: ColorTheme.pRedOrange,
                            size: 32,
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            );
    });
  }
}
