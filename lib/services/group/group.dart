import 'package:equisplit_frontend/models/group/group.dart';
import 'package:equisplit_frontend/models/group/user_group.dart';
import 'package:equisplit_frontend/utils/global.constant.dart';
import 'package:equisplit_frontend/utils/user.shared_preference.dart';
import 'package:http/http.dart' as http;

class UserGroupService {
  Future<List<UserGroupEntity>?> getUserGroups() async {
    var client = http.Client();
    var authorizationToken = UserSharedPreference.getAuthorizationToken();
    var userId = UserSharedPreference.getUserID();

    var uri = Uri.parse('${GlobalConstants.baseURL}/user/$userId/group');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken",
    };

    var response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var body = response.body;
      return userGroupsFromJson(body);
    }

    return null;
  }

  Future<List<UserGroupEntity>?> getGroupDetails(int groupId) async {
    var client = http.Client();
    var authorizationToken = UserSharedPreference.getAuthorizationToken();

    var uri = Uri.parse('${GlobalConstants.baseURL}/group/$groupId/user');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken",
    };

    var response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var body = response.body;
      print(body);
      return userGroupsFromJson(body);
    }

    return null;
  }

  Future<bool> createGroup(Group group) async {
    var client = http.Client();
    var authorizationToken = UserSharedPreference.getAuthorizationToken();
    var userId = UserSharedPreference.getUserID();

    var uri = Uri.parse('${GlobalConstants.baseURL}/$userId/group');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken",
    };

    var body = groupToJson(group);
    var response = await client.post(uri, body: body, headers: headers);
    print(response.statusCode);

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }
}
