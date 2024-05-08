import 'package:flutter/material.dart';
import 'package:task_manager/presentation/UI/Screens/splash_screen.dart';

class TaskManager extends StatelessWidget {
   const TaskManager({super.key});

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      navigatorKey: navigationKey,
      home: const SplashScreen(),
      theme: ThemeData(
       inputDecorationTheme: const InputDecorationTheme(
         fillColor: Colors.white,
         filled: true,
         border: OutlineInputBorder(borderSide: BorderSide.none),
         contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
         isDense: true,
         hintStyle: TextStyle(
           fontSize: 16,
           color: Colors.grey,
         ),
         focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
       ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 32,
        ),
          titleMedium: TextStyle(
            fontSize: 16,
            color: Colors.grey
          ),
          titleSmall: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
            ),
        ),
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10),
              backgroundColor: Colors.green.shade400
          )
        ),

      ),
    );
  }
}
