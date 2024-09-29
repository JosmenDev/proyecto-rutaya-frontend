import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:indriver_clone_flutter/src/data/api/ApiConfig.dart';
import 'package:indriver_clone_flutter/src/domain/models/User.dart';
import 'package:indriver_clone_flutter/src/domain/utils/ListToString.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class UsersService {
  Future<String> token;
  UsersService(this.token);

  Future<Resource<User>> update(int id, User user) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, 'users/$id');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${await token}', // Usa await para obtener el token
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

  // Mueve updateImage dentro de la clase para acceder a la propiedad `token`
  Future<Resource<User>> updateImage(int id, User user, File file) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, 'users/upload/$id');
      final request = http.MultipartRequest('PUT', url);

      request.headers['Authorization'] = 'Bearer ${await token}';

      // Añadir el archivo al request solo si no es null

      request.files.add(http.MultipartFile(
        'file',
        http.ByteStream(file.openRead().cast()),
        await file.length(),
        filename: basename(file.path),
        contentType: MediaType('image', 'jpg'),
      ));

      // Añadir campos adicionales
      request.fields['name'] = user.name;
      request.fields['phone'] = user.phone;

      // Envía el request
      final response = await request.send();
      // print(response);
      final data =
          json.decode(await response.stream.transform(utf8.decoder).first);
      // print(data);
      // Manejo de respuestas
      if (response.statusCode == 200 || response.statusCode == 201) {
        User usersResponse = User.fromJson(data['data']); // Cambiar esto
        return Success(usersResponse);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }
}
