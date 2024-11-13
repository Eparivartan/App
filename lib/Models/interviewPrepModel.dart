class InterviewPrepModel {
  String? id;
  String? catname;
  String? catimage;
  String? status;
  String? addedOn;

  InterviewPrepModel(
    this.id,
    this.catname,
    this.catimage,
    this.status,
    this.addedOn,
  );

  factory InterviewPrepModel.fromJson(Map<String, dynamic> json) {
    return InterviewPrepModel(
      json['id'] ?? '',
      json['catname'] ?? '',
      json['catimage'] ?? '',
      json['status'] ?? '',
      json['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'catname': catname,
      'catimage': catimage,
      'status': status,
      'addedOn': addedOn,
    };
  }
}

class InterviewTypeModel {
  String? postId;
  String? postType;
  String? postTitle;
  String? postContent;
  String? postStatus;
  String? addedOn;

  InterviewTypeModel(
    this.postId,
    this.postType,
    this.postTitle,
    this.postContent,
    this.postStatus,
    this.addedOn,
  );

  factory InterviewTypeModel.fromJson(Map<String, dynamic> json) {
    return InterviewTypeModel(
      json['postId'] ?? '',
      json['postType'] ?? '',
      json['postTitle'] ?? '',
      json['postContent'] ?? '',
      json['postStatus'] ?? '',
      json['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'postType': postType,
      'postTitle': postTitle,
      'postContent': postContent,
      'postStatus': postStatus,
      'addedOn': addedOn,
    };
  }
}

class McqTestListModel {
  String? mcqId;
  String? mcqTitle;
  String? branchId;
  String? skillLevel;
  String? mcqStatus;
  String? addedOn;

  McqTestListModel(
    this.mcqId,
    this.mcqTitle,
    this.branchId,
    this.skillLevel,
    this.mcqStatus,
    this.addedOn,
  );

  factory McqTestListModel.fromJson(Map<String, dynamic> json) {
    return McqTestListModel(
      json['mcqId'] ?? '',
      json['mcqTitle'] ?? '',
      json['branchId'] ?? '',
      json['skillLevel'] ?? '',
      json['mcqStatus'] ?? '',
      json['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mcqId': mcqId,
      'mcqTitle': mcqTitle,
      'branchId': branchId,
      'skillLevel': skillLevel,
      'mcqStatus': mcqStatus,
      'addedOn': addedOn,
    };
  }
}

class McqQuestionsModel {
  String? questId;
  String? mcqId;
  String? question;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;
  String? correctOption;
  String? addedOn;

  McqQuestionsModel(
    this.questId,
    this.mcqId,
    this.question,
    this.optionA,
    this.optionB,
    this.optionC,
    this.optionD,
    this.correctOption,
    this.addedOn,
  );

  factory McqQuestionsModel.fromJson(Map<String, dynamic> json) {
    return McqQuestionsModel(
      json['questId'] ?? '',
      json['mcqId'] ?? '',
      json['question'] ?? '',
      json['optionA'] ?? '',
      json['optionB'] ?? '',
      json['optionC'] ?? '',
      json['optionD'] ?? '',
      json['correctOption'] ?? '',
      json['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questId': questId,
      'mcqId': mcqId,
      'question': question,
      'optionA': optionA,
      'optionB': optionB,
      'optionC': optionC,
      'optionD': optionD,
      'correctOption': correctOption,
      'addedOn': addedOn,
    };
  }
}
