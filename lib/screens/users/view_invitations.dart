import 'package:equisplit_frontend/extensions/capitalize.dart';
import 'package:equisplit_frontend/models/auth/invitation.dart';
import 'package:equisplit_frontend/models/error/error_response.dart';
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
      invitations = [];
    });
  }

  void getInvitations() async {
    try {
      var response = await service.getInvitations();
      setState(() {
        invitations = response;
      });
    } on CustomException catch (e) {
      ToastNoContext().showErrorToast(e.error);
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
        child: Text("This are your invitations"),
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
          Text(invitations![index].user!.name.capitalize()),
        ],
      ),
    );
  }
}
