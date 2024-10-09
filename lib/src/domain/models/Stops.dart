import 'dart:convert';

Map<String, Stops> StopsFromJson(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, Stops>(k, Stops.fromJson(v)));

String StopsToJson(Map<String, Stops> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Stops {
  int id;
  double lng;
  double lat;
  List<Route> routes;

  Stops({
    required this.id,
    required this.lng,
    required this.lat,
    required this.routes,
  });

  factory Stops.fromJson(Map<String, dynamic> json) => Stops(
        id: json["id"],
        lng: json["lng"].toDouble(),
        lat: json["lat"].toDouble(),
        routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lng": lng,
        "lat": lat,
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
      };
}

class Route {
  int route;
  int index;

  Route({
    required this.route,
    required this.index,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        route: json["route"],
        index: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "route": route,
        "index": index,
      };
}
