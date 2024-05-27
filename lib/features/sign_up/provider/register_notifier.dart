import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ulearning_app/features/sign_up/provider/register_state.dart';

class RegisterNotifier extends StateNotifier<RegisterState> {
  RegisterNotifier() : super(RegisterState());

  void onUserNameChange(String name) {
    state = state.copyWith(userName: name);
  }

  void onUserEmailChange(String email) {
    state = state.copyWith(email: email);
  }

  void onUserPasswordChange(String password) {
    state = state.copyWith(password: password);
  }

  void onUserRePasswordChange(String password) {
    state = state.copyWith(rePassword: password);
  }
}

final registerNotifierProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>(
        (ref) => RegisterNotifier());
