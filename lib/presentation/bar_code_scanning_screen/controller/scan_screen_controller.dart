import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';
import 'package:pittappillil_crm/core/utils/app_utils.dart';
import 'package:pittappillil_crm/repository/api/bar_code_scanning_screen/model/product_model.dart';
import 'package:pittappillil_crm/repository/api/bar_code_scanning_screen/service/scan_screen_service.dart';

class ScanScreenController extends ChangeNotifier {
  bool isLoading = false;
  List<ProductModel> productList = <ProductModel>[];
  List<ProductModel> filteredProductList = <ProductModel>[];
  TextEditingController searchController = TextEditingController();
  bool isListVisible = false;
  String? productId;

  Future<void> fetchProducts(String keyword, BuildContext context) async {
    log("SearchController -> fetchProducts()");
    isLoading = true;
    filteredProductList = [];
    notifyListeners();

    try {
      final resp = await ScanScreenService.searchProduct(keyword);
      if (resp?["status"] == "success") {
        productList = productModelsFromJson(jsonEncode(resp!["data"]['data']));
        filteredProductList = productList;
      } else {
        AppUtils.oneTimeSnackBar(
          "Unable to fetch Data",
          context: context,
          bgColor: ColorTheme.red,
        );
      }
    } catch (e) {
      AppUtils.oneTimeSnackBar(
        "Network Error: Unable to fetch data",
        context: context,
        bgColor: ColorTheme.red,
      );
    } finally {
      isLoading = false;
      isListVisible = keyword.isNotEmpty;
      notifyListeners();
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProductList = productList;
    } else {
      filteredProductList = productList
          .where((product) =>
              product.productName
                  ?.toLowerCase()
                  .contains(query.toLowerCase()) ??
              false)
          .toList();
    }
    isListVisible = query.isNotEmpty;
    notifyListeners();
  }

  void selectProduct(ProductModel product) {
    searchController.text = product.productName ?? '';
    productId = product.id?.toString();
    isListVisible = false;
    notifyListeners();
  }

 Future<Map<String, dynamic>> storeData(
  String? remark,
  String? barOne,
  String? barTwo,
  String? productId,
  String? invoiceId,
  BuildContext context,
) async {
  log("SearchController -> storeData()");

  try {
    final value = await ScanScreenService.storeData(
      remark, barOne, barTwo, productId, invoiceId,
    );

    if (value["status"] == "success") {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              value["message"],
              style: GLTextStyles.cabinStyle(
                  color: ColorTheme.white, weight: FontWeight.w500, size: 14),
            ),
            backgroundColor: const Color.fromARGB(255, 97, 182, 86),
          ),
        );
      }
    } else if (value["status"] == "error" && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            value["message"],
            style: GLTextStyles.cabinStyle(
                color: ColorTheme.white, weight: FontWeight.w500, size: 14),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }

    return value; // Return the result
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Network Error: Unable to fetch data",
            style: TextStyle(fontSize: 14),
          ),
          backgroundColor: ColorTheme.red,
        ),
      );
    }

    return {"status": "error", "message": "Network error occurred"};
  }
}

}
