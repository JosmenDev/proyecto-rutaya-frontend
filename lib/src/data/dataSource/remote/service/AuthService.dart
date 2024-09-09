import 'dart:convert';

import 'package:indriver_clone_flutter/src/data/api/ApiConfig.dart';
import 'package:http/http.dart' as http;
import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/domain/utils/ListToString.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class AuthService {
  // Future permite trabajar con peticiones asincronas
  Future<Resource<AuthResponse>> login(String email, String password) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/auth/login');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      String body = json.encode({'email': email, 'password': password});
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);

      // Validar status de la respuesta del servidor
      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);
        print('Data Remote: ${authResponse.toJson()}');
        print('Token: ${authResponse.token}');
        return Success(authResponse);
      } else {
        return ErrorData(data['message']);
      }
    } catch (e) {
      print('Error: $e');
      return ErrorData(listToString(e.toString()));
    }
  }
}
