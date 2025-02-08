part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashLoggedIn extends SplashState {}

final class SplashLoggedOut extends SplashState {}
