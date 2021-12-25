import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class LoginProvider with ChangeNotifier, DiagnosticableTreeMixin {
  TextEditingController _email=TextEditingController(),_password=TextEditingController();
  bool _load=false;

  bool get load => _load;

  set load(bool value) {
    _load = value;
    notifyListeners();
  }

  TextEditingController get email => _email;

  set email(TextEditingController value) {
    _email = value;
  }

  get password => _password;

  set password(value) {
    _password = value;
  }
}