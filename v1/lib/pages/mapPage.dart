import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../viewModels/mapVM.dart';
import '../models/events.dart';

class MapPage extends StatefulWidget {
  final MapViewModel viewModel;

  MapPage({Key key, @required this.viewModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MapPageState();
  }
}

class MapPageState extends State<MapPage> {
  var _requestReceiverSink;
  MapEvent _data;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> _polylineCoordinates = [];
  // PolylinePoints _polylinePoints = PolylinePoints();

  static final CameraPosition _kOceanside = CameraPosition(
    // target: LatLng(37.42796133580664, -122.085749655962), // Google Flex
    // target: LatLng(33.4026327, -84.5933258), // Atlanta
    target: LatLng(33.138035, -117.365032),
    zoom: 12,
  );

  @override
  void initState() {
    widget.viewModel.responseSenderStream.listen(_responseHandler);
    _requestReceiverSink = widget.viewModel.requestReceiverSink;
    _requestReceiverSink.add(MapEvent(type: "start"));
    _data = MapEvent();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _responseHandler(var ev) {
    switch (ev.type) {
      case "update":
        _data = ev;
        break;
      default:
        break;
    }
    _setMapPins();
    _setPolylines();
    setState(() {});
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
              color: Colors.grey[700],
              child: Text(
                "Go to the main page",
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
              onPressed: () {
                _requestReceiverSink.add(MapEvent(type: "route", data: "main"));
              },
            ),
          ),
          Container(height: 10),
          Container(height: 500, width: 400, child: _getGmap()),
        ],
      ),
    );
  }

  Widget _getGmap() {
    return GoogleMap(
      myLocationButtonEnabled: true,
      compassEnabled: true,
      tiltGesturesEnabled: false,
      markers: _markers,
      polylines: _polylines,
      mapType: MapType.normal,
      initialCameraPosition: _kOceanside,
      onMapCreated: (GoogleMapController controller) {
        debugPrint("created");
        _controller.complete(controller);
      },
    );
  }

  void _setMapPins() {
    setState(() {
      // source pin
      _data.listLatLan?.forEach((latLng) {
        _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: latLng,
          //  icon: sourceIcon
        ));
      });
    });
  }

  void _setPolylines() async {
    if (_data.listLatLan != null && _data.listLatLan.isNotEmpty) {
      _data.listLatLan.forEach((LatLng point) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: _polylineCoordinates);
      _polylines.add(polyline);
    });
  }
}
