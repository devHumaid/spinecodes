import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskspinecodes/login/cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 5.h,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.lock, size: 80.sp, color: Colors.blue),
                        SizedBox(height: 20.h),
                        Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(height: 20.h),
                        TextFormField(
                          controller: cubit.emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? "Enter your email" : null,
                        ),
                        SizedBox(height: 15.h),
                        TextFormField(
                          controller: cubit.passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? "Enter your password" : null,
                        ),
                        SizedBox(height: 20.h),
                        ElevatedButton(
                          onPressed: () {
                            cubit.login();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 15.h),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 18.sp, color: Colors.white),
                          ),
                        ),
                        Text(
                          "Login",
                          style: TextStyle(fontSize: 18.sp, color: Colors.white),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to Forgot Password screen
                            },
                            child: Text("Google"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
