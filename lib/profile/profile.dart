import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskspinecodes/profile/cubit/profile_cubit.dart';
import 'package:taskspinecodes/model/user_model.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit(context)..fetchUserProfile(), 
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: true,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileFailure) {
              return Center(
                child: Text(state.error,
                    style:  TextStyle(color: Colors.red, fontSize: 18.sp)),
              );
            } else if (state is ProfileLoaded) {
              return _buildProfileUI(state.user);
            } else {
              return  Center(
                  child: Text("No profile data available",
                      style: TextStyle(fontSize: 18.sp)));
            }
          },
        ),
      ),
    );
  }

  /// Profile UI Widget
  Widget _buildProfileUI(UserModel user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Profile Avatar
           CircleAvatar(
            radius: 50.r,
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.person, size: 50.sp, color: Colors.white),
          ),
           SizedBox(height: 10.h),

          // Name
          Text(
            user.name,
            style:  TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
           SizedBox(height: 5.h),

          // Email
          Text(
            user.email,
            style:  TextStyle(fontSize: 16.sp, color: Colors.grey),
          ),
           SizedBox(height: 20.h),

          // Profile Details Card
          Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  _buildProfileItem(Icons.phone, "Phone", user.phone),
                  _buildDivider(),
                  _buildProfileItem(Icons.location_on, "Location", user.place),
                  IconButton(onPressed: (){}, icon: Icon(Icons.logout ))
                ],
              ),
            ),
          ),

           SizedBox(height: 20.h),

          // Edit Profile Button
          ElevatedButton.icon(
            onPressed: () {
            },
            icon: const Icon(Icons.edit),
            label: const Text("Logout"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              padding:  EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
              textStyle:  TextStyle(fontSize: 16.sp),
            ),
          ),
        ],
      ),
    );
  }

  /// Profile Item Widget
  Widget _buildProfileItem(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value, style:  TextStyle(fontSize: 16.sp)),
    );
  }

  /// Divider
  Widget _buildDivider() {
    return const Divider(thickness: 1.2, color: Colors.grey);
  }
}
