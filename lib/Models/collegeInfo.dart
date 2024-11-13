class StatesDisplayModel{

  String? stid;
  String? statename;
  String? statestatus;

  StatesDisplayModel(
      this.stid,
      this.statename,
      this.statestatus,
      );

  factory StatesDisplayModel.fromJson(Map<String, dynamic> json){
    return StatesDisplayModel(
      json ['stid'] ?? 0,
      json ['statename'] ?? '',
      json ['statestatus'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'stid' : stid,
      'statename' : statename,
      'statestatus' : statestatus,
    };
  }
}


class CountryDisplayModel{

  String? countryId;
  String? countryName;
  String? countryStatus;

  CountryDisplayModel(
      this.countryId,
      this.countryName,
      this.countryStatus,
      );

  factory CountryDisplayModel.fromJson(Map<String, dynamic> json){
    return CountryDisplayModel(
      json ['countryId'] ?? 0,
      json ['countryName'] ?? '',
      json ['countryStatus'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'countryId' : countryId,
      'countryName' : countryName,
      'countryStatus' : countryStatus,
    };
  }
}

class CourseDisplayModel{

  String? courseId;
  String? courseName;
  String? courseStatus;
  String? addedOn;

  CourseDisplayModel(
      this.courseId,
      this.courseName,
      this.courseStatus,
      this.addedOn,
      );

  factory CourseDisplayModel.fromJson(Map<String, dynamic> json){
    return CourseDisplayModel(
      json ['courseId'] ?? 0,
      json ['courseName'] ?? '',
      json ['courseStatus'] ?? '',
      json ['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'courseId' : courseId,
      'courseName' : courseName,
      'courseStatus' : courseStatus,
      'addedOn' : addedOn,
    };
  }
}


class CollegeSearchResultModel {
  String? collegeId;
  String? collegeCode;
  String? collegeName;
  String? collegeRank;
  String? collegeBranches;
  String? affiliatedTo;
  String? collegeAddress;
  String? collegeCity;
  String? collegeState;
  String? collegePincode;
  String? collegeContactno;
  String? collegeEmailId;
  String? courseId;
  String? collegeStatus;
  String? addedOn;

  @override
  String toString() {
    return '$collegeName $collegeAddress $collegeState $collegeState $collegePincode $collegeCode $collegeCity';
  }

  CollegeSearchResultModel(
        this.collegeId,
        this.collegeCode,
        this.collegeName,
        this.collegeRank,
        this.collegeBranches,
        this.affiliatedTo,
        this.collegeAddress,
        this.collegeCity,
        this.collegeState,
        this.collegePincode,
        this.collegeContactno,
        this.collegeEmailId,
        this.courseId,
        this.collegeStatus,
        this.addedOn
      );

  factory CollegeSearchResultModel.fromJson(Map<String, dynamic> json){
    return CollegeSearchResultModel(
    json['collegeId'] ?? '',
    json['collegeCode'] ?? '',
    json['collegeName'] ?? '',
    json['collegeRank'] ?? '',
    json['collegeBranches'] ?? '',
    json['affiliatedTo'] ?? '',
    json['collegeAddress'] ?? '',
    json['collegeCity'] ?? '',
    json['collegeState'] ?? '',
    json['collegePincode'] ?? '',
    json['collegeContactno'] ?? '',
    json['collegeEmailId'] ?? '',
    json['courseId'] ?? '',
    json['collegeStatus'] ?? '',
    json['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'collegeId' : collegeId,
      'collegeCode' : collegeCode,
      'collegeName' : collegeName,
      'collegeRank' : collegeRank,
      'collegeBranches' : collegeBranches,
      'affiliatedTo' : affiliatedTo,
      'collegeAddress' : collegeAddress,
      'collegeCity' : collegeCity,
      'collegeState' : collegeState,
      'collegePincode' : collegePincode,
      'collegeContactno' : collegeContactno,
      'collegeEmailId' : collegeEmailId,
      'courseId' : courseId,
      'collegeStatus' : collegeStatus,
      'addedOn' : addedOn,
    };
  }
}
