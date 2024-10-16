import 'dart:convert';

ClientRequest clientRequestFromJson(String str) =>
    ClientRequest.fromJson(json.decode(str));

String clientRequestToJson(ClientRequest data) => json.encode(data.toJson());

class ClientRequest {
  int? id;
  int idClient;
  String pickupDescription;
  String destinationDescription;
  double pickupLat;
  double pickupLng;
  double destinationLat;
  double destinationLng;
  double? pickupStopLat;
  double? pickupStopLng;
  double? destinationStopLat;
  double? destinationStopLng;
  double? tarifaRoute;

  ClientRequest({
    this.id,
    required this.idClient,
    required this.pickupDescription,
    required this.destinationDescription,
    required this.pickupLat,
    required this.pickupLng,
    required this.destinationLat,
    required this.destinationLng,
    this.pickupStopLat,
    this.pickupStopLng,
    this.destinationStopLat,
    this.destinationStopLng,
    this.tarifaRoute,
  });

  factory ClientRequest.fromJson(Map<String, dynamic> json) => ClientRequest(
        id: json["id"],
        idClient: json["id_client"],
        pickupDescription: json["pickup_description"],
        destinationDescription: json["destination_description"],

        // Verificar si es String y convertirlo a double
        pickupLat: json["pickup_lat"] is String
            ? double.parse(json["pickup_lat"])
            : json["pickup_lat"]?.toDouble(),
        pickupLng: json["pickup_lng"] is String
            ? double.parse(json["pickup_lng"])
            : json["pickup_lng"]?.toDouble(),
        destinationLat: json["destination_lat"] is String
            ? double.parse(json["destination_lat"])
            : json["destination_lat"]?.toDouble(),
        destinationLng: json["destination_lng"] is String
            ? double.parse(json["destination_lng"])
            : json["destination_lng"]?.toDouble(),

        pickupStopLat: json["pickup_stop_lat"] is String
            ? double.parse(json["pickup_stop_lat"])
            : json["pickup_stop_lat"]?.toDouble(),
        pickupStopLng: json["pickup_stop_lng"] is String
            ? double.parse(json["pickup_stop_lng"])
            : json["pickup_stop_lng"]?.toDouble(),
        destinationStopLat: json["destination_stop_lat"] is String
            ? double.parse(json["destination_stop_lat"])
            : json["destination_stop_lat"]?.toDouble(),
        destinationStopLng: json["destination_stop_lng"] is String
            ? double.parse(json["destination_stop_lng"])
            : json["destination_stop_lng"]?.toDouble(),

        tarifaRoute: json["tarifa_route"] is String
            ? double.parse(json["tarifa_route"])
            : json["tarifa_route"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_client": idClient,
        "pickup_description": pickupDescription,
        "destination_description": destinationDescription,
        "pickup_lat": pickupLat,
        "pickup_lng": pickupLng,
        "destination_lat": destinationLat,
        "destination_lng": destinationLng,
        "pickup_stop_lat": pickupStopLat,
        "pickup__stop_lng": pickupStopLng,
        "destination_stop_lat": destinationStopLat,
        "destination_stop_lng": destinationStopLng,
        "tarifa_route": tarifaRoute,
      };
}
