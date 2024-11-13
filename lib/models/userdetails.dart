class Userdetails {
  int? id;
  String? userFirstName;
  String? userLastName;
  String? userEmail;
  String? userMobile;
  String? userPassword;
  String? userImage;
  String? userToken;
  int? status;
  String? addOn;

  Userdetails(
      {this.id,
      this.userFirstName,
      this.userLastName,
      this.userEmail,
      this.userMobile,
      this.userPassword,
      this.userImage,
      this.userToken,
      this.status,
      this.addOn});

  Userdetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userFirstName = json['userFirstName'];
    userLastName = json['userLastName'];
    userEmail = json['userEmail'];
    userMobile = json['userMobile'];
    userPassword = json['userPassword'];
    userImage = json['userImage'];
    userToken = json['userToken'];
    status = json['status'];
    addOn = json['addOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userFirstName'] = this.userFirstName;
    data['userLastName'] = this.userLastName;
    data['userEmail'] = this.userEmail;
    data['userMobile'] = this.userMobile;
    data['userPassword'] = this.userPassword;
    data['userImage'] = this.userImage;
    data['userToken'] = this.userToken;
    data['status'] = this.status;
    data['addOn'] = this.addOn;
    return data;
  }
}
