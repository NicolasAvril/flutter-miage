import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;
Future<bool> signIn(String email, String password) async {
  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    print("Connexion réussie");
    return true;
  } on FirebaseAuthException catch (e) {
    return false;
  }
}
