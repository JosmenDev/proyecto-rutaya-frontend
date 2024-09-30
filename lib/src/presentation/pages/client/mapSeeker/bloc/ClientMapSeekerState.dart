import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class ClientMapseekerState extends Equatable {
  final Position? position;

  ClientMapseekerState({
    this.position,
  });

  ClientMapseekerState copyWith({
    Position? position,
  }) {
    return ClientMapseekerState(
      position: position ?? this.position,
    );
  }

  @override
  List<Object?> get props => [position];
}
