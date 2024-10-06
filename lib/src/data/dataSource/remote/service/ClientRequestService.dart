import 'dart:convert';

import 'package:indriver_clone_flutter/src/data/api/ApiConfig.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/domain/models/TimeAndDistanceValues.dart';
import 'package:indriver_clone_flutter/src/domain/utils/ListToString.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class ClientRequestService {
  Future<Resource<bool>> create(ClientRequest clientRequest) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, 'client-requests');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      String body = json.encode(clientRequest);
      final response = await http.post(url, headers: headers, body: body);
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
}
