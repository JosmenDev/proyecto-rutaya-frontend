import 'package:equatable/equatable.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class TripHistoryState extends Equatable {
  final Resource? response;

  TripHistoryState({this.response});

  TripHistoryState copyWith({
    Resource? response,
  }) {
    return TripHistoryState(response: response ?? this.response);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [response];
}
