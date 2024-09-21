import 'package:equisplit_frontend/screens/group/view.dart';
import 'package:equisplit_frontend/screens/users/view_invitations.dart';
import 'package:flutter/material.dart';

void _navigateToViewGroups(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const ViewUserGroup()));
}

void _navigateToViewInvitations(BuildContext context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const ViewInvitations()));
}

BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        label: 'My Groups',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.mail_lock_outlined),
        label: 'Invites',
      ),
    ],
    onTap: (index) {
      if (index == 0) {
        _navigateToViewGroups(context);
        return;
      }

      if (index == 1) {
        _navigateToViewInvitations(context);
        return;
      }
    },
  );
}
