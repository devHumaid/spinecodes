import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskspinecodes/login/login_page.dart';
import 'package:taskspinecodes/model/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.context) : super(ProfileInitial()) {
    fetchUserProfile();
  }
  BuildContext context;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchUserProfile() async {
    try {
      emit(ProfileLoading());

      // Retrieve user ID from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id');

      if (userId == null) {
        emit(ProfileFailure("User ID not found in storage"));
        return;
      }

      // Fetch user profile from Firestore using stored UID
      DocumentSnapshot userDoc =
          await _firestore.collection('user').doc(userId).get();

      if (!userDoc.exists) {
        emit(ProfileFailure("User data not found"));
        return;
      }

      UserModel userModel =
          UserModel.fromMap(userDoc.data() as Map<String, dynamic>);

      emit(ProfileLoaded(userModel));
    } catch (e) {
      emit(ProfileFailure("Failed to fetch profile: $e"));
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut(); // Firebase sign out
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_id'); // Remove user ID from storage

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.redAccent, content: Text("Logged out")));

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage())); // Go to login
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Logout failed")));
    }
  }
}
