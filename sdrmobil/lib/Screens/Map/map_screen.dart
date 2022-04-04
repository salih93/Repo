import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sdrmobil/Screens/Map/directions_model.dart';
import 'package:sdrmobil/Screens/Map/directions_repository.dart';
import 'package:sdrmobil/controller/controller.dart';

class MapScreen extends StatefulWidget {
  final int onlyLocation;

  MapScreen({
   @required this.onlyLocation
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Controller _controller = Get.find();
  
  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;
  Directions _info;
  Position currentPosition;

  @override
  void initState() {
    Future(() => {
       _addMarker(LatLng(0.0, 0.0))
     });

    super.initState();    
  }

  _getCurrentLocation() async {
   bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale 
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 



  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
      .then((Position position) async {        
    _controller.currentlatitude.value=position.latitude;
    _controller.currentlongitude.value=position.longitude;
    setState(() {
      // Store the position in the variable
      currentPosition = position;
    });
    
  }).catchError((e) {
    print(e);
  });
}

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    
    final CameraPosition _initialCameraPosition = CameraPosition(
      target: widget.onlyLocation==0 ? LatLng(_controller.enlem.value, _controller.boylam.value):
        LatLng(_controller.currentlatitude.value, _controller.currentlongitude.value),
      zoom: 10,
    );

    return Scaffold(

      body: Stack(
        alignment: Alignment.center,
        children: [
          
          widget.onlyLocation==0 ? GoogleMap(
            mapType: MapType.normal,            
            myLocationButtonEnabled: false,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition:_initialCameraPosition,
            onMapCreated: (controller) {
              _googleMapController = controller;              
            },             
            markers: {
              if (_origin != null) _origin,
              if (_destination != null) _destination
            },
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,

            polylines: {                          
              if (_info != null)
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: _info.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                ),
            },            
            //onLongPress:_addMarker ,
          ):GoogleMap(
            mapType: MapType.normal,            
            myLocationButtonEnabled: false,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition:_initialCameraPosition,
            onMapCreated: (controller) {
              _googleMapController = controller;              
            },             
            markers: {
              if (_origin != null) _origin,
              if (_destination != null) _destination
            },
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,        
          ),

          
          if (_info != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(                  
                  '${_info.totalDistance}, ${_info.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),     
    );    
    
  }
  Future _addMarker(LatLng pos) async {       

    await _getCurrentLocation();
    if (currentPosition!=null)
    {
      var _position=LatLng(currentPosition.latitude, currentPosition.longitude);
      _origin=null;

      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
             widget.onlyLocation==0 ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen):
             BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: _position,
        );
        // Reset destination
        //_destination = null;

        // Reset info
        _info = null;
      });

       setState(() {
         if (widget.onlyLocation==0)
         {
           _destination = Marker(
            markerId: const MarkerId('destination'),
            infoWindow: const InfoWindow(title: 'Destination'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: LatLng(_controller.enlem.value, _controller.boylam.value),
          );
         }

      });
      
      if (widget.onlyLocation==0)
      {
        final directions = await DirectionsRepository()
            .getDirections(origin: _origin.position, destination: _destination.position);
        setState(() {
          _info=directions;
          if(directions!=null)
          {
            if (directions.totalDistance!=null)
            {
              if (directions.totalDistance.toString()!="")
              _controller.mesafe.value=directions.totalDistance.toString();
            }
          }       
                  
        });
      }

    }     // Get directions
      
  }
  
}