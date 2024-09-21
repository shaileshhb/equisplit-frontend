import "package:equisplit_frontend/models/auth/invitation.dart";
import "package:equisplit_frontend/models/error/error_response.dart";
import "package:equisplit_frontend/utils/global.constant.dart";
import "package:equisplit_frontend/utils/user.shared_preference.dart";
import 'package:http/http.dart' as http;

class InvitationService {
  Future<bool> addInvitation(Invitation invitation) async {
    var client = http.Client();

    var authorizationToken = UserSharedPreference.getAuthorizationToken();
    var userID = UserSharedPreference.getUserId();

    if (userID == null) {
      return false;
    }

    var uri = Uri.parse('${GlobalConstants.baseURL}/user-invitations');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken",
    };

    var body = invitationToJson(invitation);
    var response = await client.post(uri, body: body, headers: headers);
    if (response.statusCode == 201) {
      return true;
    }

    if (response.statusCode >= 400) {
      throw CustomException(errorResponseFromJson(response.body).error);
    }

    return false;
  }

  Future<bool> acceptInvitation(Invitation invitation) async {
    var client = http.Client();

    var authorizationToken = UserSharedPreference.getAuthorizationToken();
    var userId = UserSharedPreference.getUserId();

    if (userId == null) {
      return false;
    }

    var uri = Uri.parse(
        '${GlobalConstants.baseURL}/user-invitations/${invitation.id}');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken",
    };

    var body = invitationToJson(invitation);
    var response = await client.put(uri, body: body, headers: headers);
    if (response.statusCode == 202) {
      return true;
    }

    if (response.statusCode >= 400) {
      throw CustomException(errorResponseFromJson(response.body).error);
    }

    return false;
  }

  Future<List<Invitation>?> getInvitations() async {
    var client = http.Client();

    var authorizationToken = UserSharedPreference.getAuthorizationToken();
    var userId = UserSharedPreference.getUserId();

    if (userId == null) {
      return null;
    }

    Map<String, String> queryParams = {
      "userId": userId,
    };

    var uri = Uri.parse('${GlobalConstants.baseURL}/user-invitations')
        .replace(queryParameters: queryParams);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken"
    };

    var response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var json = response.body;
      return invitationsFromJson(json);
    }

    if (response.statusCode >= 400) {
      throw CustomException(errorResponseFromJson(response.body).error);
    }

    return null;
  }
}
