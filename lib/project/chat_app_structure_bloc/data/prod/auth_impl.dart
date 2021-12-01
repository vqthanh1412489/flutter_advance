import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/auth_repository.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/domain/models/auth_user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthLocalImpl extends AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<AuthUser?> getAuthUser() async {
    final user = _auth.currentUser;

    print('object user $user');
    if (user != null) {
      return AuthUser(user.uid);
    }

    return null;
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
    return;
  }

  @override
  Future<AuthUser?> signIn() async {
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print(e);
          throw Exception('account-exists-with-different-credential');
        } else if (e.code == 'invalid-credential') {
          print(e);
          throw Exception('invalid-credential');
        }
      } catch (e) {
        print(e);
        throw Exception('Login Error');
      }
    }

    if (user != null) {
      return AuthUser(user.uid);
    }

    return null;
  }
}
