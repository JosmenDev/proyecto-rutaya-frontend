import 'dart:io';

import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/UsersService.dart';
import 'package:indriver_clone_flutter/src/domain/models/User.dart';
import 'package:indriver_clone_flutter/src/domain/repository/UsersRepository.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class UsersRepositoryImpl implements UsersRepository {
  UsersService usersService;
  UsersRepositoryImpl(this.usersService);
  @override
  Future<Resource<User>> update(int id, User user, File? file) {
    return usersService.update(id, user);
  }
}
