// To parse this JSON data, do
//
//     final geoRoutes = geoRoutesFromJson(jsonString);

import 'dart:convert';

GeoRoutes geoRoutesFromJson(String str) => GeoRoutes.fromJson(json.decode(str));

String geoRoutesToJson(GeoRoutes data) => json.encode(data.toJson());

class GeoRoutes {
  String type;
  List<Feature> features;

  GeoRoutes({
    required this.type,
    required this.features,
  });

  factory GeoRoutes.fromJson(Map<String, dynamic> json) => GeoRoutes(
        type: json["type"],
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class Feature {
  String type;
  Properties properties;
  Geometry geometry;
  Gtfs gtfs;

  Feature({
    required this.type,
    required this.properties,
    required this.geometry,
    required this.gtfs,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: json["type"],
        properties: Properties.fromJson(json["properties"]),
        geometry: Geometry.fromJson(json["geometry"]),
        gtfs: Gtfs.fromJson(json["gtfs"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "properties": properties.toJson(),
        "geometry": geometry.toJson(),
        "gtfs": gtfs.toJson(),
      };
}

class Geometry {
  String type;
  List<List<double>> coordinates;
  List<int> nodes;

  Geometry({
    required this.type,
    required this.coordinates,
    required this.nodes,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: List<List<double>>.from(json["coordinates"]
            .map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
        nodes: List<int>.from(json["nodes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(
            coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "nodes": List<dynamic>.from(nodes.map((x) => x)),
      };
}

class Gtfs {
  int agencyId;
  List<Service> services;
  int routeId;
  FilteredStops filteredStops;

  Gtfs({
    required this.agencyId,
    required this.services,
    required this.routeId,
    required this.filteredStops,
  });

  factory Gtfs.fromJson(Map<String, dynamic> json) => Gtfs(
        agencyId: json["agency_id"],
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
        routeId: json["route_id"],
        filteredStops: FilteredStops.fromJson(json["filteredStops"]),
      );

  Map<String, dynamic> toJson() => {
        "agency_id": agencyId,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "route_id": routeId,
        "filteredStops": filteredStops.toJson(),
      };
}

class FilteredStops {
  List<int> nodes;
  List<List<double>> coordinates;

  FilteredStops({
    required this.nodes,
    required this.coordinates,
  });

  factory FilteredStops.fromJson(Map<String, dynamic> json) => FilteredStops(
        nodes: List<int>.from(json["nodes"].map((x) => x)),
        coordinates: List<List<double>>.from(json["coordinates"]
            .map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
      );

  Map<String, dynamic> toJson() => {
        "nodes": List<dynamic>.from(nodes.map((x) => x)),
        "coordinates": List<dynamic>.from(
            coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class Service {
  String serviceId;
  String startTime;
  String endTime;
  int tripId;

  Service({
    required this.serviceId,
    required this.startTime,
    required this.endTime,
    required this.tripId,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        serviceId: json["service_id"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        tripId: json["trip_id"],
      );

  Map<String, dynamic> toJson() => {
        "service_id": serviceId,
        "startTime": startTime,
        "endTime": endTime,
        "trip_id": tripId,
      };
}

class Properties {
  String checkPt;
  String distance;
  String duration;
  String fee;
  String from;
  String interval;
  String name;
  String network;
  String openingHours;
  String propertiesOperator;
  String publicTransportVersion;
  String ref;
  String route;
  String source;
  String to;
  String type;
  int id;

  Properties({
    required this.checkPt,
    required this.distance,
    required this.duration,
    required this.fee,
    required this.from,
    required this.interval,
    required this.name,
    required this.network,
    required this.openingHours,
    required this.propertiesOperator,
    required this.publicTransportVersion,
    required this.ref,
    required this.route,
    required this.source,
    required this.to,
    required this.type,
    required this.id,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        checkPt: json["check_pt"],
        distance: json["distance"],
        duration: json["duration"],
        fee: json["fee"],
        from: json["from"],
        interval: json["interval"],
        name: json["name"],
        network: json["network"],
        openingHours: json["opening_hours"],
        propertiesOperator: json["operator"],
        publicTransportVersion: json["public_transport:version"],
        ref: json["ref"],
        route: json["route"],
        source: json["source"],
        to: json["to"],
        type: json["type"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "check_pt": checkPt,
        "distance": distance,
        "duration": duration,
        "fee": fee,
        "from": from,
        "interval": interval,
        "name": name,
        "network": network,
        "opening_hours": openingHours,
        "operator": propertiesOperator,
        "public_transport:version": publicTransportVersion,
        "ref": ref,
        "route": route,
        "source": source,
        "to": to,
        "type": type,
        "id": id,
      };
}
