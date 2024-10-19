import 'package:indriver_clone_flutter/src/domain/repository/SocketRepository.dart';

class DisconnectSocketUseCase {

  SocketRepository socketRepository;

  DisconnectSocketUseCase(this.socketRepository);

  run() => socketRepository.disconnect();

}