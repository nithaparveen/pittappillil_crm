import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/utils/app_utils.dart';
import 'package:pittappillil_crm/repository/api/bar_code_scanning_screen/model/product_model.dart';
import 'package:pittappillil_crm/repository/api/bar_code_scanning_screen/service/scan_screen_service.dart';

class ScanScreenController extends ChangeNotifier {
  bool isLoading = false;
  List<ProductModel> productList = <ProductModel>[];
  List<ProductModel> filteredProductList = <ProductModel>[];
  TextEditingController searchController = TextEditingController();
  bool isListVisible = false;

  Future<void> fetchData(BuildContext context) async {
    isLoading = true;
    productList = [];
    notifyListeners();
    final resp = await ScanScreenService.fetchData();
    if (resp?["status"] == "success") {
      productList = productModelsFromJson(jsonEncode(resp!["data"]));
      filteredProductList = productList;
    } else {
      AppUtils.oneTimeSnackBar(
        "Unable to fetch Data",
        context: context,
        bgColor: ColorTheme.red,
      );
    }

    isLoading = false;
    notifyListeners();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProductList = productList;
    } else {
      filteredProductList = productList
          .where((product) =>
              product.productName?.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
    }
    isListVisible = query.isNotEmpty;
    notifyListeners();
  }

  void selectProduct(ProductModel product) {
    searchController.text = product.productName ?? '';
    isListVisible = false;
    notifyListeners();
  }
}