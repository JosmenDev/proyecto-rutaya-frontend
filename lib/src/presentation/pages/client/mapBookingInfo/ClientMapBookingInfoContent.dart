import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/domain/models/TimeAndDistanceValues.dart';
import 'package:indriver_clone_flutter/src/presentation/colors/colors.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoState.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultButton.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultIconBack.dart';

class ClientMapBookingInfoContent extends StatelessWidget {
  ClientMapBookingInfoState state;
  TimeAndDistanceValues timeAndDistanceValues;
  final ClientMapBookingInfoBloc bloc;

  ClientMapBookingInfoContent(
      this.state, this.timeAndDistanceValues, this.bloc);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _GoogleMaps(context),
        Container(
          alignment: Alignment.bottomCenter,
          child: _cardBookingInfo(context),
        ),
        Positioned(
          top: 40,
          left: 20,
          child: DefaultIconBack(
            color: Colors.white,
          ),
        ),
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
          if (!state.controller.isCompleted) {
            state.controller.complete(controller);
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
                'Lugar de Origen',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                state.pickUpDescription,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              leading: Icon(Icons.location_on),
            ),
            ListTile(
              title: Text(
                'Lugar de destino',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                state.destinationDescription,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              leading: Icon(Icons.my_location),
            ),
            ListTile(
              title: Text(
                'Tiempo Aproximado',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                timeAndDistanceValues.duration.text,
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
                timeAndDistanceValues.distance.text,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              leading: Icon(Icons.social_distance),
            ),
            Defaultbutton(
              size: MediaQuery.of(context).size,
              onPressed: () {
                bloc.add(CreateClientRequest());
                Navigator.pushNamed(
                  context,
                  'client/routes-suggested',
                  arguments: {
                    'pickUpLatLng': state.pickUpLatLng,
                    'destinationLatLng': state.destinationLatLng,
                    'pickUpDescription': state.pickUpDescription,
                    'destinationDescription': state.destinationDescription,
                  },
                );
              },
              color: celeste,
              direction: 'Submit',
              text: 'Buscar ruta',
            ),
          ],
        ),
      ),
    );
  }
}
