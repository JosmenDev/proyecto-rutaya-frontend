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
  @override
  Widget build(BuildContext context) {
    clientRequest = ModalRoute.of(context)?.settings.arguments as ClientRequest;
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: [Colors.cyan, celeste])),
          child: Finalizationtripcontent(clientRequest)),
    );
  }
}
