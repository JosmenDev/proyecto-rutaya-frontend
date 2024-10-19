import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/Bloc/MapTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/Bloc/MapTripEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/Bloc/MapTripState.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/MapTripContent.dart';

class MapTripPage extends StatefulWidget {
  const MapTripPage({super.key});

  @override
  State<MapTripPage> createState() => _MapTripPageState();
}

class _MapTripPageState extends State<MapTripPage> {
  String? idClientRequest;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (idClientRequest != null) {
        print('ID CLIENT REQUEST $idClientRequest');
        context.read<MapTripBloc>().add(MapTripInitEvent());
        context.read<MapTripBloc>().add(
            GetClientRequest(idClientRequest: int.parse(idClientRequest!)));
        // context.read<MapTripBloc>().add(ListenTripPosition());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    idClientRequest = arguments['idClientRequest'];
    return Scaffold(
      body: BlocListener<MapTripBloc, MapTripState>(
        listener: (context, state) {
          final responseClientRequest = state.responseGetClientRequest;
          if (responseClientRequest is Success) {
            final data = responseClientRequest.data as ClientRequest;
            print('ClientRequestResponse: ${data.toJson()}');
            // context
            //     .read<MapTripBloc>()
            //     .add(AddMarketPickup(lat: data.pickupLat, lng: data.pickupLng));
          } else if (responseClientRequest is ErrorData) {
            Fluttertoast.showToast(
                msg: responseClientRequest.message,
                toastLength: Toast.LENGTH_LONG);
          }
        },
        child: BlocBuilder<MapTripBloc, MapTripState>(
          builder: (context, state) {
            final responseClientRequest = state.responseGetClientRequest;
            if (responseClientRequest is Success) {
              final data = responseClientRequest.data as ClientRequest;
              print('ClientRequestResponse: ${data.toJson()}');
              return MapTripContent(state, data, null);
            }
            return Container(
              child: Center(
                child: Text('Error al cargar mapa'),
              ),
            );
          },
        ),
      ),
    );
  }
}
