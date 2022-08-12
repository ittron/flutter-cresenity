import 'package:fluttertoast/fluttertoast.dart' as fToast;

/// @author Suhardik Nirmansyah
/// @since  22/02/2022

class Toast {
  static show(String message) {
    fToast.Fluttertoast.showToast(
      msg: message,
    );
  }
}
