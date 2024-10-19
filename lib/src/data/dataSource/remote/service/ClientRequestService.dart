import 'dart:convert';

import 'package:indriver_clone_flutter/src/data/api/ApiConfig.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/domain/models/StatusTrip.dart';
import 'package:indriver_clone_flutter/src/domain/models/TimeAndDistanceValues.dart';
import 'package:indriver_clone_flutter/src/domain/utils/ListToString.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class ClientRequestService {
  Future<Resource<int>> create(ClientRequest clientRequest) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, 'client-requests');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      String body = json.encode(clientRequest);
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(data);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }

  Future<Resource<bool>> updateRouteSelect(
      int idClientRequest,
      String agencyLongName,
      String originStopDescription,
      String destinationStopDescription,
      double originStopLat,
      double originStopLng,
      double destStopLat,
      double destStopLng,
      double distanceRoute,
      int timeRoute,
      double tarifaRoute) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, 'client-requests');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      String body = json.encode({
        'id': idClientRequest,
        'agency_long_name': agencyLongName,
        'pickup_stop_description': originStopDescription,
        'destination_stop_description': destinationStopDescription,
        'pickup_stop_lat': originStopLat,
        'pickup_stop_lng': originStopLng,
        'destination_stop_lat': destStopLat,
        'destination_stop_lng': destStopLng,
        'distance_route': distanceRoute,
        'time_route': timeRoute,
        'tarifa_route': tarifaRoute,
      });
      final response = await http.put(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(true);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }

  Future<Resource<TimeAndDistanceValues>> getTimeAndDistanceClientRequest(
    double originLat,
    double originLng,
    double destinationLat,
    double destinationLng,
  ) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT,
          'client-requests/${originLat}/${originLng}/${destinationLat}/${destinationLng}');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        TimeAndDistanceValues timeAndDistanceValues =
            TimeAndDistanceValues.fromJson(data);
        return Success(timeAndDistanceValues);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }

  Future<Resource<ClientRequest>> getByClientRequest(
      int idClientRequest) async {
    try {
      Uri url =
          Uri.http(ApiConfig.API_PROJECT, 'client-requests/${idClientRequest}');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        ClientRequest clientRequest = ClientRequest.fromJson(data);
        return Success(clientRequest);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error $e');
      return ErrorData(e.toString());
    }
  }

  Future<Resource<List<ClientRequest>>> getByClientTripsHistory(
      int idClient) async {
    try {
      Uri url =
          Uri.http(ApiConfig.API_PROJECT, 'client-requests/client/${idClient}');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ClientRequest> clientRequest = ClientRequest.fromJsonList(data);
        return Success(clientRequest);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error $e');
      return ErrorData(e.toString());
    }
  }

  Future<Resource<bool>> updateStatus(
    int idClientRequest,
    StatusTrip statusTrip,
  ) async {
    try {
      Uri url =
          Uri.http(ApiConfig.API_PROJECT, 'client-requests/update_status');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      String body = json.encode({
        'id_client_request': idClientRequest,
        'status': statusTrip.name,
      });
      final response = await http.put(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(true);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }
}
