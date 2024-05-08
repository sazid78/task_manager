import 'package:flutter/material.dart';
import 'package:task_manager/presentation/UI/Screens/add_new_task_screen.dart';
import 'package:task_manager/presentation/UI/Screens/task/in_progress_task_screen.dart';
import 'package:task_manager/presentation/UI/Screens/task/new_task_screen.dart';
import 'package:task_manager/presentation/UI/Screens/task/cancelled_task_screen.dart';
import 'package:task_manager/presentation/UI/Screens/task/completed_task_screen.dart';
import 'package:task_manager/presentation/UI/Screens/task/todo_task_screen.dart';


class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;

 final List<Widget> _screens = const [
     AddTaskScreen(),
     TodoTaskScreen(),
     InProgressTaskScreen(),
     CompletedTaskScreen(),
     CancelledTaskScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.add_card), label: "Add"),
            BottomNavigationBarItem(icon: Icon(Icons.watch_later_outlined), label: "Todo"),
            BottomNavigationBarItem(
                icon: Icon(Icons.incomplete_circle_rounded), label: "In Progress"),
            BottomNavigationBarItem(icon: Icon(Icons.done_outline), label: "Completed"),
            BottomNavigationBarItem(icon: Icon(Icons.free_cancellation_outlined), label: "Canceled"),
          ],
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: (index) {
            _selectedIndex = index;
            setState(() {});
          },
        ),
        body: _screens[_selectedIndex],
      ),
    );
  }
}
