class AllUnits {
  List<Allunits>? allunits;

  AllUnits({this.allunits});

  AllUnits.fromJson(Map<String, dynamic> json) {
    if (json['allunits'] != null) {
      allunits = <Allunits>[];
      json['allunits'].forEach((v) {
        allunits!.add(Allunits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (allunits != null) {
      data['allunits'] = allunits!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unitId'] = unitId;
    data['propertyId'] = propertyId;
    data['unitName'] = unitName;
    data['unitSize'] = unitSize;
    data['bedrooms'] = bedrooms;
    data['bathrooms'] = bathrooms;
    data['rentAmount'] = rentAmount;
    data['rentType'] = rentType;
    data['depositAmount'] = depositAmount;
    data['gstNumber'] = gstNumber;
    data['thumbnail'] = thumbnail;
    return data;
  }
}
