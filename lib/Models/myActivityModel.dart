class MyActivityModel{

  String? userId;
  String? favId;
  String? favPath;
  String? addedOn;

  MyActivityModel(
      this.userId,
      this.favId,
      this.favPath,
      this.addedOn,
      );

  factory MyActivityModel.fromJson(Map<String, dynamic> json){
    return MyActivityModel(
      json ['userId'] ?? '',
      json ['favId'] ?? '',
      json ['favPath'] ?? '',
      json ['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'userId' : userId,
      'favId' : favId,
      'favPath' : favPath,
      'addedOn' : addedOn,
    };
  }
}
