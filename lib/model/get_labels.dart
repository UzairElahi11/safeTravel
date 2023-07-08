class GetLabels {
  int? status;
  String? message;
  Data? data;

  GetLabels({this.status, this.message, this.data});

  GetLabels.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<String>? healthConditions;
  List<String>? medicalAllergies;
  List<String>? foodAllergies;
  List<String>? disabilities;

  Data(
      {this.healthConditions,
      this.medicalAllergies,
      this.foodAllergies,
      this.disabilities});

  Data.fromJson(Map<String, dynamic> json) {
    healthConditions = json['health_conditions'].cast<String>();
    medicalAllergies = json['medical_allergies'].cast<String>();
    foodAllergies = json['food_allergies'].cast<String>();
    disabilities = json['disabilities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['health_conditions'] = healthConditions;
    data['medical_allergies'] = medicalAllergies;
    data['food_allergies'] = foodAllergies;
    data['disabilities'] = disabilities;
    return data;
  }
}
