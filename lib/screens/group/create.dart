import 'package:equisplit_frontend/models/group/group.dart';
import 'package:equisplit_frontend/screens/components/button.dart';
import 'package:equisplit_frontend/screens/components/form_field.dart';
import 'package:equisplit_frontend/screens/home/dashboard.dart';
import 'package:equisplit_frontend/services/group/group.dart';
import 'package:equisplit_frontend/utils/global.colors.dart';
import 'package:equisplit_frontend/utils/user.shared_preference.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final nameController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  void validate() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      createGroup(context);
    }
  }

  void createGroup(context) async {
    try {
      var group = Group(
        name: nameController.text,
        createdBy: UserSharedPreference.getUserID()!,
      );

      var response = await UserGroupService().createGroup(group);

      if (response) {
        _navigateToDashboard(context);
        formGlobalKey.currentState!.reset();
      }
    } catch (e) {
      print(e);
    }
  }

  void _navigateToDashboard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Dashboard(
          selectedIndex: 0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group"),
        backgroundColor: GlobalColors.appBar,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formGlobalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 50),
                  Text(
                    "Add some text related to creating groups",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomFormField(
                    controller: nameController,
                    hintText: "Enter group name",
                    validator: (name) {
                      if (name!.isEmpty ||
                          !RegExp(r'[a-z A-Z 0-9]+$').hasMatch(name)) {
                        return "Invalid group name.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    onTap: validate,
                    buttonLabel: "Create",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
