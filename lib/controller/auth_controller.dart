import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naturehike/model/user_model.dart';

class AuthController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  bool get success => false;

  //login
  Future<UserModel?> signWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        final DocumentSnapshot snapshot =
            await userCollection.doc(user.uid).get();

        final UserModel currentUser = UserModel(
          name: snapshot['name'] ?? '',
          email: user.email ?? '',
          cabang: snapshot['cabang'] ?? '',
          uId: user.uid,
        );

        return currentUser;
      }
    } catch (e) {
      print('Error signing in: $e');
    }
    return null;
  }

  //register
}
