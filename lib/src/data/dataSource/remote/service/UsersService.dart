import 'dart:convert';

import 'package:indriver_clone_flutter/src/data/api/ApiConfig.dart';
import 'package:indriver_clone_flutter/src/domain/models/User.dart';
import 'package:indriver_clone_flutter/src/domain/utils/ListToString.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class UsersService {
  Future<String> token;
  UsersService(this.token);

  Future<Resource<User>> update(int id, User user) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, 'users/$id');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await token}',
      };
      String body = json.encode({
        'name': user.name,
        'phone': user.phone,
      });
      final response = await http.put(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        User userResponse = User.fromJson(data);
        return Success(userResponse);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }
}
