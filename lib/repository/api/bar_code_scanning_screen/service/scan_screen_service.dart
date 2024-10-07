import 'dart:developer';

import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class ScanScreenService {
  static Future<Map<String, dynamic>?> fetchData() async {
    var decodedData = await ApiHelper.getData(
      endPoint: "scanner/products?api_token=${await AppUtils.getToken()}",
      header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
    );
    return decodedData is Map<String, dynamic> ? decodedData : null;
  }

  static Future<Map<String, dynamic>?> searchProduct(String keyword) async {
    var decodedData = await ApiHelper.getData(
      endPoint:
          "scanner/products?api_token=${await AppUtils.getToken()}&keyword=$keyword",
      header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
    );
    return decodedData is Map<String, dynamic> ? decodedData : null;
  }

  static Future<dynamic> storeData(
      String? remark, String? barOne, String? barTwo, String? productId, String? invoiceId) async {
    try {
      var decodedData = await ApiHelper.postData(
          endPoint:
              "scanner/store?api_token=${await AppUtils.getToken()}&remarks=$remark&barcode_1=$barOne&barcode_2=$barTwo&product_id=$productId&invoice_id=$invoiceId");
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}