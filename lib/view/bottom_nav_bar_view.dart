// ignore_for_file: must_be_immutable

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

  // bottom margin between text and icon
  final EdgeInsets? bottomNavigationBarItemPadding;

  // height of icon area
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

  // png, jpg or svg choose
  final IconType iconType;

  // height of selected icon
  final double? selectedIconHeight;

  // height of unselected icon
  final double? unSelectedIconHeight;

  // width of selected icon
  final double? selectedIconWidth;

  // width of unselected icon
  final double? unSelectedIconWidth;

  // selected icon size
  final double? selectedIconSize;

  // unselected icon size
  final double? unSelectedIconSize;

  // is divider
  final bool? isDivider;

  // divider width
  final double? dividerWidth;

  // divider height
  final double? dividerHeight;

  // divider color
  final Color? dividerColor;

  // space between divider and icon
  final double? dividerMargin;

  // divider radius
  final double? dividerRadius;

  // middle icon color
  final Color? middleColor;

  // middle icon height
  final double? middleHeight;

  final int? currentIndex;

  // work inside onTap function
  final Function()? onTapWith;

  Function({Widget child})? topOfBottomNavigationBar;

  InstagramTabView({
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
    this.isDivider,
    this.dividerWidth,
    this.dividerHeight,
    this.dividerColor,
    this.dividerMargin,
    this.dividerRadius,
    this.middleColor,
    this.currentIndex,
    this.middleHeight,
    this.onTapWith,
    this.topOfBottomNavigationBar,
  }) : super(key: key);

  static void clear() {
    TabConsts.bottomBarItemList.clear();
    TabConsts.navigatorKeys.clear();
    TabConsts.navigators.clear();
    TabConsts.pageList = [0];
  }

  @override
  State<InstagramTabView> createState() => _InstagramTabViewState();
}

class _InstagramTabViewState extends State<InstagramTabView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  // current index is 0 at first and you start at first page
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // if you want to start from different tab
    if (widget.currentIndex != null) {
      currentIndex = widget.currentIndex!;
    }

    // create a controller for control your tab
    tabController = TabController(
      length: widget.items.length,
      vsync: this,
    );

    for (int i = 0; i < widget.items.length; i++) {
      // create a global key to control your navigator widget
      // and the navigator widget control your route and key
      final key =
          GlobalKey<NavigatorState>(debugLabel: '${widget.items[i].page}');

      // we are adding all navigator keys to list
      TabConsts.navigatorKeys.add(key);

      // if after click the tab you want to go another page in the same tab
      // we are creating the settings
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
        // if there is just a page and no navigator any page we can define
        // just that page
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
    // we are adding tabs in build because when change some tab
    // we should see immediately
    generateTabs();
    if (widget.topOfBottomNavigationBar == null) {
      widget.topOfBottomNavigationBar = ({Widget? child}) {
        return SizedBox(child: child);
      };
    }
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        bottomNavigationBar: widget.topOfBottomNavigationBar!(
          child: BottomNavigationBar(
            elevation: widget.elevation ?? 12,
            type:
                widget.bottomNavigationBarType ?? BottomNavigationBarType.fixed,
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
        ),
        // we used that widget because the keep sized box before the
        // come that tab
        body: ProsteIndexedStack(
          index: currentIndex,
          children: TabConsts.navigators,
        ),
      ),
    );
  }

  void generateTabs() {
    TabConsts.bottomBarItemList = List.generate(
      widget.items.length,
      (index) {
        // if middle tab should different color we can control that
        var middleColor;
        var middleHeight;
        if (widget.middleColor != null) {
          // if items length equal three we find the middle item
          // if items length equal five we find the middle item
          if (widget.items.length == 3) {
            if (index == 1) {
              middleColor = widget.middleColor;
            }
          }
          if (widget.items.length == 5) {
            if (index == 2) {
              middleColor = widget.middleColor;
            }
          }
        }
        if (widget.middleHeight != null) {
          // if items length equal three we find the middle item
          // if items length equal five we find the middle item
          if (widget.items.length == 3) {
            if (index == 1) {
              middleHeight = widget.middleHeight;
            }
          }
          if (widget.items.length == 5) {
            if (index == 2) {
              middleHeight = widget.middleHeight;
            }
          }
        }
        late Widget child;
        if (widget.iconType == IconType.pngOrJpg) {
          // if we use an asset
          if (widget.isDivider == true) {
            // if we want to see divider under the tab
            child = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  widget.items[index].icon,
                  // we can control color of selected and unselected item
                  color: middleColor == null
                      ? index == currentIndex
                          ? widget.selectedIconTheme?.color
                          : widget.unselectedIconTheme?.color
                      : middleColor,
                  // we can control width of selected and unselected item
                  width: index == currentIndex
                      ? widget.selectedIconWidth
                      : widget.unSelectedIconWidth,
                  // we can control height of selected and unselected item
                  height: middleHeight == null
                      ? index == currentIndex
                          ? widget.selectedIconHeight
                          : widget.unSelectedIconHeight
                      : widget.middleHeight,
                ),
                if (index == currentIndex && middleColor == null)
                  // if there is a divider it shows here
                  Container(
                    // divider width
                    width: widget.dividerWidth ?? 15,

                    // divider height
                    height: widget.dividerHeight ?? 2,
                    decoration: BoxDecoration(
                      // divider color
                      color: widget.dividerColor ?? Colors.black,

                      // divider radius
                      borderRadius:
                          BorderRadius.circular(widget.dividerRadius ?? 5),
                    ),
                    // divider margin
                    margin: EdgeInsets.only(top: widget.dividerMargin ?? 5),
                  )
                else
                  // it should be because when is no divider one tab it should be
                  // the same height each other
                  SizedBox(
                    height: (widget.dividerHeight ?? 2) +
                        (widget.dividerMargin ?? 5),
                  )
              ],
            );
          } else {
            // if there is no divider here
            child = Image.asset(
              widget.items[index].icon,
              color: middleColor == null
                  ? index == currentIndex
                      ? widget.selectedIconTheme?.color
                      : widget.unselectedIconTheme?.color
                  : middleColor,
              width: index == currentIndex
                  ? widget.selectedIconWidth
                  : widget.unSelectedIconWidth,
              height: middleHeight == null
                  ? index == currentIndex
                      ? widget.selectedIconHeight
                      : widget.unSelectedIconHeight
                  : widget.middleHeight,
            );
          }
        } else if (widget.iconType == IconType.svg) {
          // if we use svg icon
          if (widget.isDivider == true) {
            // if we have a divider
            child = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  widget.items[index].icon,
                  color: middleColor == null
                      ? index == currentIndex
                          ? widget.selectedIconTheme?.color
                          : widget.unselectedIconTheme?.color
                      : middleColor,
                  width: index == currentIndex
                      ? widget.selectedIconWidth
                      : widget.unSelectedIconWidth,
                  height: middleHeight == null
                      ? index == currentIndex
                          ? widget.selectedIconHeight
                          : widget.unSelectedIconHeight
                      : widget.middleHeight,
                ),
                if (index == currentIndex && middleColor == null)
                  Container(
                    width: widget.dividerWidth ?? 15,
                    height: widget.dividerHeight ?? 2,
                    decoration: BoxDecoration(
                      color: widget.dividerColor ?? Colors.black,
                      borderRadius:
                          BorderRadius.circular(widget.dividerRadius ?? 5),
                    ),
                    margin: EdgeInsets.only(top: widget.dividerMargin ?? 5),
                  )
                else
                  SizedBox(
                    height: (widget.dividerHeight ?? 2) +
                        (widget.dividerMargin ?? 5),
                  )
              ],
            );
          } else
            child = Padding(
              padding: EdgeInsets.only(top: widget.dividerMargin ?? 5),
              child: SvgPicture.asset(
                widget.items[index].icon,
                color: middleColor == null
                    ? index == currentIndex
                        ? widget.selectedIconTheme?.color
                        : widget.unselectedIconTheme?.color
                    : middleColor,
                width: index == currentIndex
                    ? widget.selectedIconWidth
                    : widget.unSelectedIconWidth,
                height: middleHeight == null
                    ? index == currentIndex
                        ? widget.selectedIconHeight
                        : widget.unSelectedIconHeight
                    : widget.middleHeight,
              ),
            );
        } else if (widget.iconType == IconType.icon) {
          // if we use a normal icon
          if (widget.isDivider == true) {
            child = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.items[index].icon,
                  color: middleColor == null
                      ? index == currentIndex
                          ? widget.selectedIconTheme?.color
                          : widget.unselectedIconTheme?.color
                      : middleColor,
                  size: middleHeight == null
                      ? index == currentIndex
                          ? widget.selectedIconSize
                          : widget.unSelectedIconSize
                      : widget.middleHeight,
                ),
                if (index == currentIndex && middleColor == null)
                  Container(
                    width: widget.dividerWidth ?? 15,
                    height: widget.dividerHeight ?? 2,
                    decoration: BoxDecoration(
                      color: widget.dividerColor ?? Colors.black,
                      borderRadius:
                          BorderRadius.circular(widget.dividerRadius ?? 5),
                    ),
                    margin: EdgeInsets.only(top: widget.dividerMargin ?? 5),
                  )
                else
                  SizedBox(
                    height: (widget.dividerHeight ?? 2) +
                        (widget.dividerMargin ?? 5),
                  )
              ],
            );
          } else {
            child = Icon(
              widget.items[index].icon,
              color: middleColor == null
                  ? index == currentIndex
                      ? widget.selectedIconTheme?.color
                      : widget.unselectedIconTheme?.color
                  : middleColor,
              size: middleHeight == null
                  ? index == currentIndex
                      ? widget.selectedIconSize
                      : widget.unSelectedIconSize
                  : widget.middleHeight,
            );
          }
        }
        return BottomNavigationBarItem(
          // height of icon area
          // To adjust the space around the icon
          icon: Container(
            height: widget.height ?? 40,
            padding: widget.bottomNavigationBarItemPadding ??
                const EdgeInsets.only(bottom: 4.0),
            //child: widget.items[index].icon,
            child: child,
          ),
          label: widget.items[index].label,
        );
      },
    );
  }

  // about the navigator pop
  Future<bool> onWillPop() async {
    setState(() {});
    // if we want to go from a page we check the state of key
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
    if (widget.onTapWith != null) {
      widget.onTapWith!();
    }
    setState(() {});
    if (itemIndex == currentIndex) {
      // if we click the same tab when we use it goes the first page of tab
      TabConsts.navigatorKeys[currentIndex].currentState?.popUntil(
        (route) => route.isFirst,
      );
    } else {
      currentIndex = itemIndex;
      // if the pageList length less than 2
      // if the tab contain the index we click remove and add the end of list
      // if does not contain we just add end of list
      if (TabConsts.pageList.length <= 2) {
        if (TabConsts.pageList.contains(currentIndex)) {
          TabConsts.pageList.remove(currentIndex);
          TabConsts.pageList.add(currentIndex);
        } else {
          TabConsts.pageList.add(currentIndex);
        }
      } else {
        // if the pageList length more than 2
        // we remove first tab without home page
        // and add this tab to end of list
        TabConsts.pageList.removeAt(1);
        TabConsts.pageList.add(currentIndex);
      }
    }
  }
}
