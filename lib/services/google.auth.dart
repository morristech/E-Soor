import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

//! Error Handling Docs weren't finished, yet

class GoogleAuthSignIn {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<GoogleSignInAuthentication> _getGoogleSignInAuthAccount(
      GoogleSignInAccount googleSignInAccount) async {
    final GoogleSignInAuthentication googleSignInAuth =
        await googleSignInAccount.authentication;
    if (googleSignInAuth != null && googleSignInAuth != null) {
      return googleSignInAuth;
    } else {
      throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token');
    }
  }

  Future<AuthResult> _getAuthResult(
      GoogleSignInAuthentication googleSignInAuth) async {
    try {
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleSignInAuth.accessToken,
          idToken: googleSignInAuth.idToken);
      final AuthResult authResult =
          await _firebaseAuth.signInWithCredential(credential);

      return authResult;
    } on PlatformException catch (signInWithCredentialFirebaseError) {
      throw PlatformException(
        code: signInWithCredentialFirebaseError.code,
        message: signInWithCredentialFirebaseError.message,
      );
    }
  }

  Future<void> _registerUserOnFirebase(AuthResult authResult) async {
    final FirebaseUser firebaseAuthCredentialUser = authResult.user;
    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    if (firebaseAuthCredentialUser.uid != currentUser.uid) {
      throw PlatformException(
          code: 'ERROR_GOOGLE_AUTH_USER_MISMATCH',
          message:
              "Google auth user doesn't match the current logged Firebse user");
    }
  }

  //! [SOLVED]: can return PlatformException (sign_in_failed) {not in docs}
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication _googleSignInAccount =
          await _getGoogleSignInAuthAccount(googleSignInAccount);
      final AuthResult _authResult = await _getAuthResult(_googleSignInAccount);
      await _registerUserOnFirebase(_authResult);
      return;
    }
    throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
  }

  Future<void> signOutGoogleAndFirebase() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  // Future<void> signOutOnlyGoogle() async {
  //   await _googleSignIn.signOut();
  // }
}
