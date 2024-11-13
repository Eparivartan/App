class BranchDropdownModel{

  String? id;
  String? cname;
  String? status;
  String? addedOn;

  BranchDropdownModel(
      this.id,
      this.cname,
      this.status,
      this.addedOn,
      );

  factory BranchDropdownModel.fromJson(Map<String, dynamic> json){
    return BranchDropdownModel(
      json ['id'] ?? 0,
      json ['cname'] ?? '',
      json ['status'] ?? '',
      json ['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id' : id,
      'cname' : cname,
      'status' : status,
      'addedOn' : addedOn,
    };
  }
}


class SelectSoftwareDropdownModel{

  String? postId;
  String? postTitle;

  SelectSoftwareDropdownModel(
      this.postId,
      this.postTitle,
      );

  factory SelectSoftwareDropdownModel.fromJson(Map<String, dynamic> json){
    return SelectSoftwareDropdownModel(
      json ['postId'] ?? 0,
      json ['postTitle'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'postId' : postId,
      'postTitle' : postTitle,
    };
  }
}


class CommandsListModel{

  String? postId;
  String? catid;
  String? postTitle;
  String? postContent;
  String? releasedBy;
  String? licenceAvailable;
  String? releaseYear;
  String? softwareUse;
  String? downloadLink;
  String? courseId;
  String? swCode;
  String? codeDescription;
  String? codeStatus;
  String? postStatus;
  String? addedOn;

  CommandsListModel([this.postId, this.catid, this.postTitle, this.postContent, this.releasedBy, this.licenceAvailable, this.releaseYear,
      this.softwareUse, this.downloadLink, this.courseId, this.swCode, this.codeDescription, this.codeStatus, this.postStatus, this.addedOn]);

  factory CommandsListModel.fromJson(Map<String, dynamic> json){
    return CommandsListModel(
      json ['postId'] ?? 0,
      json ['catid'] ?? '',
      json ['postTitle'] ?? '',
      json ['postContent'] ?? '',
      json ['releasedBy'] ?? '',
      json ['licenceAvailable'] ?? '',
      json ['releaseYear'] ?? '',
      json ['softwareUse'] ?? '',
      json ['downloadLink'] ?? '',
      json ['courseId'] ?? '',
      json ['swCode'] ?? '',
      json ['codeDescription'] ?? '',
      json ['codeStatus'] ?? '',
      json ['postStatus'] ?? '',
      json ['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'postId' : postId,
      'catid' : catid,
      'postTitle' : postTitle,
      'postContent' : postContent,
      'releasedBy' : releasedBy,
      'licenceAvailable' : licenceAvailable,
      'releaseYear' : releaseYear,
      'softwareUse' : softwareUse,
      'downloadLink' : downloadLink,
      'courseId' : courseId,
      'swCode' : swCode,
      'codeDescription' : codeDescription,
      'codeStatus' : codeStatus,
      'postStatus' : postStatus,
      'addedOn' : addedOn,
    };
  }
}