part of instagram_bottom_nav_bar;

class TabConsts {
  static List<BottomNavigationBarItem> bottomBarItemList = [];

  static List<int> pageList = [0];

  static List<GlobalKey<NavigatorState>> navigatorKeys =
      <GlobalKey<NavigatorState>>[];

  static List<IndexedStackChild> navigators = <IndexedStackChild>[];

  static void clear() {
    bottomBarItemList.clear();
    navigatorKeys.clear();
    navigators.clear();
    pageList = [0];
  }
}
