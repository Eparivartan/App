class AnnouncementModel{

  String? postId;
  String? announceTitle;
  String? anDescription;
  String? anStatus;
  String? addedOn;

  AnnouncementModel(
      this.postId,
      this.announceTitle,
      this.anDescription,
      this.anStatus,
      this.addedOn,
      );

  factory AnnouncementModel.fromJson(Map<String, dynamic> json){
    return AnnouncementModel(
      json ['postId'] ?? 0,
      json ['announceTitle'] ?? '',
      json ['anDescription'] ?? '',
      json ['anStatus'] ?? '',
      json ['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'postId' : postId,
      'announceTitle' : announceTitle,
      'anDescription' : anDescription,
      'anStatus' : anStatus,
      'addedOn' : addedOn,
    };
  }
}
