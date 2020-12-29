// import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class AppEvent {}

class MainEvent extends AppEvent {
  String type;
  String data;

  MainEvent({
    this.type,
    this.data,
  });
}

class MapEvent extends AppEvent {
  String type;
  String data;
  List<LatLng> listLatLan;

  MapEvent({
    this.type,
    this.data,
    this.listLatLan,
  });
}
