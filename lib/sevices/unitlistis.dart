class AllUnits {
  List<Allunits>? allunits;

  AllUnits({this.allunits});

  AllUnits.fromJson(Map<String, dynamic> json) {
    if (json['allunits'] != null) {
      allunits = <Allunits>[];
      json['allunits'].forEach((v) {
        allunits!.add(new Allunits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allunits != null) {
      data['allunits'] = this.allunits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Allunits {
  String? unitId;
  String? propertyId;
  String? unitName;
  String? unitSize;
  String? bedrooms;
  String? bathrooms;
  String? rentAmount;
  String? rentType;
  String? depositAmount;
  String? gstNumber;
  String? thumbnail;

  Allunits(
      {this.unitId,
      this.propertyId,
      this.unitName,
      this.unitSize,
      this.bedrooms,
      this.bathrooms,
      this.rentAmount,
      this.rentType,
      this.depositAmount,
      this.gstNumber,
      this.thumbnail});

  Allunits.fromJson(Map<String, dynamic> json) {
    unitId = json['unitId'];
    propertyId = json['propertyId'];
    unitName = json['unitName'];
    unitSize = json['unitSize'];
    bedrooms = json['bedrooms'];
    bathrooms = json['bathrooms'];
    rentAmount = json['rentAmount'];
    rentType = json['rentType'];
    depositAmount = json['depositAmount'];
    gstNumber = json['gstNumber'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unitId'] = this.unitId;
    data['propertyId'] = this.propertyId;
    data['unitName'] = this.unitName;
    data['unitSize'] = this.unitSize;
    data['bedrooms'] = this.bedrooms;
    data['bathrooms'] = this.bathrooms;
    data['rentAmount'] = this.rentAmount;
    data['rentType'] = this.rentType;
    data['depositAmount'] = this.depositAmount;
    data['gstNumber'] = this.gstNumber;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
