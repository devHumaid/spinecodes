import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    style: const TextStyle(color: Colors.red, fontSize: 18)),
              );
            } else if (state is ProfileLoaded) {
              return _buildProfileUI(state.user);
            } else {
              return const Center(
                  child: Text("No profile data available",
                      style: TextStyle(fontSize: 18)));
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
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 10),

          // Name
          Text(
            user.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),

          // Email
          Text(
            user.email,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),

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

          const SizedBox(height: 20),

          // Edit Profile Button
          ElevatedButton.icon(
            onPressed: () {
            },
            icon: const Icon(Icons.edit),
            label: const Text("Logout"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              textStyle: const TextStyle(fontSize: 16),
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
      subtitle: Text(value, style: const TextStyle(fontSize: 16)),
    );
  }

  /// Divider
  Widget _buildDivider() {
    return const Divider(thickness: 1.2, color: Colors.grey);
  }
}
