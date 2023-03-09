import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page'),backgroundColor: Colors.red.shade700,),
      backgroundColor: Colors.red.shade700,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context,rootNavigator: false).push(MaterialPageRoute(builder: (context)=>HomePageDetail()));
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade900),
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
      appBar: AppBar(title: Text('Detail'),backgroundColor: Colors.amber.shade700,),
    );
  }
}
