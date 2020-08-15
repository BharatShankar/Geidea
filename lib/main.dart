import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geidea/demoModel.dart';
import 'package:geidea/moreDetails.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'MoreDetailsProvider.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MoreDetailsProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: ''),
        routes: {
          Constants.ROUTE_DETAILS: (context) => MoreDetails(),
        },
      ),
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
  List<Results> appsDetails = [];

  Future getFoodItems() async {
    Response response = await get(ApiUrls.getUrl);

    int statusCode = response.statusCode;
    if (statusCode == 200) {
      print("response json $statusCode");
      String json = response.body;
      print(json);
      Map userMap = jsonDecode(response.body);
      var user = DemoModel.fromJson(userMap);
      print(user.feed.results[0].artistName);
      appsDetails = user.feed.results;
      setState(() {});
    }
  }

  @override
  void initState() {
    getFoodItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final detailedPageData = Provider.of<MoreDetailsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: appsDetails.length ?? 1,
          itemBuilder: (BuildContext ctxt, int index) {
            return GestureDetector(
              onTap: () {
                // on clicking each item acton implemented here
                detailedPageData.sendValuesToDetailsPage(appsDetails[index]);
                Navigator.of(context).pushNamed(Constants.ROUTE_DETAILS);
              },
              child: new Container(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Image.network(appsDetails[index].artworkUrl100),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          LabelNames.NAME,
                          style: TextStyle(
                              color: ColorNames.fontGreyColor,
                              fontSize: FontSizes.labelTextSize,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(appsDetails[index]?.name ?? "",
                            style: TextStyle(
                                color: ColorNames.fontGreyColor,
                                fontSize: FontSizes.labelTextSize,
                                fontWeight: FontWeight.normal)),
                      ],
                    ),
                    Text(
                      LabelNames.GENERS,
                      style: TextStyle(
                          color: ColorNames.fontGreyColor,
                          fontSize: FontSizes.labelTextSize,
                          fontWeight: FontWeight.bold),
                    ),
                    generes(index),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          LabelNames.RELEASE_DATE,
                          style: TextStyle(
                              color: ColorNames.fontGreyColor,
                              fontSize: FontSizes.labelTextSize,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(appsDetails[index]?.releaseDate ?? "")
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget generes(int mainIndex) {
    var allGeneres = appsDetails[mainIndex].genres;
    List<Widget> generesArray = [];

    for (var genere in allGeneres) {
      generesArray.add(Text(genere.name));
    }
    return Container(
      //height: 50,
      child: Column(
        children: generesArray,
      ),
    );
  }
}
