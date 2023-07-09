import 'dart:convert';

PharmacyListModel pharmacyListModelFromJson(String str) => PharmacyListModel.fromJson(json.decode(str));

String pharmacyListModelToJson(PharmacyListModel data) => json.encode(data.toJson());

class PharmacyListModel {
    List<Datum> data;
    int status;
    String message;

    PharmacyListModel({
        required this.data,
        required this.status,
        required this.message,
    });

    factory PharmacyListModel.fromJson(Map<dynamic, dynamic> json) => PharmacyListModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
    };
}

class Datum {
    int id;
    String name;
    String lat;
    String long;
    String streetAddress;
    dynamic createdAt;
    dynamic updatedAt;
    int distance;

    Datum({
        required this.id,
        required this.name,
        required this.lat,
        required this.long,
        required this.streetAddress,
        this.createdAt,
        this.updatedAt,
        required this.distance,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        lat: json["lat"],
        long: json["long"],
        streetAddress: json["street_address"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        distance: json["distance"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lat": lat,
        "long": long,
        "street_address": streetAddress,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "distance": distance,
    };
}
