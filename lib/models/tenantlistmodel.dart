// ignore_for_file: prefer_collection_literals, unnecessary_this

class Tenazlist {
  String? status;
  List<Data>? data;

  Tenazlist({this.status, this.data});

  Tenazlist.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        // ignore: unnecessary_new
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? tenantId;
  String? propertyName;
  String? cityName;
  String? tenantName;
  String? unitName;
  String? image;

  Data(
      {this.tenantId,
      this.propertyName,
      this.cityName,
      this.tenantName,
      this.unitName,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    tenantId = json['tenantId'];
    propertyName = json['propertyName'];
    cityName = json['cityName'];
    tenantName = json['tenantName'];
    unitName = json['unitName'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenantId'] = tenantId;
    data['propertyName'] = this.propertyName;
    data['cityName'] = this.cityName;
    data['tenantName'] = this.tenantName;
    data['unitName'] = this.unitName;
    data['Image'] = this.image;
    return data;
  }
}
