import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/Bloc/MapTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/Bloc/MapTripEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/Bloc/MapTripState.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/MapTripContent.dart';
import 'package:lottie/lottie.dart';

class MapTripPage extends StatefulWidget {
  const MapTripPage({super.key});

  @override
  State<MapTripPage> createState() => _MapTripPageState();
}

class _MapTripPageState extends State<MapTripPage> {
  String? idClientRequest;
  Timer? _timer;
  int _secondsElapsed = 3; // Variable para contar los segundos

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (idClientRequest != null) {
        print('ID CLIENT REQUEST $idClientRequest');
        context.read<MapTripBloc>().add(MapTripInitEvent());
        await Future.delayed(Duration(seconds: 3));
        context.read<MapTripBloc>().add(
            GetClientRequest(idClientRequest: int.parse(idClientRequest!)));
      }
      // Iniciar el temporizador
      _startTimer();
    });
  }

  // Método para iniciar el temporizador
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++; // Incrementar el contador cada segundo
      });
    });
  }

  // Método para detener el temporizador
  void _stopTimer() {
    _timer?.cancel();
  }

  // Función para formatear el tiempo en MM:ss
  String formatTime(int secondsElapsed) {
    int minutes = secondsElapsed ~/ 60;
    int seconds = secondsElapsed % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  void dispose() {
    _stopTimer(); // Detener el temporizador cuando se destruye el widget
    super.dispose();
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
          } else if (responseClientRequest is ErrorData) {
            // Manejar error
          }
        },
        child: BlocBuilder<MapTripBloc, MapTripState>(
          builder: (context, state) {
            final responseClientRequest = state.responseGetClientRequest;
            if (responseClientRequest is Success) {
              final data = responseClientRequest.data as ClientRequest;
              return MapTripContent(
                state,
                data,
                formatTime(
                    _secondsElapsed), // Pasar el tiempo formateado al contenido
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Cargar la animación Lottie
                  Lottie.asset(
                    'assets/lottie/lottie_not_history_trip.json', // Ruta a tu animación
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Preparando mapa',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
