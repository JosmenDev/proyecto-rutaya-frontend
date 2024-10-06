import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/src/types/bitmap.dart';
import 'package:google_maps_flutter_platform_interface/src/types/marker.dart';
import 'package:indriver_clone_flutter/src/data/api/ApiKeyGoogle.dart';
import 'package:indriver_clone_flutter/src/domain/models/PlacemarkData.dart';
import 'package:indriver_clone_flutter/src/domain/repository/GeolocatorRepository.dart';

class GeolocatorRepositoryImpl implements GeolocatorRepository {
  @override
  Future<Position> findPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('La ubicación no está activada');
      return Future.error('La ubicación no está activada.');
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
        print('Permiso no otorgado por el usuario');
        return Future.error('El permiso fue denegado');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Permiso no otorgado por el usuario permanentemente');
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Future<BitmapDescriptor> createMarketFromAsset(String path) async {
    ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor descriptor =
        await BitmapDescriptor.fromAssetImage(configuration, path);
    return descriptor;
  }

  @override
  Marker getMarket(String marketId, double lat, double lng, String title,
      String content, BitmapDescriptor imageMarket) {
    MarkerId id = MarkerId(marketId);
    Marker marker = Marker(
      markerId: id,
      icon: imageMarket,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: title, snippet: content),
    );
    return marker;
  }

  @override
  Future<PlacemarkData?> getPlacemarkData(CameraPosition cameraPosition) async {
    try {
      double lat = cameraPosition.target.latitude;
      double lng = cameraPosition.target.longitude;
      List<Placemark> placemarkList = await placemarkFromCoordinates(lat, lng);
      if (placemarkList != null) {
        if (placemarkList.length > 0) {
          String direction = placemarkList[0].thoroughfare!;
          String street = placemarkList[0].subThoroughfare!;
          String city = placemarkList[0].locality!;
          String department = placemarkList[0].administrativeArea!;
          PlacemarkData placemarkData = PlacemarkData(
            address: '$direction, $street, $city, $department',
            lat: lat,
            lng: lng,
          );
          return placemarkData;
        }
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Future<List<LatLng>> getPolyline(
      LatLng pickUpLatLng, LatLng destinationLatLng) async {
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
      googleApiKey: API_KEY_GOOGLE,
      request: PolylineRequest(
        origin: PointLatLng(pickUpLatLng.latitude, pickUpLatLng.longitude),
        destination: PointLatLng(
            destinationLatLng.latitude, destinationLatLng.longitude),
        mode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Trujillo, Perú")],
      ),
    );
    List<LatLng> polylineCoordinates = [];
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    return polylineCoordinates;
  }
}
