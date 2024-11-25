class TenantModel {
  List<Alltenants>? alltenants;

  TenantModel({this.alltenants});

  TenantModel.fromJson(Map<String, dynamic> json) {
    if (json['alltenants'] != null) {
      alltenants = <Alltenants>[];
      json['alltenants'].forEach((v) {
        alltenants!.add(new Alltenants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.alltenants != null) {
      data['alltenants'] = this.alltenants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Alltenants {
  String? tenantId;
  String? tenantFirstName;
  String? tenantLastName;
  String? tenantEmail;
  String? tenantPhoneNumber;
  String? tenantNumbers;
  String? tenantProfileImage;
  String? tenantCountry;
  String? tenantStateList;
  String? tenantCity;
  String? tenantZipcode;
  String? tenantAddress;
  String? tenantAddDate;

  Alltenants(
      {this.tenantId,
      this.tenantFirstName,
      this.tenantLastName,
      this.tenantEmail,
      this.tenantPhoneNumber,
      this.tenantNumbers,
      this.tenantProfileImage,
      this.tenantCountry,
      this.tenantStateList,
      this.tenantCity,
      this.tenantZipcode,
      this.tenantAddress,
      this.tenantAddDate});

  Alltenants.fromJson(Map<String, dynamic> json) {
    tenantId = json['tenantId'];
    tenantFirstName = json['tenantFirstName'];
    tenantLastName = json['tenantLastName'];
    tenantEmail = json['tenantEmail'];
    tenantPhoneNumber = json['tenantPhoneNumber'];
    tenantNumbers = json['tenantNumbers'];
    tenantProfileImage = json['tenantProfileImage'];
    tenantCountry = json['tenantCountry'];
    tenantStateList = json['tenantStateList'];
    tenantCity = json['tenantCity'];
    tenantZipcode = json['tenantZipcode'];
    tenantAddress = json['tenantAddress'];
    tenantAddDate = json['tenantAddDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenantId'] = this.tenantId;
    data['tenantFirstName'] = this.tenantFirstName;
    data['tenantLastName'] = this.tenantLastName;
    data['tenantEmail'] = this.tenantEmail;
    data['tenantPhoneNumber'] = this.tenantPhoneNumber;
    data['tenantNumbers'] = this.tenantNumbers;
    data['tenantProfileImage'] = this.tenantProfileImage;
    data['tenantCountry'] = this.tenantCountry;
    data['tenantStateList'] = this.tenantStateList;
    data['tenantCity'] = this.tenantCity;
    data['tenantZipcode'] = this.tenantZipcode;
    data['tenantAddress'] = this.tenantAddress;
    data['tenantAddDate'] = this.tenantAddDate;
    return data;
  }
}
