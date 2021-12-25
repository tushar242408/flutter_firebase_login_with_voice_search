import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataRepository {
  // this is the user object to handle all the user related calls
  final UserCollection userNode = UserCollection();
}

class UserCollection {
  // creating the collection instance
  final CollectionReference _userCollection =
  FirebaseFirestore.instance.collection('users');

  storeName(String id, String name) async {
    await _userCollection.doc('$id').set({
      'name': name
    });
  }
deleteData(String uid)async{
  _userCollection.doc(uid).delete().then((_){

  });
}
 Future<String?> getName(String id) async {
    var _data = await _userCollection.doc('$id').get();
    print(_data['name']);
    return await _data['name'];

  }
  storeBookmark(String id, Map data) async {
    await _userCollection.doc('$id').set({
      'bookmark': FieldValue.arrayUnion([data])
    },SetOptions(merge: true));
  }
  deleteBookmark(String id, Map data) async {
    await _userCollection.doc('$id').set({
      'bookmark': FieldValue.arrayRemove([data])
    },SetOptions(merge: true));
  }
  getBookmark(String id) async {
 var _data = await _userCollection.doc('$id').get();
 return await _data['bookmark']??[]; }

}


class AuthUser {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signInEmail(String email, String password) async {
    try{
      UserCredential result =
      await auth.signInWithEmailAndPassword(email: email, password: password);
      final User user = result.user!;

      return user;
    }
    catch (e){
      return null;

    }

  }
  Future resetPassword(String email) async {
    try{
      await auth.sendPasswordResetEmail(email: email);
      return true;
    }
    catch (e){
      return false;

    }

  }
  Future signOut() async {
    FirebaseAuth.instance.signOut();
  }
  Future deleteAccount() async {
    UserCollection().deleteData(FirebaseAuth.instance.currentUser!.uid);
    await FirebaseAuth.instance.currentUser!.delete();

  }
  Future<User?> signUp(String email,String password,String name) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;
if(user != null) {
  UserCollection().storeName(user.uid,name);
}
      return user;
    }
    catch(e){

    }
  }

}