import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/domain/models/TimeAndDistanceValues.dart';
import 'package:indriver_clone_flutter/src/presentation/colors/colors.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/Bloc/MapTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/Bloc/MapTripEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/Bloc/MapTripState.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultButton.dart';

class MapTripContent extends StatelessWidget {
  MapTripState state;
  TimeAndDistanceValues? timeAndDistanceValues;
  // final ClientMapBookingInfoBloc bloc;
  ClientRequest? clientRequest;

  MapTripContent(this.state, this.clientRequest, this.timeAndDistanceValues);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _GoogleMaps(context),
        Container(
          alignment: Alignment.bottomCenter,
          child: _cardBookingInfo(context),
        ),
        // Positioned(
        //   top: 40,
        //   left: 20,
        //   child: DefaultIconBack(
        //     color: Colors.white,
        //   ),
        // ),
      ],
    );
  }

  Widget _GoogleMaps(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *
          0.55, // Ajustar altura para dejar más espacio
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: state.cameraPosition,
        markers: Set<Marker>.of(state.markers.values),
        polylines: Set<Polyline>.of(state.polylines.values),
        onMapCreated: (GoogleMapController controller) {
          if (!state.controller!.isCompleted) {
            state.controller?.complete(controller);
            // context
            //     .read<MapTripBloc>()
            //     .add(GetClientRequest(idClientRequest: clientRequest!.id!));
            // if (clientRequest != null) {
            //   context.read<MapTripBloc>().add(AddMarketPickup(
            //         lat: clientRequest!.pickupLat,
            //         lng: clientRequest!.pickupLng,
            //       ));
            //   context.read<MapTripBloc>().add(AddMarketStopPickup(
            //         lat: clientRequest!.pickupStopLat!,
            //         lng: clientRequest!.pickupStopLng!,
            //       ));
            //   context.read<MapTripBloc>().add(AddMarketStopDestination(
            //         lat: clientRequest!.destinationStopLat!,
            //         lng: clientRequest!.destinationStopLng!,
            //       ));
            //   context.read<MapTripBloc>().add(AddMarketDestination(
            //         lat: clientRequest!.destinationLat,
            //         lng: clientRequest!.destinationLng,
            //       ));
            // }
          }
        },
      ),
    );
  }

  Widget _cardBookingInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height *
          0.48, // Ajustar altura para dejar espacio
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: SingleChildScrollView(
        // Envolver con SingleChildScrollView
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
                '${timeAndDistanceValues?.duration.text}',
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
                '${clientRequest?.distanceRoute}',
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
                context.read<MapTripBloc>().add(UpdateStatusToFinished(
                    idClientRequest: clientRequest!.id!));
                Navigator.pushNamedAndRemoveUntil(
                    context, 'client/finalization-trip', (route) => false,
                    arguments: clientRequest);
              },
              color: celeste,
              direction: 'Submit',
              text: 'Finalizar Viaje',
            ),
          ],
        ),
      ),
    );
  }
}
