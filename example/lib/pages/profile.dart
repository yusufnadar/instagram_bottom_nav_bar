import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green.shade700,
      ),
      backgroundColor: Colors.green.shade700,
      body: Center(
        child: FutureBuilder(
          future: get(),
          builder: (context, snapshot) =>
              snapshot.data != null ? Text(snapshot.data) : Text(''),
        ),
      ),
    );
  }

  Future get() async {
    var res = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    return json.decode(res.body)['title'];
  }
}
