import 'package:clothshop/features/authintication/presentation/screens/signup_view.dart';
import 'package:clothshop/features/home/presentation/screens/home_view.dart';
import 'package:clothshop/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:clothshop/features/notifications/presentation/screens/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Salmon extends StatefulWidget {
  const Salmon({Key? key}) : super(key: key);

  @override
  _SalmonState createState() => _SalmonState();
}

class _SalmonState extends State<Salmon> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeView(),
    BlocProvider.value(
      value: sl<NotificationsCubit>(),
      child: const NotificationView(),
    ),
    const HomeView(),
    const HomeView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text(""),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.notifications),
            title: const Text(""),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite),
            title: const Text(""),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text(""),
          ),
        ],
      ),
    );
  }
}