import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert' show json;
import './models/image_model.dart';
import './widgets/image_list.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

// https://jsonplaceholder.typicode.com

class AppState extends State<App> {
  int counter = 0;
  final List<ImageModel> images = [];

  void fetchImage() async {
    counter += 1;
    final response =
        await get('https://jsonplaceholder.typicode.com/photos/$counter');
    final imageModel = new ImageModel.fromJson(json.decode(response.body));

    setState(() {
      images.add(imageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ImageList(images),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchImage,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Let\'s see some images!'),
        ),
      ),
    );
  }
}
