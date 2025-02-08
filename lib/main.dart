import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskspinecodes/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taskspinecodes/splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
            useMaterial3: true,
            textTheme: Typography.englishLike2018.apply(
              fontSizeFactor: 1.sp,
              bodyColor: Colors.black,
              displayColor: Colors.black,
            ),
          ),
          home: child,
        );
      },
      child: SplashScreen(),
    );
  }
}
