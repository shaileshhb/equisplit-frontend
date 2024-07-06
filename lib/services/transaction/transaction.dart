import 'package:equisplit_frontend/models/error/error_response.dart';
import 'package:equisplit_frontend/utils/global.constant.dart';
import 'package:equisplit_frontend/utils/user.shared_preference.dart';
import 'package:equisplit_frontend/services/transaction/user_balance.dart';
import 'package:http/http.dart' as http;

class UserTransactionService {
  Future<List<UserBalance>?> getUserTransactions(String groupId) async {
    var client = http.Client();
    var authorizationToken = UserSharedPreference.getAuthorizationToken();

    var uri =
        Uri.parse('${GlobalConstants.baseURL}/group/$groupId/transactions');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken",
    };

    var response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var body = response.body;
      return userBalanceFromJson(body);
    }

    if (response.statusCode >= 400) {
      throw CustomException(errorResponseFromJson(response.body).error);
    }

    return null;
  }
}
