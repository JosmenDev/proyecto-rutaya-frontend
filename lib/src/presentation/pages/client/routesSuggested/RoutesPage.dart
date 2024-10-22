import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Importar flutter_bloc
import 'package:indriver_clone_flutter/src/presentation/pages/client/routesSuggested/RoutesContent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/routesSuggested/bloc/RoutesBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/routesSuggested/bloc/RoutesEvent.dart';

class RoutesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    // Obtener latitud y longitud del origen y destino
    final originLatLng = arguments['pickUpLatLng'];
    final destLatLng = arguments['destinationLatLng'];
    // final idClientRequest = arguments['idClientRequest'];

    // Despachar el evento para obtener las rutas sugeridas con las coordenadas después de que se construye el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RoutesBloc>().add(GetRoutesSuggets(
            originLat: originLatLng.latitude,
            originLng: originLatLng.longitude,
            destLat: destLatLng.latitude,
            destLng: destLatLng.longitude,
          ));
    });

    return Scaffold(
      body: RoutesContent(
        idClientRequest: arguments['idClientRequest'],
        pickUpDescription: arguments['pickUpDescription'],
        destinationDescription: arguments['destinationDescription'],
      ), // Usa el RoutesContent directamente
    );
  }
}
