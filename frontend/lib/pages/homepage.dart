import 'package:flutter/material.dart';
import 'package:flutter_task/api%20service/shared_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter"),
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            SharedService.logout(context);
          }, icon: Icon(Icons.logout,
          color: Colors.black,))
        ],
      ),
    );
  }
}
