import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/utils/app_utils.dart';
import 'package:pittappillil_crm/repository/api/inventory_list_screen/service/inventory_list_service.dart';

import '../../../repository/api/inventory_list_screen/model/inventoryModel.dart';

class InventoryListController extends ChangeNotifier {
  bool isLoading = false;
  bool isMoreLoading = false;
  int currentPage = 1;
  // InventoryListModel inventoryListModel = InventoryListModel();
  List<InventoryModel> inventoryList = <InventoryModel>[];

  Future<void> fetchData(BuildContext context) async {
    isLoading = true;
    currentPage = 1;
    inventoryList = [];
    // inventoryListModel = InventoryListModel();
    notifyListeners();

    final resp = await InventoryListService.fetchData(page: currentPage);
    if (resp?["status"] == "success") {
      inventoryList =
          inventoryModelsFromJson(jsonEncode(resp!["data"]['data']));
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

  Future<void> fetchMoreProjects(BuildContext context) async {
    if (isMoreLoading) return;
    isMoreLoading = true;
    notifyListeners();

    try {
      currentPage++;

      final resp = await InventoryListService.fetchData(page: currentPage);
      if (resp != null && resp["status"] == "success") {
        var data = inventoryModelsFromJson(jsonEncode(resp["data"]['data']));
        inventoryList.addAll(data);
      } else {
        AppUtils.oneTimeSnackBar(
          "Unable to fetch more data",
          context: context,
          bgColor: ColorTheme.red,
        );
      }
    } catch (error) {
      print("Error fetching more projects: $error");
    } finally {
      isMoreLoading = false;
      notifyListeners();
    }
  }
}
