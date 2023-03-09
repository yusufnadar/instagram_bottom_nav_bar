part of instagram_bottom_nav_bar;

class InstagramTabView extends StatefulWidget {
  final double? elevation;
  final BottomNavigationBarType? bottomNavigationBarType;
  final double? selectedFontSize;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final double? unselectedFontSize;
  final EdgeInsets? bottomNavigationBarItemPadding;
  final double? height;
  final Function(int)? onTap;
  final Color? backgroundColor;
  final double? iconSize;
  final IconThemeData? selectedIconTheme;
  final bool? showSelectedLabels;
  final bool? showUnselectedLabels;
  final bool? enableFeedback;
  final BottomNavigationBarLandscapeLayout? bottomNavigationBarLandscapeLayout;
  final MouseCursor? mouseCursor;
  final IconThemeData? unselectedIconTheme;
  final List<InstagramTabItem> items;
  final IconType iconType;
  final double? selectedIconHeight;
  final double? unSelectedIconHeight;
  final double? selectedIconWidth;
  final double? unSelectedIconWidth;
  final double? selectedIconSize;
  final double? unSelectedIconSize;

  const InstagramTabView({
    Key? key,
    this.elevation,
    this.bottomNavigationBarType,
    this.selectedFontSize,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    this.unselectedFontSize,
    this.bottomNavigationBarItemPadding,
    this.height,
    this.onTap,
    this.backgroundColor,
    this.iconSize,
    this.showSelectedLabels,
    this.showUnselectedLabels,
    this.selectedIconTheme,
    this.bottomNavigationBarLandscapeLayout,
    this.enableFeedback,
    this.mouseCursor,
    this.unselectedIconTheme,
    required this.items,
    required this.iconType,
    this.selectedIconHeight,
    this.unSelectedIconHeight,
    this.selectedIconWidth,
    this.unSelectedIconWidth,
    this.selectedIconSize,
    this.unSelectedIconSize,
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
      length: widget.items.length,
      vsync: this,
    );
    for (int i = 0; i < widget.items.length; i++) {
      final key =
          GlobalKey<NavigatorState>(debugLabel: '${widget.items[i].page}');
      TabConsts.navigatorKeys.add(key);
      if (widget.items[i].settings != null) {
        TabConsts.navigators.add(
          IndexedStackChild(
            child: Navigator(
              initialRoute: widget.items[i].initialRoute,
              key: key,
              onGenerateRoute: widget.items[i].settings,
            ),
          ),
        );
      } else {
        TabConsts.navigators.add(
          IndexedStackChild(
            child: Navigator(
              key: key,
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => widget.items[i].page,
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TabConsts.bottomBarItemList = List.generate(widget.items.length, (index) {
      late Widget child;
      if (widget.iconType == IconType.pngOrJpg) {
        child = Image.asset(
          widget.items[index].icon,
          color: index == currentIndex
              ? widget.selectedItemColor
              : widget.unselectedItemColor,
          width: index == currentIndex
              ? widget.selectedIconWidth
              : widget.unSelectedIconWidth,
          height: index == currentIndex
              ? widget.selectedIconHeight
              : widget.unSelectedIconHeight,
        );
      } else if (widget.iconType == IconType.svg) {
        child = SvgPicture.asset(
          widget.items[index].icon,
          colorFilter: ColorFilter.mode(
            index == currentIndex
                ? widget.selectedItemColor
                : widget.unselectedItemColor,
            BlendMode.srcIn,
          ),
          width: index == currentIndex
              ? widget.selectedIconWidth
              : widget.unSelectedIconWidth,
          height: index == currentIndex
              ? widget.selectedIconHeight
              : widget.unSelectedIconHeight,
        );
      } else if (widget.iconType == IconType.icon) {
        child = Icon(
          widget.items[index].icon,
          color: index == currentIndex
              ? widget.selectedItemColor
              : widget.unselectedItemColor,
          size: index == currentIndex
              ? widget.selectedIconSize
              : widget.unSelectedIconSize,
        );
      }
      return BottomNavigationBarItem(
        icon: Container(
          height: widget.height ?? 40,
          padding: widget.bottomNavigationBarItemPadding ??
              const EdgeInsets.only(bottom: 4.0),
          //child: widget.items[index].icon,
          child: child,
        ),
        label: widget.items[index].label,
      );
    });
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
          unselectedFontSize: widget.unselectedFontSize ?? 8,
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
