import 'package:equisplit_frontend/extensions/capitalize.dart';
import 'package:equisplit_frontend/models/auth/invitation.dart';
import 'package:equisplit_frontend/models/error/error_response.dart';
import 'package:equisplit_frontend/screens/skeleton/builder.dart';
import 'package:equisplit_frontend/services/user/invitation.dart';
import 'package:equisplit_frontend/utils/global.colors.dart';
import 'package:equisplit_frontend/utils/toast.dart';
import 'package:flutter/material.dart';

class ViewInvitations extends StatefulWidget {
  const ViewInvitations({super.key});

  @override
  State<ViewInvitations> createState() => _ViewInvitationsState();
}

class _ViewInvitationsState extends State<ViewInvitations> {
  InvitationService service = InvitationService();
  bool isLoaded = false;
  final double marginLeft = 10.0;
  final double marginBottom = 10.0;
  final double marginTop = 10.0;
  final double marginHorizontal = 10.0;
  final double marginVertical = 5.0;
  List<Invitation>? invitations;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoaded = false;
      invitations = [];
    });
    getInvitations();
  }

  void getInvitations() async {
    try {
      var response = await service.getInvitations();
      setState(() {
        invitations = response;
      });
    } on CustomException catch (e) {
      ToastNoContext().showErrorToast(e.error);
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
        title: const Text("Your Invites"),
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
        child: isLoaded && invitations != null && invitations!.isEmpty
            ? const Center(
                child: SizedBox(
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "You don't have any invitations",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.buttonColor,
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              )
            : Container(
                margin: EdgeInsets.only(top: marginTop),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: isLoaded ? invitations!.length : 5,
                  itemBuilder: (context, index) {
                    return invitations!.isNotEmpty
                        ? invitationTile(index)
                        : const SkeletonCardBuilder();
                  },
                ),
              ),
      ),
    );
  }

  Card invitationTile(int index) {
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
          Card(
            elevation: 0.2,
            child: ListTile(
              title: Text(
                invitations![index].group!.name.capitalize(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: GlobalColors.buttonColor,
                  fontSize: 16.0,
                ),
              ),
              subtitle: Text(
                "Invited by: ${invitations![index].invitedByUser!.name.capitalize()}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: GlobalColors.buttonColor,
                  fontSize: 14.0,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.thumb_up_alt),
                onPressed: () {
                  print("accept clicked");
                },
              ),
              enabled: invitations![index].isAccepted == false,
            ),
          ),
        ],
      ),
    );
  }
}
