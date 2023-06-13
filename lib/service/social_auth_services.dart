import 'dart:convert';
import 'dart:developer' as log;
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Authenticate {
  GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? firebaseUser;
  late final FirebaseAuth firebaseAuth;

  GoogleSignInAccount? get user => _user;

  Future<bool> googleSignInMethod() async {
    // final firebaseAuth = FirebaseAuth.instance.currentUser;
    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return false;
      } else {
        _user = googleUser;
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {
          log.log("token of google i ${credential.accessToken}");

          // RegisterViewModel.of(listen: false).socialLogin(
          //     email: firebaseAuth?.email ?? "",
          //     context: Keys.mainNavigatorKey.currentState!.context,
          //     token: credential.accessToken.toString(),
          //     userName: firebaseAuth?.displayName ?? "",
          //     providerName: "google",
          //     completion: (success) {
          //       if (success) {
          //         AppUtil.pushRoute(
          //             context: Keys.mainNavigatorKey.currentState!.context,
          //             route: MainScreen());
          //       }
          //     });
        });

        return true;
      }
    } on FirebaseAuthException catch (error) {
      debugPrint("Error in google sigin :::: $error");
      return false;
    }
  }

  Future googleLogOut() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) {
        log.log("Logged out of Google account");
      });
    } on FirebaseAuthException catch (e) {
      log.log(e.code);
    }
  }

  Future<UserCredential> facebookLogin() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken?.token ?? "");

    // Once signed in, return the UserCredential
    log.log(loginResult.status.toString());
    log.log(loginResult.message.toString());
    log.log(loginResult.accessToken.toString());
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  //FACEBOOK LOGIN
  // Future facebookLogin() async {
  //   final LoginResult result = await FacebookAuth.instance.login(
  //     permissions: [
  //       'email',
  //       'public_profile',
  //     ],
  //   );

  //   if (result.status == LoginStatus.success) {
  //     facebookToken = result.accessToken;

  //     final userData = await FacebookAuth.instance.getUserData();
  //     facebookUserData = userData;
  //   } else {
  //     log.log(result.status.toString());
  //     log.log(result.message.toString());
  //   }
  // }

  // APPLE SIGIN

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final Random random = Random.secure();

    return List.generate(length, (index) {
      charset[random.nextInt(charset.length)];
    }).join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<User> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    try {
      final appleCredentials = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      log.log(appleCredentials.authorizationCode);

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredentials.identityToken,
        rawNonce: rawNonce,
      );

      final authResult =
          await firebaseAuth.signInWithCredential(oauthCredential);

      final displayName =
          '${appleCredentials.givenName} ${appleCredentials.familyName}';
      final userEmail = '${appleCredentials.email}';

      firebaseUser = authResult.user;
      log.log(displayName);
      await firebaseUser!.updateDisplayName(displayName);

      await firebaseUser!.updateEmail(userEmail);

      return firebaseUser!;
    } catch (e) {}

    return firebaseUser!;
  }
}
