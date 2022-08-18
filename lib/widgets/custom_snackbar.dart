import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

void showCustomSnackBar(String message, BuildContext context,
    {bool isError = true}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: isError ? Colors.red : Colors.green,
    content: Text(message),
    duration: Duration(milliseconds: 600),
  ));
}

void showBotToast(String message, BuildContext context, {bool isError = true}) {
  BotToast.showSimpleNotification(
      title: message,
      titleStyle: TextStyle(color: Colors.white),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: Duration(milliseconds: 600),
      hideCloseButton: true);
}
