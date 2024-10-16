import 'package:equatable/equatable.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class MapTripState extends Equatable {
  final Resource? responseGetClientRequest;

  MapTripState({this.responseGetClientRequest});

  MapTripState copyWith({
    Resource? responseGetClientRequest,
  }) {
    return MapTripState(
      responseGetClientRequest:
          responseGetClientRequest ?? this.responseGetClientRequest,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [responseGetClientRequest];
}
