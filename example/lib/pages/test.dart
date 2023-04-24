import 'package:flutter/material.dart';
import 'package:instagram_bottom_nav_bar/instagram_tab_view.dart';

import 'home_page.dart';
import 'profile.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InstagramTabView(
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
      dividerWidth: 40,
      isDivider: true,
      dividerHeight: 3,
      dividerMargin: 5,
      //middleHeight: 40,
      //height: 70,
      selectedIconHeight: 20,
      //middleColor: Colors.blue,
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
          page: Profile(),
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
    );
  }
}
