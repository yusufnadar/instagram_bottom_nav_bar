part of instagram_bottom_nav_bar;

class InstagramTabView extends StatefulWidget {
  final double? elevation;
  final BottomNavigationBarType? bottomNavigationBarType;
  final double? selectedFontSize;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? unselectedFontSize;
  final List<String> bottomBarLabels;
  final List<Widget> bottomBarIcons;
  final EdgeInsets? bottomNavigationBarItemPadding;
  final double? height;
  final Function(int)? onTap;
  final Color? backgroundColor;
  final double? iconSize;
  final List<Widget> pages;
  final IconThemeData? selectedIconTheme;
  final bool? showSelectedLabels;
  final bool? showUnselectedLabels;
  final bool? enableFeedback;
  final BottomNavigationBarLandscapeLayout? bottomNavigationBarLandscapeLayout;
  final MouseCursor? mouseCursor;
  final IconThemeData? unselectedIconTheme;

  const InstagramTabView({
    Key? key,
    this.elevation,
    this.bottomNavigationBarType,
    this.selectedFontSize,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.unselectedFontSize,
    required this.bottomBarLabels,
    required this.bottomBarIcons,
    this.bottomNavigationBarItemPadding,
    this.height,
    this.onTap,
    required this.pages,
    this.backgroundColor,
    this.iconSize,
    this.showSelectedLabels,
    this.showUnselectedLabels,
    this.selectedIconTheme,
    this.bottomNavigationBarLandscapeLayout,
    this.enableFeedback,
    this.mouseCursor,
    this.unselectedIconTheme,
  }) : super(key: key);

  @override
  State<InstagramTabView> createState() => _InstagramTabViewState();
}

class _InstagramTabViewState extends State<InstagramTabView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: widget.bottomBarLabels.length,
      vsync: this,
    );
    for (int i = 0; i < widget.bottomBarLabels.length; i++) {
      final key = GlobalKey<NavigatorState>(debugLabel: '${widget.pages[i]}');
      TabConsts.navigatorKeys.add(key);
      TabConsts.navigators.add(IndexedStackChild(
        child: Navigator(
          key: key,
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => widget.pages[i],
          ),
        ),
      ));
    }

    TabConsts.bottomBarItemList = List.generate(
      widget.bottomBarLabels.length,
      (index) => BottomNavigationBarItem(
        icon: Container(
          height: widget.height ?? 40,
          padding: widget.bottomNavigationBarItemPadding ??
              const EdgeInsets.only(bottom: 4.0),
          child: widget.bottomBarIcons[index],
        ),
        label: widget.bottomBarLabels[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: widget.elevation ?? 12,
          type: widget.bottomNavigationBarType ?? BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          selectedFontSize: widget.selectedFontSize ?? 8,
          backgroundColor: widget.backgroundColor ?? Colors.white,
          selectedLabelStyle: widget.selectedLabelStyle ??
              const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
          unselectedLabelStyle: widget.unselectedLabelStyle ??
              const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
          iconSize: widget.iconSize ?? 24,
          showUnselectedLabels: widget.showUnselectedLabels ?? true,
          showSelectedLabels: widget.showSelectedLabels ?? true,
          selectedIconTheme: widget.selectedIconTheme,
          landscapeLayout: widget.bottomNavigationBarLandscapeLayout,
          selectedItemColor: widget.selectedItemColor,
          unselectedItemColor: widget.unselectedItemColor,
          unselectedFontSize: widget.unselectedFontSize ?? 16,
          enableFeedback: widget.enableFeedback,
          mouseCursor: widget.mouseCursor,
          unselectedIconTheme: widget.unselectedIconTheme,
          onTap: widget.onTap ?? changeIndex,
          items: TabConsts.bottomBarItemList,
        ),
        body: ProsteIndexedStack(
          index: currentIndex,
          children: TabConsts.navigators,
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    setState(() {});
    var goBack =
        !await TabConsts.navigatorKeys[currentIndex].currentState!.maybePop();
    if (TabConsts.pageList.length == 1 && TabConsts.pageList.contains(0)) {
      if (goBack) {
        // if home page didn't go any page yet close app
        SystemNavigator.pop();
      }
    } else if (TabConsts.pageList.length == 1) {
      // if there is a tab without home page go home page
      currentIndex = 0;
      TabConsts.pageList = [0];
    } else {
      if (goBack) {
        // remove last tab from list and go before tab
        TabConsts.pageList.removeLast();
        currentIndex = TabConsts.pageList.last;
      }
    }
    return Future.value(false);
  }

  // change bottom bar index
  void changeIndex(int itemIndex) {
    setState(() {});
    if (itemIndex == currentIndex) {
      TabConsts.navigatorKeys[currentIndex].currentState?.popUntil(
        (route) => route.isFirst,
      );
    } else {
      currentIndex = itemIndex;
      if (TabConsts.pageList.length <= 2) {
        if (TabConsts.pageList.contains(currentIndex)) {
          TabConsts.pageList.remove(currentIndex);
          TabConsts.pageList.add(currentIndex);
        } else {
          TabConsts.pageList.add(currentIndex);
        }
      } else {
        TabConsts.pageList.removeAt(1);
        TabConsts.pageList.add(currentIndex);
      }
    }
  }
}
