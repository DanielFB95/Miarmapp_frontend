import 'package:flutter/material.dart';
import 'package:flutter_miarma/screens/login_screen.dart';
import 'package:flutter_miarma/screens/menu_screen.dart';
import 'package:flutter_miarma/screens/profile_screen.dart';
import 'package:flutter_miarma/screens/register_screen.dart';
import 'package:flutter_miarma/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiarmApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => const MenuScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/search': (context) => const SearchScreen()
      },
    );
  }
}
