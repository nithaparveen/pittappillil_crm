import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  void fetchData() async {
    await Provider.of<InventoryListController>(context, listen: false)
        .fetchData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InventoryListController>(builder: (context, controller, _) {
      var size = MediaQuery.sizeOf(context);
      return controller.isLoading
          ? ShimmerEffect(size: size)
          : Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.inventoryList.length,
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
                                top: 3, bottom: 3, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.sticky_note_2_outlined,
                                    size: 12, color: Colors.white),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "${controller.inventoryList[index].invoiceId}",
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
                                          "${controller.inventoryList[index].brand?.name ?? "N/A"} ",
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
                                          "${controller.inventoryList[index].category?.name ?? "N/A"} ",
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
                              thickness: 0.5,
                            ),
                            Text(
                              "BARCODE:",
                              style: GLTextStyles.robotoStyle(
                                  color: ColorTheme.pRedOrange,
                                  size: 12,
                                  weight: FontWeight.w500),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.qr_code_scanner,
                                      size: 16,
                                      color: Colors.grey[700],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "${controller.inventoryList[index].barcode1 ?? "N/A"} ",
                                      style: GLTextStyles.robotoStyle(
                                        color: ColorTheme.pBlue,
                                        size: 12,
                                        weight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.qr_code_scanner,
                                        size: 16,
                                        color: Colors.grey[700],
                                      ),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          "${controller.inventoryList[index].barcode2 ?? "N/A"} "
                                              .toUpperCase(),
                                          style: GLTextStyles.robotoStyle(
                                            color: ColorTheme.pBlue,
                                            size: 12,
                                            weight: FontWeight.w400,
                                          ),
                                          softWrap:
                                              true, // Enable wrapping to fit in the available space
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
                ),
              ),
            );
    });
  }
}
