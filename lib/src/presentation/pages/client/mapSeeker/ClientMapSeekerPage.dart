import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';
import 'package:indriver_clone_flutter/src/data/api/ApiKeyGoogle.dart';
import 'package:indriver_clone_flutter/src/presentation/colors/colors.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerState.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultButton.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/GooglePlacesAutoComplete.dart';

class ClientMapSeekerPage extends StatefulWidget {
  const ClientMapSeekerPage({super.key});

  @override
  State<ClientMapSeekerPage> createState() => _ClientMapSeekerPageState();
}

class _ClientMapSeekerPageState extends State<ClientMapSeekerPage> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

// posicion
  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();
    // Reiniciar el controlador cada vez que la página se inicia.
    context.read<ClientMapSeekerBloc>().add(ClientMapSeekerResetEvent());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClientMapSeekerBloc>().add(FindPosition());
    });
  }

  // only needed if you build for the web
  // final _yourProxyURL = 'https://your-proxy.com/';

  final pickUpController = TextEditingController();
  final destinationController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<ClientMapSeekerBloc, ClientMapseekerState>(
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: state.cameraPosition,
                markers: Set<Marker>.of(state.markers.values),
                onCameraMove: (CameraPosition cameraPosition) {
                  context
                      .read<ClientMapSeekerBloc>()
                      .add(OnCameraMove(cameraPosition: cameraPosition));
                },
                onCameraIdle: () async {
                  context.read<ClientMapSeekerBloc>().add(OnCameraIdle());
                  pickUpController.text = state.placemarkData?.address ?? '';
                  if (state.placemarkData != null) {
                    context
                        .read<ClientMapSeekerBloc>()
                        .add(OnAutoCompletedPickUpSelected(
                          lat: state.placemarkData!.lat,
                          lng: state.placemarkData!.lng,
                          pickUpDescription: state.placemarkData!.address,
                        ));
                  }
                },
                onMapCreated: (GoogleMapController controller) {
                  if (!state.controller.isCompleted) {
                    state.controller.complete(controller);
                    context
                        .read<ClientMapSeekerBloc>()
                        .add(ClientMapSeekerInitEvent());
                  }
                },
              ),
              _iconMyLocation(),
              placesAutoCompleteTextField(),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
                child: Defaultbutton(
                  size: size,
                  onPressed: () {
                    Navigator.pushNamed(context, 'client/map/booking',
                        arguments: {
                          'pickUpLatLng': state.pickUpLatLng,
                          'destinationLatLng': state.destinationLatLng,
                          'pickUpDescription': state.pickUpDescription,
                          'destinationDescription':
                              state.destinationDescription,
                        });
                  },
                  color: celeste, // Cambia el color según tus necesidades
                  direction:
                      'Submit', // Puede que este parámetro no sea necesario, ajústalo si es el caso
                  text: 'Buscar ruta',
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget placesAutoCompleteTextField() {
    final size =
        MediaQuery.of(context).size; // Obtener el tamaño de la pantalla
    return Positioned(
      top: 20, // Ajustar la posición del contorno
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Seleccione su ruta de viaje', // Texto del subtítulo
                style: TextStyle(
                  fontSize: size.width * 0.035, // Tamaño de fuente adaptativo
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                children: [
                  GooglePlacesAutoComplete(
                    pickUpController,
                    '¿Dónde te encuentras?',
                    Icons.location_on,
                    Colors.lightBlue,
                    (Prediction prediction) {
                      if (prediction != null) {
                        context.read<ClientMapSeekerBloc>().add(
                            ChangeMapCameraPosition(
                                lat: double.parse(prediction.lat!),
                                lng: double.parse(prediction.lng!)));
                        context
                            .read<ClientMapSeekerBloc>()
                            .add(OnAutoCompletedPickUpSelected(
                              lat: double.parse(prediction.lat!),
                              lng: double.parse(prediction.lng!),
                              pickUpDescription: prediction.description ?? '',
                            ));
                      }
                      // print('Lugar de recogida Lat: ${prediction.lat}');
                      // print('Lugar de recogida Lng: ${prediction.lng}');
                    },
                    API_KEY_GOOGLE,
                  ),
                  SizedBox(height: 10),
                  GooglePlacesAutoComplete(
                    destinationController,
                    '¿A dónde quieres ir?',
                    Icons.search,
                    Colors.black45,
                    (Prediction prediction) {
                      context
                          .read<ClientMapSeekerBloc>()
                          .add(OnAutoCompletedDestinationSelected(
                            lat: double.parse(prediction.lat!),
                            lng: double.parse(prediction.lng!),
                            destinationDescription:
                                prediction.description ?? '',
                          ));
                      // print('Lugar de Destino Lat: ${prediction.lat}');
                      // print('Lugar de Destino Lng: ${prediction.lng}');
                    },
                    API_KEY_GOOGLE,
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 24),
            // Reemplazar el botón con Defaultbutton

            // TextButton(
            //   onPressed: _onSubmit,
            //   child: const Text('Submit'),
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidateMode = AutovalidateMode.always);
      return;
    }

    print(pickUpController.text);
  }

  Widget _iconMyLocation() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 25),
      child: Image.asset(
        'assets/img/icon-location-small.png',
        width: 50,
        height: 50,
      ),
    );
  }
}
