class AllAboutEngineersModel{

  String? id;
  String? catname;
  String? catimage;
  String? status;
  String? addedOn;

  AllAboutEngineersModel(
      this.id,
      this.catname,
      this.catimage,
      this.status,
      this.addedOn,
      );

  factory AllAboutEngineersModel.fromJson(Map<String, dynamic> json){
    return AllAboutEngineersModel(
      json ['id'] ?? 0,
      json ['catname'] ?? '',
      json ['catimage'] ?? '',
      json ['status'] ?? '',
      json ['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id' : id,
      'catname' : catname,
      'catimage' : catimage,
      'status' : status,
      'addedOn' : addedOn,
    };
  }
}

class EngineeringBasicsModel{

  String? postId;
  String? postTitle;
  String? postContent;
  String? postStatus;
  String? addedOn;

  EngineeringBasicsModel(
      this.postId,
      this.postTitle,
      this.postContent,
      this.postStatus,
      this.addedOn,
      );

  factory EngineeringBasicsModel.fromJson(Map<String, dynamic> json){
    return EngineeringBasicsModel(
      json ['postId'] ?? 0,
      json ['postTitle'] ?? '',
      json ['postContent'] ?? '',
      json ['postStatus'] ?? '',
      json ['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'postId' : postId,
      'postTitle' : postTitle,
      'postContent' : postContent,
      'postStatus' : postStatus,
      'addedOn' : addedOn,
    };
  }
}

class EngineeringBranchesModel{

  String? postId;
  String? postType;
  String? catid;
  String? postTitle;
  String? postContent;
  String? postStatus;
  String? addedOn;

  EngineeringBranchesModel(
      this.postId,
      this.postType,
      this.catid,
      this.postTitle,
      this.postContent,
      this.postStatus,
      this.addedOn,
      );

  factory EngineeringBranchesModel.fromJson(Map<String, dynamic> json){
    return EngineeringBranchesModel(
      json ['postId'] ?? 0,
      json ['postType'] ?? '',
      json ['catid'] ?? '',
      json ['postTitle'] ?? '',
      json ['postContent'] ?? '',
      json ['postStatus'] ?? '',
      json ['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'postId' : postId,
      'postType' : postType,
      'catid' : catid,
      'postTitle' : postTitle,
      'postContent' : postContent,
      'postStatus' : postStatus,
      'addedOn' : addedOn,
    };
  }
}

class EngineeringGlossaryModel{

  String? postId;
  String? postType;
  String? catid;
  String? postTitle;
  String? postContent;
  String? postStatus;
  String? addedOn;

  EngineeringGlossaryModel(
      this.postId,
      this.postType,
      this.catid,
      this.postTitle,
      this.postContent,
      this.postStatus,
      this.addedOn,
      );

  factory EngineeringGlossaryModel.fromJson(Map<String, dynamic> json){
    return EngineeringGlossaryModel(
      json ['postId'] ?? 0,
      json ['postType'] ?? '',
      json ['catid'] ?? '',
      json ['postTitle'] ?? '',
      json ['postContent'] ?? '',
      json ['postStatus'] ?? '',
      json ['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'postId' : postId,
      'postType' : postType,
      'catid' : catid,
      'postTitle' : postTitle,
      'postContent' : postContent,
      'postStatus' : postStatus,
      'addedOn' : addedOn,
    };
  }
}

class EngineeringCodesAndStdModel{

  String? postId;
  String? codeName;
  String? stId;
  String? catid;
  String? standardTitle;
  String? codeDescription;
  String? postStatus;
  String? addedOn;

  EngineeringCodesAndStdModel(
      this.postId,
      this.codeName,
      this.stId,
      this.catid,
      this.standardTitle,
      this.codeDescription,
      this.postStatus,
      this.addedOn,
      );

  factory EngineeringCodesAndStdModel.fromJson(Map<String, dynamic> json){
    return EngineeringCodesAndStdModel(
      json ['postId'] ?? 0,
      json ['codeName'] ?? '',
      json ['stId'] ?? '',
      json ['catid'] ?? '',
      json ['standardTitle'] ?? '',
      json ['codeDescription'] ?? '',
      json ['postStatus'] ?? '',
      json ['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'postId' : postId,
      'codeName' : codeName,
      'stId' : stId,
      'catid' : catid,
      'standardTitle' : standardTitle,
      'codeDescription' : codeDescription,
      'postStatus' : postStatus,
      'addedOn' : addedOn,
    };
  }
}

