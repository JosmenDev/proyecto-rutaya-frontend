import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/presentation/colors/colors.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/routesSuggested/bloc/RoutesBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/routesSuggested/bloc/RoutesEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/routesSuggested/bloc/RoutesState.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultIconBack.dart';
import 'package:lottie/lottie.dart';

class RoutesContent extends StatelessWidget {
  final String idClientRequest;
  final String pickUpDescription;
  final String destinationDescription;

  RoutesContent({
    required this.idClientRequest,
    required this.pickUpDescription,
    required this.destinationDescription,
  });

  String? extractQuotedText(String input) {
    final RegExp regExp = RegExp(r'"(.*?)"');
    final matches = regExp.allMatches(input);
    return matches.isNotEmpty ? matches.first.group(1) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            // Encabezado con el botón de retroceso y ubicaciones
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 70.0, bottom: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultIconBack(
                    color: Colors.white,
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      children: [
                        LocationWidget(
                          icon: Icons.location_on,
                          label: pickUpDescription,
                        ),
                        SizedBox(height: 8.0),
                        LocationWidget(
                          icon: Icons.location_searching,
                          label: destinationDescription,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Subtítulo "Rutas Sugeridas"
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Rutas Sugeridas',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),

            // Lista de rutas sugeridas utilizando BlocBuilder
            Expanded(
              child: BlocBuilder<RoutesBloc, RoutesState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    // Mostrar indicador de carga mientras se cargan las rutas
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Cargar la animación Lottie
                          Lottie.asset(
                            'assets/lottie/lottie_loading_route.json', // Ruta a tu animación
                            width: 300,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Estamos preparando las mejores opciones para ti',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state.errorMessage != null) {
                    // Mostrar mensaje de error si ocurre un problema al cargar las rutas
                    return Center(child: Text(state.errorMessage!));
                  } else if (state.routesList.isNotEmpty) {
                    // Mostrar lista de rutas cuando se cargan con éxito
                    return ListView.builder(
                      padding: EdgeInsets.only(top: 8.0),
                      itemCount: state.routesList.length,
                      itemBuilder: (context, index) {
                        final route = state.routesList[index];
                        // print('ID CLIENT REQUEST: $idClientRequest');
                        // print('Route $index: $route');
                        final String quotedText =
                            extractQuotedText(route.name) ?? '';
                        return RouteCard(
                          routeName: '${route.agencyName} $quotedText',
                          estimatedTime:
                              '${route.totalEstimatedTime}', // Ajusta según la lógica de tu aplicación
                          arrivalTime: route.nextArrivalTime!,
                          distance: '${route.distanceToDisplay} m',
                          fare: '2 PEN',
                          quotedText: quotedText, // Pasamos quotedText
                          route:
                              route, // Pasamos la ruta completa para usar sus datos en el botón
                          idClientRequest: idClientRequest,
                        );
                      },
                    );
                  }
                  // Estado inicial vacío (cuando no hay rutas disponibles)
                  return Center(child: Text('No hay rutas disponibles.'));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LocationWidget extends StatelessWidget {
  final IconData icon;
  final String label;

  LocationWidget({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200], // Fondo gris claro
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
      ),
    );
  }
}

class RouteCard extends StatelessWidget {
  final String routeName;
  final String estimatedTime;
  final String arrivalTime;
  final String distance;
  final String fare;
  final String quotedText;
  final dynamic route;
  final String idClientRequest;

  RouteCard({
    required this.routeName,
    required this.estimatedTime,
    required this.arrivalTime,
    required this.distance,
    required this.fare,
    required this.quotedText,
    required this.route,
    required this.idClientRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tiempo estimado: $estimatedTime minutos',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(Icons.directions_bus),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              routeName,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text(
              'Horario de llegada estimada: $arrivalTime',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Distancia: $distance'),
                Text('Tarifa: $fare'),
              ],
            ),
            SizedBox(height: 8.0),
            // Botón pequeño para seleccionar la ruta
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  context.read<RoutesBloc>().add(RouteSelect(
                        idClientRequest: int.parse(idClientRequest),
                        agencyLongName: '${route.agencyName} $quotedText',
                        originStopDescription: '',
                        destinationStopDescription: '',
                        originStopLat: route.originStopLat,
                        originStopLng: route.originStopLng,
                        destStopLat: route.destStopLat,
                        destStopLng: route.destStopLng,
                        distanceRoute: double.parse(route
                            .distanceToDisplay), // Usa simplemente la variable
                        timeRoute: int.parse(route
                            .totalEstimatedTime), // Usa simplemente la variable
                        tarifaRoute: 2, // Usa simplemente la variable
                      ));
                  Navigator.pushNamed(
                    context,
                    'client/map-trip',
                    arguments: {
                      'idClientRequest': idClientRequest,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: celeste,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
                child: Text(
                  'Seleccionar',
                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
