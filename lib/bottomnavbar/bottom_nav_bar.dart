import 'package:flutter/material.dart';
import 'package:taskspinecodes/addtask/addtask.dart';
import 'package:taskspinecodes/bottomnavbar/cubit/bottomnavbar_cubit.dart';
import 'package:taskspinecodes/category/category.dart';
import 'package:taskspinecodes/home/home_page.dart';
import 'package:taskspinecodes/profile/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> _pages = [
    HomePage(),
    AddTask(),
    Category(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomnavbarCubit(),
      child: BlocBuilder<BottomnavbarCubit, BottomnavbarState>(
        builder: (context, state) {
          final cubit = context.read<BottomnavbarCubit>();
          return Scaffold(
            body: _pages[cubit.selectedIndex], // Show selected page
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.selectedIndex, // Highlight selected icon
              onTap: (index) {
                setState(() {
                  cubit.updateIndex(index);
                });
              },
              selectedItemColor: Colors.blue, // Active icon color
              unselectedItemColor: Colors.grey, // Inactive icon color
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: "Categories"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
              ],
            ),
          );
        },
      ),
    );
  }
}
