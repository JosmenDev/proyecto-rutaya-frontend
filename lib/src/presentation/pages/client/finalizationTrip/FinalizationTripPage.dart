import 'package:flutter/material.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/presentation/colors/colors.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/FinalizationTrip/FinalizationTripContent.dart';

class FinalizationTripPage extends StatefulWidget {
  const FinalizationTripPage({super.key});

  @override
  State<FinalizationTripPage> createState() => _FinalizationTripPageState();
}

class _FinalizationTripPageState extends State<FinalizationTripPage> {
  ClientRequest? clientRequest;
  String? duration;

  @override
  Widget build(BuildContext context) {
    // Recibir los argumentos como un Map
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    // Extraer los valores del Map
    clientRequest = arguments['clientRequest'] as ClientRequest?;
    duration = arguments['duration'] as String?;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.topLeft,
            colors: [Colors.cyan, celeste],
          ),
        ),
        // Pasar tanto clientRequest como duration al widget Finalizationtripcontent
        child: FinalizationTripContent(clientRequest, duration),
      ),
    );
  }
}
