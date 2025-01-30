import 'package:flutter/material.dart';

SnackBar snackBarError({required String errMessage}) {
  return const SnackBar(
    content: Text("errMessage",
        style:
            TextStyle(color: Colors.white, backgroundColor: Colors.red)),
    duration: Duration(seconds: 3),
  );
}
