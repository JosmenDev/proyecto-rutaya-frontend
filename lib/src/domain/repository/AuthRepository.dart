import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/domain/models/User.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

abstract class AuthRepository {
  Future<Resource<AuthResponse>> login(String email, String password);
  Future<Resource<AuthResponse>> register(User user);
  // Almacenar usuario en sesion
  Future<void> saveUserSession(AuthResponse authResponse);
  // Obtener la informacion
  Future<AuthResponse?> getUserSession();
  Future<bool> logout();
}
