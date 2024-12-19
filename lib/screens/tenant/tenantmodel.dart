class TenantModel {
  List<Alltenants>? alltenants;

  TenantModel({this.alltenants});

  TenantModel.fromJson(Map<String, dynamic> json) {
    if (json['alltenants'] != null) {
      alltenants = <Alltenants>[];
      json['alltenants'].forEach((v) {
        alltenants!.add( Alltenants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (alltenants != null) {
      data['alltenants'] = alltenants!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tenantId'] = tenantId;
    data['tenantFirstName'] = tenantFirstName;
    data['tenantLastName'] = tenantLastName;
    data['tenantEmail'] = tenantEmail;
    data['tenantPhoneNumber'] = tenantPhoneNumber;
    data['tenantNumbers'] = tenantNumbers;
    data['tenantProfileImage'] = tenantProfileImage;
    data['tenantCountry'] = tenantCountry;
    data['tenantStateList'] = tenantStateList;
    data['tenantCity'] = tenantCity;
    data['tenantZipcode'] = tenantZipcode;
    data['tenantAddress'] = tenantAddress;
    data['tenantAddDate'] = tenantAddDate;
    return data;
  }
}
