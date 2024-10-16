import 'dart:convert';

List<Routes> RoutesFromJson(String str) =>
    List<Routes>.from(json.decode(str).map((x) => Routes.fromJson(x)));

String RoutesToJson(List<Routes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Routes {
  int id;
  String name;
  List<int> stops;
  String from;
  String to;
  List<Connection> connections;
  List<String> distances;
  String? agencyName;
  String? nextArrivalTime;
  String? distanceToDisplay;
  String? totalEstimatedTime;

  // Nuevos campos
  String? originStopDescription;
  String? destinationStopDescription;
  double? originStopLat;
  double? originStopLng;
  double? destStopLat;
  double? destStopLng;

  Routes({
    required this.id,
    required this.name,
    required this.stops,
    required this.from,
    required this.to,
    required this.connections,
    required this.distances,
    this.agencyName,
    this.nextArrivalTime,
    this.distanceToDisplay,
    this.totalEstimatedTime,
    this.originStopDescription,
    this.destinationStopDescription,
    this.originStopLat,
    this.originStopLng,
    this.destStopLat,
    this.destStopLng,
  });

  factory Routes.fromJson(Map<String, dynamic> json) => Routes(
        id: json["id"],
        name: json["name"],
        stops: List<int>.from(json["stops"].map((x) => x)),
        from: json["from"],
        to: json["to"],
        connections: List<Connection>.from(
            json["connections"].map((x) => Connection.fromJson(x))),
        distances:
            List<String>.from(json["distances"].map((x) => x.toString())),
        agencyName: json["agencyName"],
        nextArrivalTime: json["nextArrivalTime"],
        distanceToDisplay: json["distanceToDisplay"] != null
            ? json["distanceToDisplay"].toString()
            : null,
        totalEstimatedTime: json["totalEstimatedTime"],
        originStopDescription: json["originStopDescription"], // Nuevo campo
        destinationStopDescription:
            json["destinationStopDescription"], // Nuevo campo
        originStopLat: json["originStopLat"] != null
            ? json["originStopLat"].toDouble()
            : null, // Nuevo campo
        originStopLng: json["originStopLng"] != null
            ? json["originStopLng"].toDouble()
            : null, // Nuevo campo
        destStopLat: json["destStopLat"] != null
            ? json["destStopLat"].toDouble()
            : null, // Nuevo campo
        destStopLng: json["destStopLng"] != null
            ? json["destStopLng"].toDouble()
            : null, // Nuevo campo
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "stops": List<dynamic>.from(stops.map((x) => x)),
        "from": from,
        "to": to,
        "connections": List<dynamic>.from(connections.map((x) => x.toJson())),
        "distances": List<dynamic>.from(distances.map((x) => x)),
        "agencyName": agencyName,
        "nextArrivalTime": nextArrivalTime,
        "distanceToDisplay": distanceToDisplay,
        "totalEstimatedTime": totalEstimatedTime,

        "originStopDescription": originStopDescription, // Nuevo campo
        "destinationStopDescription": destinationStopDescription, // Nuevo campo
        "originStopLat": originStopLat, // Nuevo campo
        "originStopLng": originStopLng, // Nuevo campo
        "destStopLat": destStopLat, // Nuevo campo
        "destStopLng": destStopLng, // Nuevo campo
      };
}

class Connection {
  int otherRoute;
  int mine;
  int other;

  Connection({
    required this.otherRoute,
    required this.mine,
    required this.other,
  });

  factory Connection.fromJson(Map<String, dynamic> json) => Connection(
        otherRoute: json["other_route"],
        mine: json["mine"],
        other: json["other"],
      );

  Map<String, dynamic> toJson() => {
        "other_route": otherRoute,
        "mine": mine,
        "other": other,
      };
}
