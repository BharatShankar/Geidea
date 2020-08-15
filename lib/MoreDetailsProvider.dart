import 'package:flutter/material.dart';

import 'demoModel.dart';

class MoreDetailsProvider with ChangeNotifier {
  Results appsDetails;

  void sendValuesToDetailsPage(Results resultsData) {
    appsDetails = resultsData;
    notifyListeners();
  }
}
