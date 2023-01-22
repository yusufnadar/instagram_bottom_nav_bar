import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          Navigator.of(context,rootNavigator: false).push(MaterialPageRoute(builder: (context)=>HomePageDetail()));
        }, child: Text('Go Detail')),
      ),
    );
  }
}

class HomePageDetail extends StatelessWidget {
  const HomePageDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

