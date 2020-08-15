import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geidea/demoModel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<DemoModel> foodItemsList = [];
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future getUsers() {
    var url =
        "https://rss.itunes.apple.com/api/v1/sa/ios-apps/top-free/all/100/explicit.json";
    return http.get(url);
  }

  Future<List<DemoModel>> getFoodItems() async {
    String url =
        'https://rss.itunes.apple.com/api/v1/sa/ios-apps/top-free/all/100/explicit.json';
    Response response = await get(url);
    // sample info available in response
    int statusCode = response.statusCode;
    if (statusCode == 200) {
      print("response json $statusCode");
      String json = response.body;
      print(json);
      Map<String, dynamic> responseData = jsonDecode(response.body);
      Map userMap = jsonDecode(response.body);
      var user = DemoModel.fromJson(userMap);
      print(user.feed.results[0].artistName);
      // print(responseData['feed']);
      // print("this is my data");
      // print(foodItemsList);

      return foodItemsList;
    }
    //loaderVisibility = false;
    return foodItemsList;
  }

  @override
  Widget build(BuildContext context) {
    getFoodItems();

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: foodItemsList.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new Text(foodItemsList[index].feed.title ?? "");
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
