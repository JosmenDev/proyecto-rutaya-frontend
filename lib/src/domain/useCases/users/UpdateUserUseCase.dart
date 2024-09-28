import 'dart:io';

import 'package:indriver_clone_flutter/src/domain/models/User.dart';
import 'package:indriver_clone_flutter/src/domain/repository/UsersRepository.dart';

class UpdateUserUseCase {
  UsersRepository usersRepository;

  UpdateUserUseCase(this.usersRepository);

  run(int id, User user, File? file) => usersRepository.update(id, user, file);
}
