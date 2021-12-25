import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SignupProvider with ChangeNotifier, DiagnosticableTreeMixin {
  TextEditingController _email=TextEditingController(),_password=TextEditingController(),_name=TextEditingController(),_confirmPassword=TextEditingController();

  TextEditingController get email => _email;
  bool _load=false;

  bool get load => _load;

  set load(bool value) {
    _load = value;
    notifyListeners();
  }

  set email(TextEditingController value) {
    _email = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }

  get password => _password;

  set password(value) {
    _password = value;
  }

  get confirmPassword => _confirmPassword;

  set confirmPassword(value) {
    _confirmPassword = value;
  }
}