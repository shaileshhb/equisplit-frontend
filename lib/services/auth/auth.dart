import "dart:convert";

import "package:equisplit_frontend/models/auth/login_request.dart";
import "package:equisplit_frontend/models/auth/login_response.dart";
import "package:equisplit_frontend/models/auth/register_request.dart";
import "package:equisplit_frontend/models/auth/user.dart";
import "package:equisplit_frontend/utils/global.constant.dart";
import "package:equisplit_frontend/utils/user.shared_preference.dart";
import 'package:http/http.dart' as http;

class AuthenticationService {
  Future<LoginResponse?> userLogin(LoginRequest login) async {
    var client = http.Client();

    var uri = Uri.parse('${GlobalConstants.baseURL}/login');

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    var body = jsonEncode(login);

    var response = await client.post(uri, body: body, headers: headers);

    if (response.statusCode == 200) {
      var json = response.body;
      return loginResponseFromJson(json);
    }
    return null;
  }

  Future<LoginResponse?> register(RegisterRequest userDetails) async {
    var client = http.Client();

    var uri = Uri.parse('${GlobalConstants.baseURL}/register');

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    var body = jsonEncode(userDetails);

    var response = await client.post(uri, body: body, headers: headers);

    if (response.statusCode == 201) {
      var body = response.body;
      return loginResponseFromJson(body);
    }
    return null;
  }

  Future<User?> getUser() async {
    var client = http.Client();

    var authorizationToken = UserSharedPreference.getAuthorizationToken();
    var userID = UserSharedPreference.getUserID();

    if (userID == null) {
      return null;
    }

    var uri = Uri.parse('${GlobalConstants.baseURL}/users/$userID');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken"
    };

    var response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return userFromJson(response.body);
    }
    return null;
  }
}
