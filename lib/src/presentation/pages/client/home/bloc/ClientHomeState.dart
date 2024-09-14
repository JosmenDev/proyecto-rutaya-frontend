import 'package:equatable/equatable.dart';

class ClientHomeState extends Equatable {
  // cambiar cada ves que se selecciona una opcion
  final int pageIndex;

  ClientHomeState({
    this.pageIndex = 0,
  });

  ClientHomeState copyWith({
    int? pageIndex,
  }) {
    return ClientHomeState(pageIndex: pageIndex ?? this.pageIndex);
  }

  @override
  List<Object?> get props => [pageIndex];
}
