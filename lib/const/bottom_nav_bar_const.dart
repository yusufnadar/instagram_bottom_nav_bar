part of instagram_bottom_nav_bar;

class TabConsts {
  static List<BottomNavigationBarItem> bottomBarItemList = [];

  static List<int> pageList = [0];

  static Map<String, dynamic> pagesShowedMap = {};

  static const List<String> bottomBarLabels = [];

  static const List<IconData> bottomBarIcons = [];

  static List<GlobalKey<NavigatorState>> navigatorKeys =
      <GlobalKey<NavigatorState>>[];

  static dynamic pages = [];
}
