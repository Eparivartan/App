class UserProfileModel{

  String? profId;
  String? userId;
  String? profileName;
  String? phoneNumber;
  String? addedOn;

  UserProfileModel(
      this.profId,
      this.userId,
      this.profileName,
      this.phoneNumber,
      this.addedOn,
      );

  factory UserProfileModel.fromJson(Map<String, dynamic> json){
    return UserProfileModel(
      json ['profId'] ?? 0,
      json ['userId'] ?? '',
      json ['profileName'] ?? '',
      json ['phoneNumber'] ?? '',
      json ['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'profId' : profId,
      'userId' : userId,
      'profileName' : profileName,
      'phoneNumber' : phoneNumber,
      'addedOn' : addedOn,
    };
  }
}