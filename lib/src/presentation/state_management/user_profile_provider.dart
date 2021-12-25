import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:task2/src/data/repositories/data_repository.dart';

class UserProvider with ChangeNotifier, DiagnosticableTreeMixin {
  User? _user;
  bool _load=false;
  String _name='';

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  bool get load => _load;

  set load(bool value) {
    _load = value;
    notifyListeners();
  }

  User? get user => _user;

  set user(User? value) {
    _user = value;
  }
  getUser()async{
    _load =true;
   user=await FirebaseAuth.instance.currentUser;
   _load =false;
   notifyListeners();

  }
}
