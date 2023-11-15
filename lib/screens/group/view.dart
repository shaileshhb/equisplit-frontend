import 'package:equisplit_frontend/models/group/user_group.dart';
import 'package:equisplit_frontend/screens/components/button.dart';
import 'package:equisplit_frontend/screens/group/create.dart';
import 'package:equisplit_frontend/screens/skeleton/builder.dart';
import 'package:equisplit_frontend/services/group/group.dart';
import 'package:equisplit_frontend/utils/global.colors.dart';
import 'package:flutter/material.dart';

class ViewUserGroup extends StatefulWidget {
  const ViewUserGroup({super.key});

  @override
  State<ViewUserGroup> createState() => _ViewUserGroupState();
}

class _ViewUserGroupState extends State<ViewUserGroup> {
  List<UserGroupEntity>? userGroups;
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
      userGroups = [];
    });
    getUserGroups();
  }

  getUserGroups() async {
    try {
      var response = await UserGroupService().getUserGroups();
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

  void _navigateToCreateGroup(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CreateGroup()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: GlobalColors.appBar,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
      ),
      body: SafeArea(
        child: isLoaded && userGroups != null && userGroups!.isEmpty
            ? Center(
                child: SizedBox(
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "You have not created groups yet!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      const SizedBox(height: 15),
                      CustomButton(
                        onTap: () {
                          _navigateToCreateGroup(context);
                        },
                        buttonLabel: "Create your group",
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // ListTile(
              //   title: Text("Title 1"),
              // ),
              Container(
                margin: EdgeInsets.only(left: marginLeft, top: marginTop),
                child: Text(userGroups![index].group!.name.toUpperCase()),
              ),
              // Container(
              //   margin: const EdgeInsets.only(right: 10.0, top: 10.0),
              //   child: const Text("data2"),
              // ),
            ],
          ),
          const Divider(
            color: GlobalColors.cardBorder,
            thickness: 0.8,
          ),
          Container(
            margin: EdgeInsets.only(bottom: marginBottom, left: marginLeft),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Outgoing amount: ${userGroups![index].outgoingAmount}',
                  style: const TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                Text(
                  'Incoming amount: ${userGroups![index].incomingAmount}',
                  style: const TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
