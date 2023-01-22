import 'package:flutter/material.dart';

class IndexedStackChild {
  final bool preload;

  final Widget child;

  IndexedStackChild({this.preload = false, required this.child});
}

class ProsteIndexedStack extends StatefulWidget {
  final int index;

  final AlignmentGeometry alignment;

  final TextDirection? textDirection;

  final List<IndexedStackChild> children;

  final StackFit sizing;

  ProsteIndexedStack({
    Key? key,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.sizing = StackFit.loose,
    this.index = 0,
    this.children = const <IndexedStackChild>[],
  }) : super(key: key);

  @override
  _ProsteLazyIndexedStackState createState() => _ProsteLazyIndexedStackState();
}

class _ProsteLazyIndexedStackState extends State<ProsteIndexedStack> {
  late List<Widget> _widgets;

  late List<bool> _widgetState;

  @override
  void initState() {
    super.initState();
    _widgets = List.generate(
      widget.children.length,
      (index) => index == widget.index || widget.children[index].preload
          ? widget.children[index].child
          : SizedBox.shrink(),
    );
    _widgetState = List.generate(widget.children.length,
        (index) => index == widget.index || widget.children[index].preload);
  }

  @override
  void didUpdateWidget(covariant ProsteIndexedStack oldWidget) {
    if (!_widgetState[widget.index]) {
      _widgetState[widget.index] = true;
      _widgets[widget.index] = widget.children[widget.index].child;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      children: _widgets,
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
      index: widget.index,
    );
  }
}
