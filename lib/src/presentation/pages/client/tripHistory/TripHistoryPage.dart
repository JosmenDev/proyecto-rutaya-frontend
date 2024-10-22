import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart'; // Importa el paquete Lottie
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/tripHistory/TripHistoryContent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/tripHistory/bloc/TripHistoryBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/tripHistory/bloc/TripHistoryEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/tripHistory/bloc/TripHistoryState.dart';

class TripHistoryPage extends StatefulWidget {
  const TripHistoryPage({super.key});

  @override
  State<TripHistoryPage> createState() => _TripHistoryPageState();
}

class _TripHistoryPageState extends State<TripHistoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<TripHistoryBloc>().add(GetHistoryTrip());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripHistoryBloc, TripHistoryState>(
      builder: (context, state) {
        final response = state.response;
        if (response is Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (response is Success) {
          List<ClientRequest> data = response.data as List<ClientRequest>;
          if (data.isEmpty) {
            // Mostrar Lottie y mensaje cuando no hay historial de viajes
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Cargar la animación Lottie
                  Lottie.asset(
                    'assets/lottie/lottie_not_history_trip.json', // Ruta a tu animación
                    width: 300,
                    height: 300,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Aún no has realizado ningún viaje',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }
          return Container(
            margin: EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return TripHistoryContent(data[index]);
              },
            ),
          );
        } else if (response is Error) {
          return Center(
            child: Text('Error al cargar historial de viajes'),
          );
        }
        return Container();
      },
    );
  }
}
