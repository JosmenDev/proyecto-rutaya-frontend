import 'package:flutter/material.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:intl/intl.dart'; // Para formatear la fecha

class TripHistoryContent extends StatelessWidget {
  final ClientRequest clientRequest;

  TripHistoryContent(this.clientRequest);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateSection(), // Fecha
            SizedBox(height: 8),
            _buildRouteDescription(), // Descripción de la ruta
            SizedBox(height: 12),
            _buildTransportIcons(), // Iconos de transporte
            SizedBox(height: 12),
            _buildTripDetails(), // Detalles de tiempo y tarifa
          ],
        ),
      ),
    );
  }

  // Sección de fecha
  Widget _buildDateSection() {
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(clientRequest.date!));
    return Text(
      formattedDate,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.grey[700],
      ),
    );
  }

  // Descripción de la ruta
  Widget _buildRouteDescription() {
    return Text(
      '${clientRequest.pickupDescription} - ${clientRequest.destinationDescription}',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  // Iconos de transporte
  Widget _buildTransportIcons() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 17,
      ),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.directions_walk, size: 24, color: Colors.grey[600]),
              Icon(Icons.chevron_right, size: 24, color: Colors.grey[600]),
              Column(
                children: [
                  Icon(Icons.directions_bus, size: 24, color: Colors.grey[600]),
                  Text(
                    clientRequest.agencyLongName!,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              Icon(Icons.chevron_right, size: 24, color: Colors.grey[600]),
              Icon(Icons.directions_walk, size: 24, color: Colors.grey[600]),
            ],
          ),
        ),
      ),
    );
  }

  // Detalles del viaje (tiempo, distancia, tarifa)
  Widget _buildTripDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDetailItem('Tiempo empleado', '18 min'),
        _buildDetailItem('Distancia', '${clientRequest.distanceRoute} m'),
        _buildDetailItem('Tarifa', '${clientRequest.tarifaRoute} PEN'),
      ],
    );
  }

  // Helper para construir los detalles
  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
