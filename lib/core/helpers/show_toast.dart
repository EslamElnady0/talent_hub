
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({
  required String toastMsg,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: toastMsg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: getState(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastStates { error, success, warining, loading }

Color getState(ToastStates state) {
  switch (state) {
    case ToastStates.error:
      return Colors.red;
    case ToastStates.success:
      return Colors.green;
    case ToastStates.warining:
      return Colors.orange;
    case ToastStates.loading:
      return Colors.black;
  }
}
