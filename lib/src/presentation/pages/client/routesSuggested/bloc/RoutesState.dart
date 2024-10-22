import 'package:equatable/equatable.dart';
import 'package:indriver_clone_flutter/src/domain/models/Routes.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class RoutesState extends Equatable {
  final List<Routes> routesList; // Lista de rutas
  final bool isLoading; // Indicador para saber si está cargando
  final String? errorMessage; // Mensaje de error si ocurre un problema
  final Resource? responseRouteSelect;

  RoutesState({
    this.routesList = const [], // Inicializar con una lista vacía
    this.isLoading = false, // Inicializar como "no está cargando"
    this.errorMessage, // Inicializar como nulo
    this.responseRouteSelect,
  });

  // Método para crear una copia del estado con propiedades modificadas
  RoutesState copyWith({
    List<Routes>? routesList,
    bool? isLoading,
    String? errorMessage,
    Resource? responseRouteSelect,
  }) {
    return RoutesState(
      routesList: routesList ?? this.routesList,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      responseRouteSelect: responseRouteSelect,
    );
  }

  @override
  List<Object?> get props =>
      [routesList, isLoading, errorMessage, responseRouteSelect];
}
