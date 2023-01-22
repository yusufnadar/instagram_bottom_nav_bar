import 'package:flutter/material.dart';
import 'package:instagram_bottom_nav_bar/instagram_tab_view.dart';
import 'pages/home_page.dart';
import 'pages/messages.dart';
import 'pages/profile.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InstagramTabView(
        bottomBarLabels: [
          'Home Page',
          'Messages',
          'Profile',
        ],
        bottomBarIcons: [
          Icon(Icons.home),
          Icon(Icons.message),
          Icon(Icons.person),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade400,
        backgroundColor: Colors.white,
        // Default is Colors.white
        elevation: 12,
        // Default elevation is 12,
        showSelectedLabels: true,
        // Default showSelectedLabels is true,
        showUnselectedLabels: true,
        // Default showUnselectedLabels is true
        iconSize: 24,
        // Default iconSize is 24,
        bottomNavigationBarType: BottomNavigationBarType.fixed,
        pages: [
          HomePage(),
          Messages(),
          Profile(),
        ],
      ),
    );
  }
}
