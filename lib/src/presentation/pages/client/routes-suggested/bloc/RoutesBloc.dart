import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/domain/models/Routes.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/routes-suggested/RoutesUseCases.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/routes-suggested/bloc/RoutesEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/routes-suggested/bloc/RoutesState.dart';

class RoutesBloc extends Bloc<RoutesEvent, RoutesState> {
  final RoutesUseCases routesUseCases;

  RoutesBloc(this.routesUseCases) : super(RoutesState()) {
    on<GetRoutesSuggets>((event, emit) async {
      try {
        // Emitir estado de carga
        emit(state.copyWith(isLoading: true));

        // Llamar al caso de uso con las coordenadas del evento
        List<Routes> routesList =
            await routesUseCases.getRoutesSuggetedUseCase.run(
          originLat: event.originLat,
          originLng: event.originLng,
          destLat: event.destLat,
          destLng: event.destLng,
        );

        // Emitir el estado actualizado con las rutas cargadas
        emit(state.copyWith(
          routesList: routesList,
          isLoading: false, // Ya no está cargando
        ));
      } catch (e) {
        // Emitir un estado de error si algo falla
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Error al cargar las rutas: $e',
        ));
      }
    });
  }
}
