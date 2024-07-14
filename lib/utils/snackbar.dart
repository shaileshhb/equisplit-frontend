import 'package:flutter/material.dart';

class SnackbarService {
  BuildContext context;
  Duration defaultDuration = const Duration(milliseconds: 3000);

  SnackbarService({required this.context});

  showSnackbar(
    Widget content,
    SnackBarAction? action,
    Duration? duration,
  ) {
    final snackBar = SnackBar(
      content: content,
      action: action,
      duration: duration ?? defaultDuration,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
