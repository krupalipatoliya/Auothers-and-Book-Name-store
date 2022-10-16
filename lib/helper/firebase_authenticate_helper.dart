import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseAuthenticationHelper {
  FireBaseAuthenticationHelper._();

  static final FireBaseAuthenticationHelper fireBaseAuthenticationHelper =
      FireBaseAuthenticationHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future signInAnonymously() async {
    try {
      final userCredential = await firebaseAuth.signInAnonymously();
      print("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  SignIn({required String emailAddress, required String password}) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );


    print("Succesfully");

    // Once signed in, return the UserCredential
    return await firebaseAuth.signInWithCredential(credential);
  }


  signOut () async {
    await firebaseAuth.signOut();
  }

}
