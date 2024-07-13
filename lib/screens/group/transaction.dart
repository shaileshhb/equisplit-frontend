import 'package:equisplit_frontend/extensions/capitalize.dart';
import 'package:equisplit_frontend/models/group/user_group.dart';
import 'package:equisplit_frontend/screens/skeleton/builder.dart';
import 'package:equisplit_frontend/services/group/group.dart';
import 'package:equisplit_frontend/utils/global.colors.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  final String groupId;
  final String groupName;

  const AddTransaction({
    super.key,
    required this.groupId,
    required this.groupName,
  });

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  List<UserGroupEntity>? userGroups = [];
  bool isLoaded = false;
  final double marginLeft = 10.0;
  final double marginBottom = 10.0;
  final double marginTop = 10.0;
  final double marginHorizontal = 10.0;
  final double marginVertical = 5.0;
  double transactionAmount = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      userGroups = [];
    });

    getUserGroups();
  }

  getUserGroups() async {
    try {
      var response = await UserGroupService().getGroupUsers(widget.groupId);
      if (response != null) {
        setState(() {
          userGroups = response;
        });
      }
    } catch (err) {
      print(err);
    } finally {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName.capitalize()),
        backgroundColor: GlobalColors.appBar,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
      ),
      body: SafeArea(
        child: isLoaded && userGroups != null && userGroups!.isEmpty
            ? const Center(
                child: SizedBox(
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Users could not be fetched",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                margin: EdgeInsets.only(top: marginTop),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: isLoaded ? userGroups!.length : 5,
                  itemBuilder: (context, index) {
                    return userGroups!.isNotEmpty
                        ? groupCard(index)
                        : const SkeletonCardBuilder();
                  },
                ),
              ),
      ),
    );
  }

  Card groupCard(int index) {
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
      child: CheckboxListTile(
        title: Text(
          userGroups![index].user!.name.capitalize(),
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        value: userGroups![index].isChecked,
        onChanged: (bool? isChecked) {
          setState(() {
            userGroups![index].isChecked = isChecked;
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
