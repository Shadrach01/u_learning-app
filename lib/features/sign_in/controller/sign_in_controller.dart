import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ulearning_app/common/utils/constants.dart';
import 'package:ulearning_app/features/sign_in/provider/sign_in_notifier.dart';
import 'package:ulearning_app/features/sign_in/repo/sign_in_repo.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/main.dart';
import '../../../common/global_loader/global_loader.dart';
import '../../../common/models/user.dart';
import '../../../common/widgets/popup_messages.dart';

class SignInController {
  // WidgetRef ref;

  SignInController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> handleSignIn(WidgetRef ref) async {
    var state = ref.read(signInNotifierProvider);
    String email = state.email;
    String password = state.password;

    emailController.text = email;
    passwordController.text = password;
    if (state.email.isEmpty || email.isEmpty) {
      toastInfo("Your email is empty");
      return;
    }

    if (state.password.isEmpty || password.isEmpty) {
      toastInfo("Your password is empty");
      return;
    }

    ref.read(appLoaderProvider.notifier).setLoaderValue(true);

    try {
      final credential = await SignInRepo.firebaseSignIn(email, password);

      if (credential.user == null) {
        toastInfo("user not found");
        return;
      }

      if (!credential.user!.emailVerified) {
        toastInfo("You must verify your email address");
        return;
      }

      var user = credential.user;
      if (user != null) {
        String? displayName = user.displayName;
        String? email = user.email;
        String? id = user.uid;
        String? photoUrl = user.photoURL;

        LoginRequestEntity loginRequestEntity = LoginRequestEntity();
        loginRequestEntity.avatar = photoUrl;
        loginRequestEntity.name = displayName;
        loginRequestEntity.email = email;
        loginRequestEntity.open_id = id;
        loginRequestEntity.type = 1;
        asyncPostAllData(loginRequestEntity);
        if (kDebugMode) {
          print("user is logged in");
        }
      } else {
        toastInfo("Login error");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        toastInfo("User not found");
      } else if (e.code == 'wrong-password') {
        toastInfo("Your password is wrong");
      } else if (e.code == 'invalid-credential') {
        toastInfo("The details you entered are invalid");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    ref.read(appLoaderProvider.notifier).setLoaderValue(false);
  }

  void asyncPostAllData(LoginRequestEntity loginRequestEntity) {
// talk to server

    // have local storage
    try {
      // try to remember user info
      Global.storageService.setString(
          AppConstants.STORAGE_USER_PROFILE_KEY,
          jsonEncode({
            'name': 'Shadrach',
            'email': 'shadrachsamuel2000090@gmail.com',
            'age': 24
          }));
      Global.storageService
          .setString(AppConstants.STORAGE_USER_TOKEN_KEY, "123456");

      navKey.currentState
          ?.pushNamedAndRemoveUntil("/application", (route) => false);
      // navigator.pushNamed("/application");
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    //redirect to new page
  }
}
