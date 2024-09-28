import 'dart:io';

import 'package:indriver_clone_flutter/src/domain/models/User.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

abstract class UsersRepository {
  Future<Resource<User>> update(int id, User user, File? file);
}
