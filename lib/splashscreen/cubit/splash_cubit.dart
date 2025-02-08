import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    checkLoginStatus(); // Call checkLoginStatus automatically
  }

  Future<void> checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate loading

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');

    if (userId != null && userId.isNotEmpty) {
      emit(SplashLoggedIn());
    } else {
      emit(SplashLoggedOut());
    }
  }
}
