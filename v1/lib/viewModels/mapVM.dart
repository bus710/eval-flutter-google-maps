import 'dart:async'; // for streams
import 'package:flutter/material.dart'; // for debugPrint
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../utils/enums.dart';
import '../rootModel.dart';
import '../models/events.dart';

class MapViewModel {
  Timer _timer;
  var _rootModel;
  MapEvent _data;
  List<LatLng> _listLatLng;
  bool _started;

  // Declare the stream from viewmodel to view
  StreamController<MapEvent> _responseSender;
  Stream<MapEvent> get responseSenderStream =>
      _responseSender.stream.map((val) {
        return _data;
      });

  // Declare the stream from view to viewmodel
  StreamController<MapEvent> _requestReceiver;
  Sink<MapEvent> get requestReceiverSink => _requestReceiver.sink;

  MapViewModel(BuildContext context) {
    _rootModel = Provider.of<RootModel>(context);
    _timer = Timer.periodic(Duration(milliseconds: 1000), _timerHandler);
    _responseSender = StreamController<MapEvent>.broadcast();
    _requestReceiver = StreamController<MapEvent>.broadcast();
    _started = false;

    // Init data
    _data = MapEvent(type: "", data: "", listLatLan: []);
    _listLatLng = [
      LatLng(33.131035, -117.365032),
      LatLng(33.132135, -117.365132),
      LatLng(33.133235, -117.365232),
      LatLng(33.134435, -117.365332),
      LatLng(33.135535, -117.365432),
      LatLng(33.136635, -117.365532),
      LatLng(33.137735, -117.365632),
      LatLng(33.140735, -117.365632),
      LatLng(33.140735, -117.405632),
    ];

    // Connect handler
    _requestReceiver.stream.listen(_requestHandler);
  }

  void _timerHandler(Timer timer) async {
    if (_started && _listLatLng.length > 0) {
      _data.type = "update";
      _data.listLatLan.add(_listLatLng[0]);
      _responseSender.sink.add(_data);
      _listLatLng.removeAt(0);
      debugPrint(_listLatLng.toString());
    }
  }

  void _requestHandler(MapEvent ev) async {
    debugPrint("mapVM: ${ev.toString()}");
    // _responseSender.sink.add(_data);

    if (ev.type == "start") {
      _started = true;
    }

    if (ev.type == "route" && ev.data == "main") {
      _rootModel.appStatusRequestHandler(AppStatus.main);
      _started = false;
    }
  }

  void dispose() => {
        _timer.cancel(),
        _responseSender.close(),
        _requestReceiver.close(),
      };
}
