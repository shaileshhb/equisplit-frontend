import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastNoContext {
  void showSuccessToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.TOP_RIGHT,
      backgroundColor: Colors.greenAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void showErrorToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP_RIGHT,
      fontSize: 18.0,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
    );
  }

  void cancelToast() {
    Fluttertoast.cancel();
  }
}
