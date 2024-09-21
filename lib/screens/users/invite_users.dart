import 'package:equisplit_frontend/extensions/capitalize.dart';
import 'package:equisplit_frontend/models/auth/user.dart';
import 'package:equisplit_frontend/models/error/error_response.dart';
import 'package:equisplit_frontend/screens/components/button.dart';
import 'package:equisplit_frontend/services/auth/auth.dart';
import 'package:equisplit_frontend/utils/global.colors.dart';
import 'package:equisplit_frontend/utils/toast.dart';
import 'package:flutter/material.dart';

class InviteUserToGroup extends StatefulWidget {
  final String groupId;
  final String groupName;

  const InviteUserToGroup({
    super.key,
    required this.groupId,
    required this.groupName,
  });

  @override
  State<InviteUserToGroup> createState() => _InviteUserToGroupState();
}

class _InviteUserToGroupState extends State<InviteUserToGroup> {
  List<User>? users;

  @override
  void initState() {
    super.initState();
    setState(() {
      users = [];
    });

    getUsers();
  }

  void getUsers() async {
    try {
      Map<String, dynamic> queryParams = {
        "groupIdNI": widget.groupId,
      };

      var response = await AuthenticationService().getUsers(queryParams);
      if (response != null) {
        setState(() {
          users = response;
        });
      }
    } on CustomException catch (e) {
      ToastNoContext().showErrorToast(e.error.capitalize());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invite users"),
        backgroundColor: GlobalColors.appBar,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: DropdownButtonFormField(
                items: users
                    ?.map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name.capitalize()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {},
                hint: const Text("Select users to be invited"),
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  fillColor: Color.fromRGBO(250, 250, 250, 1),
                  filled: true,
                  // hintText: hintText,
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomButton(
              onTap: () {
                print("inviting selected users");
              },
              buttonLabel: "Invite",
            ),
          ],
        ),
      ),
    );
  }
}
