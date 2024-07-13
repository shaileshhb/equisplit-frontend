import 'package:equisplit_frontend/extensions/capitalize.dart';
import 'package:equisplit_frontend/models/auth/user.dart';
import 'package:equisplit_frontend/models/group/user_group.dart';
import 'package:equisplit_frontend/screens/components/form_field.dart';
import 'package:equisplit_frontend/screens/skeleton/builder.dart';
import 'package:equisplit_frontend/services/group/group.dart';
import 'package:equisplit_frontend/utils/global.colors.dart';
import 'package:equisplit_frontend/utils/user.shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  List<User> selectedUsers = [];
  bool isLoaded = false;
  double transactionAmount = 0;
  int selectedRadio = 1;
  String? currentUserId = UserSharedPreference.getUserID();

  final amountController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  final double marginLeft = 10.0;
  final double marginBottom = 10.0;
  final double marginTop = 10.0;
  final double marginHorizontal = 10.0;
  final double marginVertical = 5.0;

  void validate() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
    }
  }

  setSelectedRadio(int value) {
    setState(() {
      selectedRadio = value;
    });
    updateUserAmount();
  }

  updateUserAmount() {
    List<User>? users = selectedUsers;

    if (transactionAmount > 0 && users.isNotEmpty) {
      double amount = transactionAmount / users.length;
      for (var i = 0; i < users.length; i++) {
        users[i].amount = double.parse(amount.toStringAsFixed(2));
        for (var i = 0; i < userGroups!.length; i++) {
          if (users[i].id == userGroups![i].user!.id) {
            setState(() {
              userGroups![i].user!.amount = users[i].amount;
            });
          }
        }
      }
    }

    for (var i = 0; i < userGroups!.length; i++) {
      print(
          "Found user ${userGroups![i].user!.id}, ${userGroups![i].user!.amount}");
    }

    setState(() {
      selectedUsers = users;
    });
  }

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
          getCurrentUser();
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

  getCurrentUser() {
    List<User> users = [];

    for (var i = 0; i < userGroups!.length; i++) {
      users.add(userGroups![i].user!);
      setState(() {
        userGroups![i].isChecked = true;
      });
    }

    setState(() {
      selectedUsers = users;
    });
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    transactionAmountWidget(),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RadioListTile(
                              value: 1,
                              title: const Text("Divide equally"),
                              groupValue: selectedRadio,
                              activeColor: GlobalColors.buttonColor,
                              onChanged: (value) {
                                if (value != null) {
                                  setSelectedRadio(value);
                                }
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              value: 2,
                              title: const Text("Divide manually"),
                              groupValue: selectedRadio,
                              activeColor: GlobalColors.buttonColor,
                              onChanged: (value) {
                                if (value != null) {
                                  setSelectedRadio(value);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: isLoaded ? userGroups!.length : 5,
                      itemBuilder: (context, index) {
                        return userGroups!.isNotEmpty
                            ? groupCard(index)
                            : const SkeletonCardBuilder();
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  CustomFormField transactionAmountWidget() {
    return CustomFormField(
      controller: amountController,
      hintText: "Enter amount",
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.digitsOnly
      ],
      validator: (amount) {
        if (amount!.isEmpty || !RegExp(r'[0-9]+$').hasMatch(amount)) {
          return "Invalid amount.";
        }
        return null;
      },
      onChange: (value) {
        print(value);
        setState(() {
          transactionAmount = double.parse(amountController.value.text);
        });
        updateUserAmount();
      },
    );
  }

  Container groupCard(int index) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: marginHorizontal,
        vertical: marginVertical,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Card(
              elevation: 0.2,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: userSelectionTile(index),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 55,
              child: userAmountField(index),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField userAmountField(int index) {
    return TextFormField(
      initialValue: userGroups![index].user!.amount != null
          ? userGroups![index].user!.amount.toString()
          : '0',
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.digitsOnly
      ],
      style: const TextStyle(
        fontSize: 19.0,
      ),
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 118, 118, 118),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        fillColor: Colors.grey.shade50,
        filled: true,
      ),
      validator: (amount) {
        if (amount!.isEmpty || !RegExp(r'[0-9]+$').hasMatch(amount)) {
          return "Invalid amount.";
        }
        if (int.parse(amountController.value.text) < int.parse(amount)) {
          return "Entered amount cannot be greater than transaction amount.";
        }
        return null;
      },
    );
  }

  CheckboxListTile userSelectionTile(int index) {
    return CheckboxListTile(
      title: Text(
        userGroups![index].user!.name.split(" ")[0].capitalize(),
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      value: userGroups![index].isChecked,
      onChanged: userGroups![index].user!.id == currentUserId
          ? null
          : (bool? isChecked) {
              setState(() {
                userGroups![index].isChecked = isChecked;
              });
            },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
