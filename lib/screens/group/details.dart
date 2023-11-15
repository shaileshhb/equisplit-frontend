import 'package:equisplit_frontend/models/group/user_group.dart';
import 'package:equisplit_frontend/screens/skeleton/builder.dart';
import 'package:equisplit_frontend/services/group/group.dart';
import 'package:equisplit_frontend/utils/global.colors.dart';
import 'package:flutter/material.dart';

class GroupDetails extends StatefulWidget {
  final int groupId;
  const GroupDetails({
    super.key,
    required this.groupId,
  });

  @override
  State<GroupDetails> createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {
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
    getGroupDetails();
  }

  void getGroupDetails() async {
    try {
      var response = await UserGroupService().getGroupDetails(widget.groupId);
      if (response != null) {
        setState(() {
          userGroups = response;
        });
      }
    } catch (e) {
      print(e);
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
        title: const Text("Home"),
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
                        "Group details could not be fetched",
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: marginLeft, top: marginTop),
                child: Text(
                  userGroups![index].user!.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
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
