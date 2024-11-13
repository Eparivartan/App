class AskExpertModel{

  String? askId;
  String? userId;
  String? subject;
  String? details;
  String? requestedOn;
  String? replyDetails;
  String? replyBy;
  String? reppliedOn;

  @override
  String searchableList() {
    return '$subject  $details';
  }

  AskExpertModel(
      this.askId,
      this.userId,
      this.subject,
      this.details,
      this.requestedOn,
      this.replyDetails,
      this.replyBy,
      this.reppliedOn,
      );

  factory AskExpertModel.fromJson(Map<String, dynamic> json){
    return AskExpertModel(
      json ['askId'] ?? 0,
      json ['userId'] ?? '',
      json ['subject'] ?? '',
      json ['details'] ?? '',
      json ['requestedOn'] ?? '',
      json ['replyDetails'] ?? '',
      json ['replyBy'] ?? '',
      json ['reppliedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'askId' : askId,
      'userId' : userId,
      'subject' : subject,
      'details' : details,
      'requestedOn' : requestedOn,
      'replyDetails' : replyDetails,
      'replyBy' : replyBy,
      'reppliedOn' : reppliedOn,
    };
  }
}