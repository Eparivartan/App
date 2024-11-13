class TechnologyFresherProfessionalModel{

  String? postId;
  String? postType;
  String? postTitle;
  String? availableFrom;
  String? downloadLink;
  String? postContent;
  String? postImage;
  String? postStatus;
  String? addedOn;

  TechnologyFresherProfessionalModel(
      this.postId,
      this.postType,
      this.postTitle,
      this.availableFrom,
      this.downloadLink,
      this.postContent,
      this.postImage,
      this.postStatus,
      this.addedOn
      );

  factory TechnologyFresherProfessionalModel.fromJson(Map<String, dynamic> json){
    return TechnologyFresherProfessionalModel(
      json ['postId'] ?? 0,
      json ['postType'] ?? '',
      json ['postTitle'] ?? '',
      json ['availableFrom'] ?? '',
      json ['downloadLink'] ?? '',
      json ['postContent'] ?? '',
      json ['postImage'] ?? '',
      json ['postStatus'] ?? 0,
      json ['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'postId' : postId,
      'postType' : postType,
      'postTitle' : postTitle,
      'availableFrom' : availableFrom,
      'downloadLink' : downloadLink,
      'postContent' : postContent,
      'postStatus' : postStatus,
      'addedOn' : addedOn,
    };
  }
}


