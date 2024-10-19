import 'package:flutter/material.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';

class Finalizationtripcontent extends StatelessWidget {
  ClientRequest? clientRequest;

  Finalizationtripcontent(this.clientRequest);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
          ],
        ),
      ),
    );
  }

  Widget _listTilePickUp() {
    return ListTile(
      iconColor: Colors.white,
      textColor: Colors.white,
      leading: Icon(Icons.location_on),
      title: Text('DESDE'),
      subtitle: Text(clientRequest!.pickupDescription ?? ''),
    );
  }

  Widget _listTileDestination() {
    return ListTile(
      iconColor: Colors.white,
      textColor: Colors.white,
      leading: Icon(Icons.flag),
      title: Text('HASTA'),
      subtitle: Text(clientRequest!.destinationDescription ?? ''),
    );
  }

  Widget _listTileAgency() {
    return ListTile(
      iconColor: Colors.white,
      textColor: Colors.white,
      leading: Icon(Icons.directions_bus_sharp),
      title: Text('AGENCIA DE MICRO'),
      subtitle: Text(clientRequest!.agencyLongName ?? ''),
    );
  }

  Widget _listTileData() {
    return ListTile(
      iconColor: Colors.white,
      textColor: Colors.white,
      leading: Icon(Icons.route),
      title: Text('DATOS'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tiempo de viaje: ${clientRequest!.idClient} minutos' ?? ''),
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
        color: Colors.white,
      ),
    );
  }

  Widget _iconCheck() {
    return Icon(
      Icons.check_circle,
      color: Colors.white,
      size: 100,
    );
  }
}
