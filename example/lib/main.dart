import 'package:bottom_bar/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:instagram_bottom_nav_bar/instagram_tab_view.dart';
import 'package:instagram_bottom_nav_bar/widget/icon_type.dart';
import 'pages/home_page.dart';

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
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade400,
        backgroundColor: Colors.white,
        // Default is Colors.white
        elevation: 12,
        // Default elevation is 12,
        showSelectedLabels: false,
        // Default showSelectedLabels is false,
        showUnselectedLabels: false,
        // Default showUnselectedLabels is false
        iconSize: 24,
        // Default iconSize is 24,
        bottomNavigationBarType: BottomNavigationBarType.fixed,
        iconType: IconType.icon,
        dividerWidth: 20,
        isDivider: true,
        middleColor: Colors.red,
        items: [
          InstagramTabItem(
            label: 'Home Page',
            page: HomePage(),
            icon: Icons.add,
          ),
          InstagramTabItem(
            label: 'Home Page',
            page: HomePage(),
            icon: Icons.add,
          ),
          InstagramTabItem(
            label: 'Home Page',
            page: HomePage(),
            icon: Icons.add,
            settings: (settings) {
              switch (settings.name) {
                default:
                  return MaterialPageRoute(
                    builder: (context) => Profile(),
                  );
              }
            },
          )
        ],
      ),
    );
  }
}
