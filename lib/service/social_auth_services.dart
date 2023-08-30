import 'dart:convert';
import 'dart:developer' as log;
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/user_defaults.dart';
import 'package:safe/constants/keys.dart';
import 'package:safe/screens/UI/dashboard/dashboard.dart';
import 'package:safe/screens/UI/payment/payment_view.dart';
import 'package:safe/screens/UI/user_details/userDetails.dart';
import 'package:safe/screens/controllers/registration/registeration_viewmodel.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Authenticate {
  GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? firebaseUser;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  GoogleSignInAccount? get user => _user;

  Future<bool> googleSignInMethod() async {
    // final firebaseAuth = FirebaseAuth.instance.currentUser;
    try {
      GoogleSignInAccount? googleUser = await  GoogleSignIn(scopes: ['profile', 'email']).signIn();

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

          // RegistrationViewModel().socialLogin(
          //     email: firebaseAuth.currentUser?.email ?? "",
          //     context: Keys.mainNavigatorKey.currentState!.context,
          //     token: credential.accessToken.toString(),
          //     userName: firebaseAuth.currentUser?.displayName ?? "",
          //     providerName: "google",
          //     completion: (success) {
          //       if (success) {
          //         AppUtil.pushRoute(
          //             pushReplacement: true,
          //             context: Keys.mainNavigatorKey.currentState!.context,
          //             route: const UserDetailsView(isFromLogin: true,));
          //       }
          //     });
            RegistrationViewModel().socialLogin(
          email: firebaseAuth.currentUser?.email ?? "",
          context: Keys.mainNavigatorKey.currentState!.context,
          token: credential.accessToken.toString(),
          userName: firebaseAuth.currentUser?.displayName ?? "",
          providerName: "google",
           completion: (check, form, isPayment) async {
                                  // showToaster(context);
                                  if (check) {
                                    if (form == 1 && isPayment == 1) {
                                       await  UserDefaults.setIsFormPosted("1");
                                      AppUtil.pushRoute(
                                        context: Keys.mainNavigatorKey.currentState!.context,
                                        route: const DashboardView(),
                                        pushReplacement: true
                                      );
                                    } else if (form == 1 && isPayment == 0) {
                                       await  UserDefaults.setIsFormPosted("1");
                                      AppUtil.pushRoute(
                                        context: Keys.mainNavigatorKey.currentState!.context,
                                        route: const PaymentView(),
                                      );
                                    } else {
                                      AppUtil.pushRoute(
                                        context: Keys.mainNavigatorKey.currentState!.context,
                                        pushReplacement: true,
                                        route: const UserDetailsView(
                                          isFromLogin: true,
                                        ),
                                      );
                                    }
                                  }
                                });
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

 // FACEBOOK LOGIN
 

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
    } catch (e) {
      log.log(
        e.toString(),
      );
    }

    return firebaseUser!;
  }
}
