import 'package:flutter/material.dart';

Widget errorFetchingData(redditProvider) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.sentiment_dissatisfied, size: 100.0),
        SizedBox(
          height: 20.0,
        ),
        Text("Error Fetching Data"),
        SizedBox(height: 15.0),
        RaisedButton(
            textColor: Colors.white,
            color: Colors.blueAccent,
            onPressed: () {
              redditProvider.transactionWithSP();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.refresh),
                SizedBox(width: 10.0),
                Text("Refresh")
              ],
            )),
      ],
    ),
  );
}

Widget dataLoading() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      SizedBox(
        width: 50.0,
        height: 50.0,
        child: CircularProgressIndicator(),
      ),
      SizedBox(height: 20.0),
      Text("Loading"),
    ],
  ));
}

Widget noDataFound() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Icon(Icons.sentiment_neutral, size: 100),
      SizedBox(height: 20),
      Text("No Data Found")
    ],
  ));
}
