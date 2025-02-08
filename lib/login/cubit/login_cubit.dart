import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskspinecodes/bottomnavbar/bottom_nav_bar.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.context) : super(LoginInitial());
  BuildContext context;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      emit(LoginError("Email and password cannot be empty"));
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email and password cannot be empty")));
      return;
    }

    try {
      emit(LoginLoading());

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Store uid in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', userCredential.user!.uid);

      emit(LoginSuccess(userCredential.user!));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.greenAccent, content: Text("Login success")));

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => BottomNavBar()));
    } on FirebaseAuthException catch (e) {
      emit(LoginError(e.message ?? "Login failed"));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? "Login failed")));
    }
  }
}
