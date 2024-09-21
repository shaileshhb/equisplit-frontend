import 'package:equisplit_frontend/extensions/capitalize.dart';
import 'package:equisplit_frontend/models/auth/invitation.dart';
import 'package:equisplit_frontend/models/auth/user.dart';
import 'package:equisplit_frontend/models/error/error_response.dart';
import 'package:equisplit_frontend/screens/components/bottom_navigation_bar.dart';
import 'package:equisplit_frontend/screens/components/button.dart';
import 'package:equisplit_frontend/screens/skeleton/builder.dart';
import 'package:equisplit_frontend/services/user/auth.dart';
import 'package:equisplit_frontend/services/user/invitation.dart';
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
  bool isLoaded = false;
  final double marginLeft = 10.0;
  final double marginBottom = 10.0;
  final double marginTop = 10.0;
  final double marginHorizontal = 10.0;
  final double marginVertical = 5.0;

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

  List<User>? selectedUsers = [];

  void onInviteClick() async {
    selectedUsers = [];
    String errors = "";
    for (var i = 0; i < users!.length; i++) {
      if (users![i].isChecked!) {
        selectedUsers!.add(users![i]);
        try {
          Invitation invitation = Invitation(
            groupId: widget.groupId,
            userId: users![i].id!,
            isAccepted: false,
          );

          await InvitationService().addInvitation(invitation);
        } on CustomException catch (e) {
          if (errors.isEmpty) {
            errors += "${users![i].name}: ${e.error.capitalize()}";
          } else {
            errors += "\n${users![i].name}: ${e.error.capitalize()}";
          }
        }
      }
    }

    if (errors.isNotEmpty) {
      ToastNoContext().showErrorToast(errors);
      return;
    }

    getUsers();
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
            Container(
              margin: EdgeInsets.only(top: marginTop),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: users!.length,
                    itemBuilder: (context, index) {
                      return users!.isNotEmpty
                          ? usersTile(index)
                          : const SkeletonCardBuilder();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CustomButton(
              onTap: () {
                onInviteClick();
              },
              buttonLabel: "Invite",
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  Card usersTile(int index) {
    return Card(
      elevation: 0.2,
      margin: EdgeInsets.symmetric(
          horizontal: marginHorizontal, vertical: marginVertical),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CheckboxListTile(
            title: Text(users![index].name.capitalize()),
            controlAffinity: ListTileControlAffinity.leading,
            value: users![index].isChecked,
            onChanged: (value) {
              setState(() {
                users![index].isChecked = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
