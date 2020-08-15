import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geidea/MoreDetailsProvider.dart';
import 'package:provider/provider.dart';
import 'package:link_text/link_text.dart';

class MoreDetails extends StatefulWidget {
  @override
  _MoreDetailsState createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  @override
  Widget build(BuildContext context) {
    final detailedPageData = Provider.of<MoreDetailsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.network(detailedPageData.appsDetails.artworkUrl100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Name : "),
                Text(detailedPageData?.appsDetails?.name ?? ""),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(detailedPageData?.appsDetails?.artistName ?? ""),
            ),
            //Text(detailedPageData.appsDetails.url),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinkText(
                text: detailedPageData?.appsDetails?.artistUrl ?? "",
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(detailedPageData?.appsDetails?.releaseDate ?? ""),
            ),
            generes(detailedPageData),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinkText(
                text: detailedPageData.appsDetails.url,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(detailedPageData.appsDetails.copyright),
            )
          ],
        ),
      ),
    );
  }

  Widget generes(MoreDetailsProvider detailedPageData) {
    var allGeneres = detailedPageData.appsDetails.genres;
    List<Widget> generesArray = [];

    for (var genere in allGeneres) {
      generesArray.add(Text(genere.name));
    }
    return Container(
      child: Column(
        children: generesArray,
      ),
    );
  }
}
