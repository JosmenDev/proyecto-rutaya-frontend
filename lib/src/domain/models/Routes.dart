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
  List<double> distances;
  String? agencyName;
  String? nextArrivalTime;
  // Direcciones

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
            List<double>.from(json["distances"].map((x) => x.toDouble())),
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
