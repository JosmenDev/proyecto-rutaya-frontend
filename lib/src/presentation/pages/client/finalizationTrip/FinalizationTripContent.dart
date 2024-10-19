import 'package:flutter/material.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/presentation/colors/colors.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultButton.dart';

class Finalizationtripcontent extends StatelessWidget {
  ClientRequest? clientRequest;

  Finalizationtripcontent(this.clientRequest);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.17),
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _iconCheck(),
            _textFinished(),
            _listTilePickUp(),
            _listTileDestination(),
            _listTileAgency(),
            _listTileData(),
            Defaultbutton(
              size: size,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'client/home', (route) => false);
              },
              color: celeste,
              text: 'VOLVER AL INICIO',
            )
          ],
        ),
      ),
    );
  }

  Widget _listTilePickUp() {
    return ListTile(
      // iconColor: Colors.white,
      // textColor: Colors.white,
      leading: Icon(Icons.location_on),
      title: Text('DESDE'),
      subtitle: Text(clientRequest!.pickupDescription ?? ''),
    );
  }

  Widget _listTileDestination() {
    return ListTile(
      // iconColor: Colors.white,
      // textColor: Colors.white,
      leading: Icon(Icons.flag),
      title: Text('HASTA'),
      subtitle: Text(clientRequest!.destinationDescription ?? ''),
    );
  }

  Widget _listTileAgency() {
    return ListTile(
      // iconColor: Colors.white,
      // textColor: Colors.white,
      leading: Icon(Icons.directions_bus_sharp),
      title: Text('AGENCIA DE MICRO'),
      subtitle: Text(clientRequest!.agencyLongName ?? ''),
    );
  }

  Widget _listTileData() {
    return ListTile(
      // iconColor: Colors.white,
      // textColor: Colors.white,
      leading: Icon(Icons.route),
      title: Text('DATOS'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Tiempo de viaje: ${clientRequest!.durationRoute} minutos' ?? ''),
          Text('Distancia Recorrida: ${clientRequest!.distanceRoute} metros' ??
              ''),
          Text('Tarifa: ${clientRequest!.tarifaRoute} PEN' ?? ''),
        ],
      ),
    );
  }

  Widget _textFinished() {
    return Text(
      'TU VIAJE HA FINALIZADO',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: celeste,
      ),
    );
  }

  Widget _iconCheck() {
    return Icon(
      Icons.check_circle,
      color: celeste,
      size: 100,
    );
  }
}
