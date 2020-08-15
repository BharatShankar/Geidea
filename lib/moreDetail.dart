import 'package:flutter/material.dart';
import 'package:geidea/moreDetails.dart';
import 'package:provider/provider.dart';

import 'MoreDetailsProvider.dart';

class MoreDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MoreDetailsProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
      ),
    );
  }
}
