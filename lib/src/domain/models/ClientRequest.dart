import 'dart:convert';

// Funciones para convertir entre JSON y ClientRequest
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
  String? agencyLongName;
  double? pickupStopLat;
  double? pickupStopLng;
  double? destinationStopLat;
  double? destinationStopLng;
  double? tarifaRoute;
  double? distanceRoute;
  String? durationRoute;
  String? date;

  // Constructor
  ClientRequest({
    this.id,
    required this.idClient,
    required this.pickupDescription,
    required this.destinationDescription,
    required this.pickupLat,
    required this.pickupLng,
    required this.destinationLat,
    required this.destinationLng,
    this.agencyLongName,
    this.pickupStopLat,
    this.pickupStopLng,
    this.destinationStopLat,
    this.destinationStopLng,
    this.tarifaRoute,
    this.distanceRoute,
    this.durationRoute,
    this.date,
  });

  // Método para crear una instancia de ClientRequest desde un JSON
  factory ClientRequest.fromJson(Map<String, dynamic> json) => ClientRequest(
        id: json["id"],
        idClient: json["id_client"],
        pickupDescription: json["pickup_description"] ?? '',
        destinationDescription: json["destination_description"] ?? '',

        // Verificar si es String y convertir a double, usando 0.0 si es null
        pickupLat: (json["pickup_lat"] != null && json["pickup_lat"] is String)
            ? double.parse(json["pickup_lat"])
            : json["pickup_lat"]?.toDouble() ?? 0.0,
        pickupLng: (json["pickup_lng"] != null && json["pickup_lng"] is String)
            ? double.parse(json["pickup_lng"])
            : json["pickup_lng"]?.toDouble() ?? 0.0,
        destinationLat: (json["destination_lat"] != null &&
                json["destination_lat"] is String)
            ? double.parse(json["destination_lat"])
            : json["destination_lat"]?.toDouble() ?? 0.0,
        destinationLng: (json["destination_lng"] != null &&
                json["destination_lng"] is String)
            ? double.parse(json["destination_lng"])
            : json["destination_lng"]?.toDouble() ?? 0.0,

        agencyLongName: json["agency_long_name"],
        pickupStopLat: json["pickup_stop_lat"] != null
            ? double.parse(json["pickup_stop_lat"].toString())
            : null,
        pickupStopLng: json["pickup_stop_lng"] != null
            ? double.parse(json["pickup_stop_lng"].toString())
            : null,
        destinationStopLat: json["destination_stop_lat"] != null
            ? double.parse(json["destination_stop_lat"].toString())
            : null,
        destinationStopLng: json["destination_stop_lng"] != null
            ? double.parse(json["destination_stop_lng"].toString())
            : null,
        tarifaRoute: json["tarifa_route"] != null
            ? double.parse(json["tarifa_route"].toString())
            : null,
        distanceRoute: json["distance_route"] != null
            ? double.parse(json["distance_route"].toString())
            : null,
        durationRoute: json["duration"]?.toString(),
        date: json["date"]?.toString(),
      );

  // Método para convertir la instancia a JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "id_client": idClient,
        "pickup_description": pickupDescription,
        "destination_description": destinationDescription,
        "pickup_lat": pickupLat,
        "pickup_lng": pickupLng,
        "destination_lat": destinationLat,
        "destination_lng": destinationLng,
        "agency_long_name": agencyLongName,
        "pickup_stop_lat": pickupStopLat,
        "pickup__stop_lng": pickupStopLng,
        "destination_stop_lat": destinationStopLat,
        "destination_stop_lng": destinationStopLng,
        "tarifa_route": tarifaRoute,
        "distance_route": distanceRoute,
        "duration": durationRoute,
        "date": date,
      };

  // Método para convertir una lista de JSONs a una lista de ClientRequest
  static List<ClientRequest> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ClientRequest.fromJson(json)).toList();
  }
}
