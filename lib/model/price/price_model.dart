class PriceCalculationModel {
  int? status;
  String? message;
  Data? data;

  PriceCalculationModel({this.status, this.message, this.data});

  PriceCalculationModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? price;
  String? tax;
  int? priceAfterTax;
  int? discountedPrice;
  String? payNow;

  Data({this.price, this.tax, this.priceAfterTax, this.discountedPrice});

  Data.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    tax = json['tax'];
    priceAfterTax = json['price_after_tax'];
    discountedPrice = json['discounted_price'];
    payNow = json['pay_now'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['price_after_tax'] = this.priceAfterTax;
    data['discounted_price'] = this.discountedPrice;
    data['pay_now'] = this.payNow;

    return data;
  }
}