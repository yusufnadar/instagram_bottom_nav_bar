import 'package:flutter/material.dart';
import 'package:instagram_bottom_nav_bar/instagram_tab_view.dart';
import 'test.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.red.shade700,
      ),
      backgroundColor: Colors.red.shade700,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            InstagramTabView.clear();
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (context) => Test()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade900,
          ),
          child: Text('Go Detail'),
        ),
      ),
    );
  }
}

class HomePageDetail extends StatelessWidget {
  const HomePageDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade700,
      appBar: AppBar(
        title: Text('Detail'),
        backgroundColor: Colors.amber.shade700,
      ),
    );
  }
}
