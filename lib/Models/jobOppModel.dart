class JobOppurtunitesModel{

  String? jobId;
  String? jobCode;
  String? jobCategory;
  String? branchId;
  String? jabCode;
  String? jobQualification;
  String? jobProfilename;
  String? jobTitle;
  String? jobProfile;
  String? jobExperience;
  String? jobContact;
  String? postedOn;

  JobOppurtunitesModel(
      this.jobId,
      this.jobCode,
      this.jobCategory,
      this.branchId,
      this.jabCode,
      this.jobQualification,
      this.jobProfilename,
      this.jobTitle,
      this.jobProfile,
      this.jobExperience,
      this.jobContact,
      this.postedOn
      );

  factory JobOppurtunitesModel.fromJson(Map<String, dynamic> json){
    return JobOppurtunitesModel(
      json ['jobId'] ?? 0,
      json ['jobCode'] ?? 0,
      json ['jobCategory'] ?? 0,
      json ['branchId'] ?? '',
      json ['jabCode'] ?? '',
      json ['jobQualification'] ?? '',
      json ['jobProfilename'] ?? '',
      json ['jobTitle'] ?? '',
      json ['jobProfile'] ?? '',
      json ['jobExperience'] ?? '',
      json ['jobContact'] ?? '',
      json ['postedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'jobId' : jobId,
      'jobCode' : jobCode,
      'jobCategory' : jobCategory,
      'branchId' : branchId,
      'jabCode' : jabCode,
      'jobQualification' : jobQualification,
      'jobProfilename' : jobProfilename,
      'jobTitle' : jobTitle,
      'jobProfile' : jobProfile,
      'jobExperience' : jobExperience,
      'jobContact' : jobContact,
      'postedOn' : postedOn,
    };
  }
}



class AppliedJobModel{

  String? applId;
  String? jobId;
  String? userId;
  String? addedOn;

  AppliedJobModel(
      this.applId,
      this.jobId,
      this.userId,
      this.addedOn,
      );

  factory AppliedJobModel.fromJson(Map<String, dynamic> json){
    return AppliedJobModel(
      json ['applId'] ?? 0,
      json ['jobId'] ?? 0,
      json ['userId'] ?? 0,
      json ['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'applId' : applId,
      'jobId' : jobId,
      'userId' : userId,
      'addedOn' : addedOn,
    };
  }
}