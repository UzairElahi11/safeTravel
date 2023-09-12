// To parse this JSON data, do
//
//     final referalModel = referalModelFromJson(jsonString);

import 'dart:convert';

ReferalModel referalModelFromJson(String str) => ReferalModel.fromJson(json.decode(str));

String referalModelToJson(ReferalModel data) => json.encode(data.toJson());

class ReferalModel {
    int status;
    String message;
    Data? data;

    ReferalModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory ReferalModel.fromJson(Map<dynamic, dynamic> json) => ReferalModel(
        status: json["status"],
        message: json["message"],
        data:json["data"]!=null? Data.fromJson(json["data"]):null,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data":data!=null? data!.toJson():null,
    };
}

class Data {
    int? price;
    String? tax;
    int? priceAfterTax;
    int? couponId;
    int? discountedPrice;

    Data({
        required this.price,
        required this.tax,
        required this.priceAfterTax,
        required this.couponId,
        required this.discountedPrice,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        price: json["price"]??0,
        tax: json["tax"]??"0",
        priceAfterTax: json["price_after_tax"]??0,
        couponId: json["coupon_id"]??0,
        discountedPrice: json["discounted_price"]??0,
    );

    Map<String, dynamic> toJson() => {
        "price": price,
        "tax": tax,
        "price_after_tax": priceAfterTax,
        "coupon_id": couponId,
        "discounted_price": discountedPrice,
    };
}
