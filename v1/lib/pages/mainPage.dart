import 'package:flutter/material.dart';
import '../viewModels/mainVM.dart';
import '../models/events.dart';

class MainPage extends StatefulWidget {
  final MainViewModel viewModel;

  MainPage({Key key, @required this.viewModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  var _requestReceiverSink;

  @override
  void initState() {
    _requestReceiverSink = widget.viewModel.requestReceiverSink;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getPage(context);
  }

  Widget _getPage(BuildContext context) {
    const double leftRightMargin = 10;
    return Container(
      color: Colors.grey[900],
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Container(width: leftRightMargin),
          Expanded(
            child: Column(
              children: <Widget>[
                _getHeader(),
                Container(height: 10),
                Divider(indent: 1, endIndent: 1),
                Container(height: 10),
                _getBody(context),
                Container(height: 10),
              ],
            ),
          ),
          Container(width: leftRightMargin),
        ],
      ),
    );
  }

  Widget _getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(height: 10),
        Container(width: 10),
        // Container(
        //     width: 500, child: Container(child: Text("Please close drawer"))),
      ],
    );
  }

  Widget _getBody(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(height: 10),
          SizedBox(
            width: 480,
            height: 60,
            child: FlatButton(
              color: Colors.grey[100],
              child: Text(
                "Go to the map page",
                style: TextStyle(color: Colors.black, fontSize: 28),
              ),
              onPressed: () {
                _requestReceiverSink.add(MainEvent(type: "route", data: "map"));
              },
            ),
          ),
          Container(height: 30),
        ],
      ),
    );
  }
}
