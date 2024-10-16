import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';
import 'package:pittappillil_crm/global_widgets/shimmer_effect.dart';
import 'package:pittappillil_crm/presentation/inventory_screen/controller/inventory_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';

class InventoryListScreenV2 extends StatefulWidget {
  const InventoryListScreenV2({super.key});

  @override
  State<InventoryListScreenV2> createState() => _InventoryListScreenV2State();
}

class _InventoryListScreenV2State extends State<InventoryListScreenV2> {
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
    await Provider.of<InventoryListController>(context, listen: false)
        .fetchData(context);
  }

  void fetchMoreData() async {
    await Provider.of<InventoryListController>(context, listen: false)
        .fetchMoreData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InventoryListController>(
      builder: (context, controller, _) {
        var size = MediaQuery.of(context).size;
        return controller.isLoading
            ? ShimmerEffect(size: size)
            : RefreshIndicator(
                strokeWidth: 1.8,
                backgroundColor: Colors.white,
                color: ColorTheme.pRedOrange,
                onRefresh: () async {
                  await Provider.of<InventoryListController>(context,
                          listen: false)
                      .fetchData(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: controller.inventoryList.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.inventoryList.length) {
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
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 3,
                                      bottom: 3,
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.sticky_note_2_outlined,
                                          size: 12,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          controller.inventoryList[index]
                                                  .invoiceId ??
                                              "N/A",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                              color: ColorTheme.pRedOrange,
                                            ),
                                            const SizedBox(width: 4),
                                            Flexible(
                                              child: Text(
                                                controller.inventoryList[index]
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
                                    Text(
                                      "BARCODE:",
                                      style: GLTextStyles.robotoStyle(
                                        color: ColorTheme.pRedOrange,
                                        size: 12,
                                        weight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.barcode,
                                              size: 16,
                                              color: Colors.grey[700],
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              controller.inventoryList[index]
                                                      .barcode1 ??
                                                  "N/A",
                                              style: GLTextStyles.robotoStyle(
                                                color: ColorTheme.pBlue,
                                                size: 12,
                                                weight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 16),
                                        if (controller.inventoryList[index]
                                                .barcode2 !=
                                            null)
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  CupertinoIcons.barcode,
                                                  size: 16,
                                                  color: Colors.grey[700],
                                                ),
                                                const SizedBox(width: 4),
                                                Flexible(
                                                  child: Text(
                                                    "${controller.inventoryList[index].barcode2}"
                                                        .toUpperCase(),
                                                    style: GLTextStyles
                                                        .robotoStyle(
                                                      color: ColorTheme.pBlue,
                                                      size: 12,
                                                      weight: FontWeight.w400,
                                                    ),
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    )
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
                            child:
                                LoadingAnimationWidget.horizontalRotatingDots(
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
      },
    );
  }
}
