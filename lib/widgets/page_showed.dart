part of instagram_bottom_nav_bar;

class PageShowed extends StatelessWidget {
  final Widget child;
  final int index;

  const PageShowed({Key? key, required this.child, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (TabConsts.pagesShowedMap['alreadyShowed$index'] == true) {
      return child;
    } else {
      return const SizedBox();
    }
  }
}
