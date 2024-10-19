import 'package:indriver_clone_flutter/src/domain/repository/SocketRepository.dart';

class ConnectSocketUseCase {

  SocketRepository socketRepository;

  ConnectSocketUseCase(this.socketRepository);

  run() => socketRepository.connect();

}