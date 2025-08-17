import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_passwords/auth/auth_exceptions.dart';

class Authgoogle {
  final googlesignin = GoogleSignIn();

  Future<UserCredential> signinwithgoogle() async {
    try {
      final GoogleSignInAccount? gUser = await googlesignin.signIn();
      if (gUser == null) {
        throw CouldntsigninWithgoogle;
      }
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (_) {
      throw CouldntsigninWithgoogle();
    }
  }

  Future<void> signoutfromgoogle() async {
    await FirebaseAuth.instance.signOut();
    await googlesignin.signOut();
  }
}
