import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/domain/models/TimeAndDistanceValues.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/ClientMapBookingInfoContent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoState.dart';

class ClientMapBookingInfoPage extends StatefulWidget {
  const ClientMapBookingInfoPage({super.key});

  @override
  State<ClientMapBookingInfoPage> createState() =>
      _ClientMapBookingInfoPageState();
}

class _ClientMapBookingInfoPageState extends State<ClientMapBookingInfoPage> {
  LatLng? pickUpLatLng;
  LatLng? destinationLatLng;
  String? pickUpDescription;
  String? destinationDescription;
  String? idClientRequest;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Verificación de las coordenadas antes de proceder
      if (pickUpLatLng == null || destinationLatLng == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Por favor, selecciona un punto de origen y un destino.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        context
            .read<ClientMapBookingInfoBloc>()
            .add(ClientMapBookingInfoInitEvent(
              pickUpLatLng: pickUpLatLng!,
              destinationLatLng: destinationLatLng!,
              pickUpDescription: pickUpDescription!,
              destinationDescription: destinationDescription!,
            ));
        context
            .read<ClientMapBookingInfoBloc>()
            .add(GetTimeAndDistanceValues());
        context.read<ClientMapBookingInfoBloc>().add(AddPolyline());
      }
    });
  }

  // Dentro de ClientMapBookingInfoPage
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    pickUpLatLng = arguments['pickUpLatLng'];
    destinationLatLng = arguments['destinationLatLng'];
    pickUpDescription = arguments['pickUpDescription'];
    destinationDescription = arguments['destinationDescription'];
    return Scaffold(
      body: BlocListener<ClientMapBookingInfoBloc, ClientMapBookingInfoState>(
        listener: (context, state) {
          final responseClientRequest = state.responseClientRequest;
          if (responseClientRequest is Success && state.isRequestSubmitted) {
            String idClientRequest = responseClientRequest.data.toString();
            // print('ID CLIENT REQUEST ${responseClientRequest.data}');
            Fluttertoast.showToast(
                msg: 'Solicitud Enviada', toastLength: Toast.LENGTH_LONG);

            // Navega a la nueva pantalla y pasa idClientRequest
            Navigator.pushNamed(
              context,
              'client/routes-suggested',
              arguments: {
                'pickUpLatLng': pickUpLatLng,
                'destinationLatLng': destinationLatLng,
                'pickUpDescription': pickUpDescription,
                'destinationDescription': destinationDescription,
                'idClientRequest':
                    idClientRequest, // Pasar el ID de la solicitud
              },
            );
            context
                .read<ClientMapBookingInfoBloc>()
                .add(ResetRequestFlagEvent());
          }
        },
        child: BlocBuilder<ClientMapBookingInfoBloc, ClientMapBookingInfoState>(
          builder: (context, state) {
            final responseTimeAndDistance = state.responseTimeAndDistance;
            if (responseTimeAndDistance is Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (responseTimeAndDistance is Success) {
              TimeAndDistanceValues timeAndDistanceValues =
                  responseTimeAndDistance.data as TimeAndDistanceValues;
              return ClientMapBookingInfoContent(state, timeAndDistanceValues,
                  context.read<ClientMapBookingInfoBloc>());
            }
            return Container();
          },
        ),
      ),
    );
  }
}
