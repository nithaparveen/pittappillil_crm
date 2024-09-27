import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class ScanScreenService {
  static Future<Map<String, dynamic>?> fetchData() async {
    // try {
    var decodedData = await ApiHelper.getData(
      endPoint: "scanner/products?api_token=${await AppUtils.getToken()}",
      header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
    );
    return decodedData is Map<String, dynamic> ? decodedData : null;
    // } catch (e) {
    //   return null;
    // }
  }
}
