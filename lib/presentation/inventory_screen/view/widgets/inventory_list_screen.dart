// import 'package:flutter/material.dart';
// import 'package:pittappillil_crm/core/constants/colors.dart';
// import 'package:pittappillil_crm/core/constants/textstyles.dart';
// import 'package:pittappillil_crm/presentation/inventory_screen/controller/inventory_controller.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/scheduler.dart';


// class InventoryListScreen extends StatefulWidget {
//   const InventoryListScreen({super.key});

//   @override
//   State<InventoryListScreen> createState() => _InventoryListScreenState();
// }

// class _InventoryListScreenState extends State<InventoryListScreen> {
//   bool isLoading = true;

//   @override
//   void initState() {
   
//     super.initState();
   
//       fetchData();
   
//   }

//   void fetchData() async {
//     await Provider.of<InventoryListController>(context, listen: false)
//         .fetchData(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<InventoryListController>(builder: (context, controller, _) {
//       return controller.isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
//               child: ListView.builder(
//                 itemCount:
//                     controller.inventoryListModel.data?.data?.length ?? 0,
//                 itemBuilder: (context, index) => Card(
//                   color: const Color(0xfffff6f6),
//                   child: Column(
//                     children: [
//                       Align(
//                         alignment: FractionalOffset.topCenter,
//                         child: Container(
//                           width: 200,
//                           decoration: BoxDecoration(
//                               color: ColorTheme.pRedOrange,
//                               borderRadius: const BorderRadius.only(
//                                   bottomLeft: Radius.circular(8),
//                                   bottomRight: Radius.circular(8))),
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 3, bottom: 3, left: 50, right: 50),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 const Icon(Icons.sticky_note_2_outlined,
//                                     size: 12, color: Colors.white),
//                                 Text(
//                                   "${controller.inventoryListModel.data?.data?[index].invoiceId}",
//                                   style: GLTextStyles.robotoStyle(
//                                       size: 12,
//                                       weight: FontWeight.w400,
//                                       color: Colors.white),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "BRAND",
//                                       style: GLTextStyles.robotoStyle(
//                                           color: const Color(0xff868686),
//                                           size: 10,
//                                           weight: FontWeight.w400),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Row(
//                                       children: [
//                                         const Icon(
//                                           Icons.branding_watermark_outlined,
//                                           size: 16,
//                                           color: Color(0xff868686),
//                                         ),
//                                         const SizedBox(width: 4),
//                                         Text(
//                                           "${controller.inventoryListModel.data?.data?[index].brand?.name} ?? NA ",
//                                           style: GLTextStyles.robotoStyle(
//                                               color: ColorTheme.pBlue,
//                                               size: 14,
//                                               weight: FontWeight.w500),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "CATEGORY",
//                                       style: GLTextStyles.robotoStyle(
//                                           color: const Color(0xff868686),
//                                           size: 10,
//                                           weight: FontWeight.w400),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Row(
//                                       children: [
//                                         const Icon(Icons.category,
//                                             size: 16, color: Color(0xff868686)),
//                                         const SizedBox(width: 4),
//                                         Text(
//                                           "${controller.inventoryListModel.data?.data?[index].category?.name} ?? NA ",
//                                           style: GLTextStyles.robotoStyle(
//                                               color: ColorTheme.pBlue,
//                                               size: 14,
//                                               weight: FontWeight.w500),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 5),
//                             const Divider(
//                               thickness: 0.5,
//                             ),
//                             Text(
//                               "BARCODE:",
//                               style: GLTextStyles.robotoStyle(
//                                   color: ColorTheme.pRedOrange,
//                                   size: 12,
//                                   weight: FontWeight.w500),
//                             ),
//                             const SizedBox(height: 4),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.qr_code_scanner,
//                                       size: 16,
//                                       color: Colors.grey[700],
//                                     ),
//                                     const SizedBox(width: 4),
//                                     Text(
//                                       "${controller.inventoryListModel.data?.data?[index].barcode1} ?? NA ",
//                                       style: GLTextStyles.robotoStyle(
//                                           color: ColorTheme.pBlue,
//                                           size: 12,
//                                           weight: FontWeight.w400),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.qr_code_scanner,
//                                       size: 16,
//                                       color: Colors.grey[700],
//                                     ),
//                                     const SizedBox(width: 4),
//                                     Text(
//                                       "${controller.inventoryListModel.data?.data?[index].barcode2} ?? NA ",
//                                       style: GLTextStyles.robotoStyle(
//                                           color: ColorTheme.pBlue,
//                                           size: 12,
//                                           weight: FontWeight.w400),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//     });
//   }
// }
