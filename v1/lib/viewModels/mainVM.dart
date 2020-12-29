import 'dart:async'; // for streams
import 'package:flutter/material.dart'; // for debugPrint
import 'package:provider/provider.dart';
import '../utils/enums.dart';
import '../rootModel.dart';
import '../models/events.dart';

class MainViewModel {
  Timer _timer;
  var _rootModel;
  MainEvent _data;

  // Declare streams
  StreamController<MainEvent> _responseSender;
  Stream<MainEvent> get responseSenderStream =>
      _responseSender.stream.map((val) {
        return _data;
      });

// Assign streams
  StreamController<MainEvent> _requestReceiver;
  Sink<MainEvent> get requestReceiverSink => _requestReceiver.sink;

  MainViewModel(BuildContext context) {
    _rootModel = Provider.of<RootModel>(context);
    _timer = Timer.periodic(Duration(milliseconds: 1000), _timerHandler);
    _responseSender = StreamController<MainEvent>.broadcast();
    _requestReceiver = StreamController<MainEvent>.broadcast();

// Init data
    _data = MainEvent(type: "");

    // Connect handler
    _requestReceiver.stream.listen(_requestHandler);
  }

  void _timerHandler(Timer timer) async {}

  void _requestHandler(MainEvent ev) async {
    debugPrint("mainVM: ${ev.toString()}");
    _responseSender.sink.add(_data);

    if (ev.type == "route" && ev.data == "map") {
      _rootModel.appStatusRequestHandler(AppStatus.map);
    }
  }

  void dispose() => {
        _timer.cancel(),
        _responseSender.close(),
        _requestReceiver.close(),
      };
}
