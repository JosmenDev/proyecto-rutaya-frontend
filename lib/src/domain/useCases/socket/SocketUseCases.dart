import 'package:indriver_clone_flutter/src/domain/useCases/socket/ConnectSocketUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/socket/DisconnectSocketUseCase.dart';

class SocketUseCases {

  ConnectSocketUseCase connect;
  DisconnectSocketUseCase disconnect;

  SocketUseCases({
    required this.connect,
    required this.disconnect
  });

}