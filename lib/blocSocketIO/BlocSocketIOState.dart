import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart';

class BlocSocketIOState extends Equatable {
  final Socket? socket;

  BlocSocketIOState({this.socket});

  BlocSocketIOState copyWith({Socket? socket}) {
    return BlocSocketIOState(socket: socket ?? this.socket);
  }

  @override
  List<Object?> get props => [socket];
}
