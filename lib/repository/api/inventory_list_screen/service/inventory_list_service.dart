import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class InventoryListService {
  static Future<Map<String, dynamic>?> fetchData(
      {required int page}) async {
       
   // try {
      var decodedData = await ApiHelper.getData(
        endPoint: "scanner?page=$page&api_token=${await AppUtils.getToken()}",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData is Map<String, dynamic> ? decodedData : null;
    // } catch (e) {
    //   return null;
    // }
  }
  
  static Future<dynamic> fetchMoreLeads({required int page,required String? token}) async {
    try {
      var nextPage =
          "https://crmadmin.pittappillilonline.com/api/scanner?page=$page&api_token=$token";
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