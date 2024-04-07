import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import 'forecast_tile_provider.dart';
// import 'package:weather_app_assignment/screens/map_screen/forecast_tile_provider.dart';

class MapViewWidget extends StatefulWidget {
  String? mapType;
   MapViewWidget({super.key,this.mapType});

  @override
  State<MapViewWidget> createState() => _MapViewWidgetState();
}

class _MapViewWidgetState extends State<MapViewWidget> {
  GoogleMapController? _controller;

  TileOverlay? _tileOverlay;

  DateTime _forecastDate = DateTime.now();

  _initTiles(DateTime date) async {
    final String overlayId = date.millisecondsSinceEpoch.toString();

    final TileOverlay tileOverlay = TileOverlay(
      tileOverlayId: TileOverlayId(overlayId),
      tileProvider: ForecastTileProvider(
        dateTime: date,
        // mapType: 'PAR0',
        mapType:widget.mapType??'TA2',
        opacity: 0.4,
      ),
    );
    setState(() {
      _tileOverlay = tileOverlay;
    });
  }
   LatLng currentLocation = LatLng(20.2881798, 85.8177999);


  Future<void> _getCurrentLocation() async {
    final locationStatus = await Permission.location.request();
    if (locationStatus.isGranted) {
      final location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if (kDebugMode) {
        print('Location permission $location');
      }
      setState(() {
        currentLocation = LatLng(location.latitude, location.longitude);
      });
    } else {
      if (kDebugMode) {
        print('Location permission denied');
      }
      // Handle permission denial (e.g., show a snackbar)
    }
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            zoomControlsEnabled: true,
            compassEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapToolbarEnabled: true,
            indoorViewEnabled: true,
            zoomGesturesEnabled: true,
            tiltGesturesEnabled: true,
            // mapType: MapType.normal,
            // key: UniqueKey(),
            padding: EdgeInsets.all(25),
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation.latitude ??
                        0,
                    currentLocation.longitude ??
                        0),
                zoom: 6),
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                _controller = controller;
              });
              _initTiles(_forecastDate);
            },
            tileOverlays:
            _tileOverlay == null ? {} : <TileOverlay>{_tileOverlay!},
          ),
          Positioned(
            top: 30,
            child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _forecastDate =
                              _forecastDate.subtract(const Duration(hours: 3));
                        });
                        _initTiles(_forecastDate);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Center(
                    child: Card(
                      elevation: 4,
                      shadowColor: Colors.black,
                      color: Colors.black,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Forecast Date:\n${DateFormat('yyyy-MM-dd ha').format(_forecastDate)}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    child: ElevatedButton(
                      onPressed:
                      _forecastDate.difference(DateTime.now()).inDays >= 10
                          ? null
                          : () {
                        setState(() {
                          _forecastDate = _forecastDate
                              .add(const Duration(hours: 3));
                        });
                        _initTiles(_forecastDate);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
