import 'package:equisplit_frontend/models/error/error_response.dart';
import 'package:equisplit_frontend/models/group/group.dart';
import 'package:equisplit_frontend/models/group/user_group.dart';
import 'package:equisplit_frontend/utils/global.constant.dart';
import 'package:equisplit_frontend/utils/user.shared_preference.dart';
import 'package:http/http.dart' as http;

class UserGroupService {
  Future<List<Group>?> getUserGroups() async {
    var client = http.Client();
    var authorizationToken = UserSharedPreference.getAuthorizationToken();
    String userId = UserSharedPreference.getUserId()!;

    var uri = Uri.parse('${GlobalConstants.baseURL}/user/$userId/groups');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken",
    };

    var response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var body = response.body;
      return groupsFromJson(body);
    }

    return null;
  }

  Future<List<UserGroupEntity>?> getGroupUsers(String groupId) async {
    var client = http.Client();
    var authorizationToken = UserSharedPreference.getAuthorizationToken();

    var uri = Uri.parse('${GlobalConstants.baseURL}/group/$groupId/users');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken",
    };

    var response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var body = response.body;
      return userGroupsFromJson(body);
    }

    if (response.statusCode >= 400) {
      throw ErrorResponse(error: errorResponseFromJson(response.body).error);
    }

    return null;
  }

  Future<List<UserGroupEntity>?> getGroupDetails(String groupId) async {
    var client = http.Client();
    var authorizationToken = UserSharedPreference.getAuthorizationToken();

    var uri = Uri.parse('${GlobalConstants.baseURL}/group/$groupId');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken",
    };

    var response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var body = response.body;
      var json = userGroupsFromJson(body);
      return json;
    }

    return null;
  }

  Future<bool> createGroup(Group group) async {
    var client = http.Client();
    var authorizationToken = UserSharedPreference.getAuthorizationToken();
    var userId = UserSharedPreference.getUserId();

    var uri = Uri.parse('${GlobalConstants.baseURL}/user/$userId/group');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken",
    };

    var body = groupToJson(group);
    var response = await client.post(uri, body: body, headers: headers);
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }
}
