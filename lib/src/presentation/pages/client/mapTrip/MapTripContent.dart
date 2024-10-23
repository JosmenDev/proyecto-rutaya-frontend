import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/presentation/colors/colors.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/Bloc/MapTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/Bloc/MapTripEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/Bloc/MapTripState.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultButton.dart';

class MapTripContent extends StatelessWidget {
  final MapTripState state;
  final ClientRequest? clientRequest;
  final String formattedTime; // Tiempo formateado (MM:ss)

  MapTripContent(this.state, this.clientRequest, this.formattedTime);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _GoogleMaps(context),
        Container(
          alignment: Alignment.bottomCenter,
          child: _cardBookingInfo(context),
        ),
      ],
    );
  }

  Widget _GoogleMaps(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: state.cameraPosition,
        markers: Set<Marker>.of(state.markers.values),
        polylines: Set<Polyline>.of(state.polylines.values),
        onMapCreated: (GoogleMapController controller) {
          if (!state.controller!.isCompleted) {
            state.controller?.complete(controller);
          }
        },
      ),
    );
  }

  Widget _cardBookingInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Ruta de Viaje',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Origen: ${clientRequest?.pickupDescription}' ?? '',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'Destino: ${clientRequest?.destinationDescription}' ?? '',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              leading: Icon(Icons.location_on),
            ),
            ListTile(
              title: Text(
                'Micro',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                clientRequest?.agencyLongName ?? '',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              leading: Icon(Icons.directions_bus),
            ),
            ListTile(
              title: Text(
                'Tiempo Aproximado',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                '${clientRequest?.timeRoute} minutos',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              leading: Icon(Icons.timer),
            ),
            ListTile(
              title: Text(
                'Distancia Aproximada',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                '${clientRequest?.distanceRoute} metros',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              leading: Icon(Icons.social_distance),
            ),
            ListTile(
              title: Text(
                'Tarifa',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                '${clientRequest?.tarifaRoute}',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              leading: Icon(Icons.monetization_on),
            ),
            Defaultbutton(
              size: MediaQuery.of(context).size,
              onPressed: () {
                // Detener el temporizador antes de navegar
                context.read<MapTripBloc>().add(UpdateStatusToFinished(
                    idClientRequest: clientRequest!.id!));

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  'client/finalization-trip',
                  (route) => false,
                  arguments: {
                    'clientRequest': clientRequest,
                    'duration': formattedTime // Pasar el tiempo formateado
                  },
                );
              },
              color: celeste,
              direction: 'Submit',
              text: 'Finalizar Viaje',
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
