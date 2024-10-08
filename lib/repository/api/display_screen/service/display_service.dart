import 'dart:developer';

import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class DisplayScreenService {
  static Future<Map<String, dynamic>?> searchProduct(String keyword) async {
    var decodedData = await ApiHelper.getData(
      endPoint:
          "scanner/products?api_token=${await AppUtils.getToken()}&keyword=$keyword",
      header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
    );
    return decodedData is Map<String, dynamic> ? decodedData : null;
  }

  static Future<dynamic> storeData(String? remark, String? barCode,
      String? date, String? productId, String? color) async {
    try {
      var decodedData = await ApiHelper.postData(
          endPoint:
              "scanner/display-product/store?product_id=$productId&color_code=$color&date_of_display=$date&barcode_number=$barCode&remarks=$remark&api_token=${await AppUtils.getToken()}");
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<Map<String, dynamic>?> fetchData({required int page}) async {
    var decodedData = await ApiHelper.getData(
      endPoint:
          "scanner/display-product?page=$page&api_token=${await AppUtils.getToken()}",
      header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
    );
    return decodedData is Map<String, dynamic> ? decodedData : null;
  }

  static Future<dynamic> fetchMoreData({required int page}) async {
    try {
      var nextPage =
          "https://crmadmin.pittappillilonline.com/api/scanner/display-product?page=$page&api_token=${await AppUtils.getToken()}";
      var decodedData = await ApiHelper.getDataWObaseUrl(
        endPoint: nextPage,
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      throw Exception('Failed to fetch leads');
    }
  }
}
