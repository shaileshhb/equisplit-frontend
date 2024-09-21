import 'package:equisplit_frontend/extensions/capitalize.dart';
import 'package:equisplit_frontend/models/group/user_group.dart';
import 'package:equisplit_frontend/screens/components/bottom_navigation_bar.dart';
import 'package:equisplit_frontend/screens/components/button.dart';
import 'package:equisplit_frontend/screens/group/transaction.dart';
import 'package:equisplit_frontend/screens/skeleton/builder.dart';
import 'package:equisplit_frontend/screens/users/invite_users.dart';
import 'package:equisplit_frontend/services/group/group.dart';
import 'package:equisplit_frontend/services/transaction/transaction.dart';
import 'package:equisplit_frontend/services/transaction/user_balance.dart';
import 'package:equisplit_frontend/utils/global.colors.dart';
import 'package:flutter/material.dart';

class GroupDetails extends StatefulWidget {
  final String groupId;
  final String groupName;

  const GroupDetails({
    super.key,
    required this.groupId,
    required this.groupName,
  });

  @override
  State<GroupDetails> createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {
  final userGroupService = UserGroupService();
  List<UserBalance>? userBalances;
  List<UserGroupEntity>? groupUsers;
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
      userBalances = [];
    });
    getUserBalances();
  }

  void getGroupUsers() async {
    try {
      var response = await userGroupService.getGroupUsers(widget.groupId);
      if (response != null) {
        setState(() {
          groupUsers = response;
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

  void getUserBalances() async {
    try {
      var response =
          await UserTransactionService().getUserTransactions(widget.groupId);
      if (response != null) {
        setState(() {
          userBalances = response;
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

  void _navigateToInviteUsers(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InviteUserToGroup(
          groupId: widget.groupId,
          groupName: widget.groupName,
        ),
      ),
    );
  }

  void _navigateToAddTransaction(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTransaction(
          groupId: widget.groupId,
          groupName: widget.groupName,
        ),
      ),
    );
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
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: isLoaded && userBalances != null && userBalances!.isEmpty
            ? Center(
                child: SizedBox(
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Group details could not be fetched",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        buttonLabel: "Invite users",
                        onTap: () {
                          _navigateToInviteUsers(context);
                        },
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                margin: EdgeInsets.only(top: marginTop),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomButton(
                      buttonLabel: "Add new transaction",
                      onTap: () {
                        _navigateToAddTransaction(context);
                      },
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: isLoaded ? userBalances!.length : 5,
                      itemBuilder: (context, index) {
                        return userBalances!.isNotEmpty
                            ? groupCard(index)
                            : const SkeletonCardBuilder();
                      },
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      userBalances![index].user.name.capitalize(),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
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
                  'Amount: ${userBalances![index].amount}',
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
