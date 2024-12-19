// ignore_for_file: unnecessary_new, unnecessary_this

class PropertiesDisplay {
  List<Allproperties>? allproperties;

  PropertiesDisplay({this.allproperties});

  PropertiesDisplay.fromJson(Map<String, dynamic> json) {
    if (json['allproperties'] != null) {
      allproperties = <Allproperties>[];
      json['allproperties'].forEach((v) {
        allproperties!.add(new Allproperties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allproperties != null) {
      data['allproperties'] =
          allproperties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Allproperties {
  String? propertyId;
  String? propertyType;
  String? propertyName;
  String? propertySize;
  String? propertyYearlyTax;
  String? propertyThumbnail;
  String? propertyCountry;
  String? propertyState;
  String? propertyCity;
  String? propertyZipcode;
  String? propertyAddress;
  String? propertyAddDate;
  String? userId;
  String? propertyStatus;

  Allproperties(
      {this.propertyId,
      this.propertyType,
      this.propertyName,
      this.propertySize,
      this.propertyYearlyTax,
      this.propertyThumbnail,
      this.propertyCountry,
      this.propertyState,
      this.propertyCity,
      this.propertyZipcode,
      this.propertyAddress,
      this.propertyAddDate,
      this.userId,
      this.propertyStatus});

  Allproperties.fromJson(Map<String, dynamic> json) {
    propertyId = json['propertyId'];
    propertyType = json['propertyType'];
    propertyName = json['propertyName'];
    propertySize = json['propertySize'];
    propertyYearlyTax = json['propertyYearlyTax'];
    propertyThumbnail = json['propertyThumbnail'];
    propertyCountry = json['propertyCountry'];
    propertyState = json['propertyState'];
    propertyCity = json['propertyCity'];
    propertyZipcode = json['propertyZipcode'];
    propertyAddress = json['propertyAddress'];
    propertyAddDate = json['propertyAddDate'];
    userId = json['userId'];
    propertyStatus = json['propertyStatus'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['propertyId'] = this.propertyId;
    data['propertyType'] = this.propertyType;
    data['propertyName'] = this.propertyName;
    data['propertySize'] = this.propertySize;
    data['propertyYearlyTax'] = this.propertyYearlyTax;
    data['propertyThumbnail'] = this.propertyThumbnail;
    data['propertyCountry'] = this.propertyCountry;
    data['propertyState'] = this.propertyState;
    data['propertyCity'] = this.propertyCity;
    data['propertyZipcode'] = this.propertyZipcode;
    data['propertyAddress'] = this.propertyAddress;
    data['propertyAddDate'] = this.propertyAddDate;
    data['userId'] = this.userId;
    data['propertyStatus'] = this.propertyStatus;
    return data;
  }
}
