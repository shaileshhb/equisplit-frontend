import 'package:equisplit_frontend/models/group/user_group.dart';
import 'package:equisplit_frontend/utils/global.constant.dart';
import 'package:equisplit_frontend/utils/user.shared_preference.dart';
import 'package:http/http.dart' as http;

class UserGroupService {
  Future<List<UserGroupEntity>?> getUserGroups() async {
    var client = http.Client();
    var userId = UserSharedPreference.getUserID();

    var uri = Uri.parse('${GlobalConstants.baseURL}/user/$userId/group');

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    var response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var body = response.body;
      return userGroupsFromJson(body);
    }

    return null;
  }
}
