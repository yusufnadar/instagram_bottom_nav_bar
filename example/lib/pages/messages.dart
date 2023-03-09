import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Messages'),backgroundColor: Colors.purple.shade700,),
      backgroundColor: Colors.purple.shade700,
      body: Center(
        child: Text(
          'Messages',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
