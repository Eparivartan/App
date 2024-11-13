class LearnAssistModel{

  String? id;
  String? catname;
  String? catimage;
  String? status;
  String? addedOn;

  LearnAssistModel(
      this.id,
      this.catname,
      this.catimage,
      this.status,
      this.addedOn,
      );

  factory LearnAssistModel.fromJson(Map<String, dynamic> json){
    return LearnAssistModel(
      json ['id'] ?? '',
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


class ExternalTrainingVideosModel{

  String? postId;
  String? videoName;
  String? videoEmbed;
  String? videoThumbnail;
  String? videoDuration;
  String? id;
  String? videoStatus;
  String? addedOn;

  ExternalTrainingVideosModel(
      this.postId,
      this.videoName,
      this.videoEmbed,
      this.videoThumbnail,
      this.videoDuration,
      this.id,
      this.videoStatus,
      this.addedOn,
      );

  factory ExternalTrainingVideosModel.fromJson(Map<String, dynamic> json){
    return ExternalTrainingVideosModel(
      json ['postId'] ?? '',
      json ['videoName'] ?? '',
      json ['videoEmbed'] ?? '',
      json ['videoThumbnail'] ?? '',
      json ['videoDuration'] ?? '',
      json ['id'] ?? '',
      json ['videoStatus'] ?? '',
      json ['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'postId' : postId,
      'videoName' : videoName,
      'videoEmbed' : videoEmbed,
      'videoThumbnail' : videoThumbnail,
      'videoDuration' : videoDuration,
      'id' : id,
      'videoStatus' : videoStatus,
      'addedOn' : addedOn,
    };
  }
}


class ListquestionpapersModel{

  String? postId;
  String? questionPaper;
  String? examName;
  String? examDescription;
  String? qpStatus;
  String? addedOn;

  ListquestionpapersModel(
      this.postId,
      this.questionPaper,
      this.examName,
      this.examDescription,
      this.qpStatus,
      this.addedOn,
      );

  factory ListquestionpapersModel.fromJson(Map<String, dynamic> json){
    return ListquestionpapersModel(
      json ['postId'] ?? '',
      json ['questionPaper'] ?? '',
      json ['examName'] ?? '',
      json ['examDescription'] ?? '',
      json ['qpStatus'] ?? '',
      json ['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'postId' : postId,
      'questionPaper' : questionPaper,
      'examName' : examName,
      'examDescription' : examDescription,
      'qpStatus' : qpStatus,
      'addedOn' : addedOn,
    };
  }
}


class RefBooksModel{

  String? bookId;
  String? bookName;
  String? bookAuthor;
  String? bookSynopsis;
  String? buyingLink;
  String? bookStatus;
  String? addedOn;

  RefBooksModel(
      this.bookId,
      this.bookName,
      this.bookAuthor,
      this.bookSynopsis,
      this.buyingLink,
      this.bookStatus,
      this.addedOn,
      );

  factory RefBooksModel.fromJson(Map<String, dynamic> json){
    return RefBooksModel(
      json ['bookId'] ?? '',
      json ['bookName'] ?? '',
      json ['bookAuthor'] ?? '',
      json ['bookSynopsis'] ?? '',
      json ['buyingLink'] ?? '',
      json ['bookStatus'] ?? '',
      json ['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'bookId' : bookId,
      'bookName' : bookName,
      'bookAuthor' : bookAuthor,
      'bookSynopsis' : bookSynopsis,
      'buyingLink' : buyingLink,
      'bookStatus' : bookStatus,
      'addedOn' : addedOn,
    };
  }
}