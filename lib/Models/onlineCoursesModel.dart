class OnlineCoursesModel {
  String? courseId;
  String? courseName;
  String? courseDescription;
  String? courseBy;
  String? courseDuration;
  String? courseTraining;
  String? courseValidity;
  String? courseCertificate;
  String? smeSupport;
  String? courseContent;
  String? courseStatus;
  String? addedOn;

  OnlineCoursesModel(
    this.courseId,
    this.courseName,
    this.courseDescription,
    this.courseBy,
    this.courseDuration,
    this.courseTraining,
    this.courseValidity,
    this.courseCertificate,
    this.smeSupport,
    this.courseContent,
    this.courseStatus,
    this.addedOn,
  );

  factory OnlineCoursesModel.fromJson(Map<String, dynamic> json) {
    return OnlineCoursesModel(
      json['courseId'] ?? '',
      json['courseName'] ?? '',
      json['courseDescription'] ?? '',
      json['courseBy'] ?? '',
      json['courseDuration'] ?? '',
      json['courseTraining'] ?? '',
      json['courseValidity'] ?? '',
      json['courseCertificate'] ?? '',
      json['smeSupport'] ?? '',
      json['courseContent'] ?? '',
      json['courseStatus'] ?? '',
      json['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'courseName': courseName,
      'courseDescription': courseDescription,
      'courseBy': courseBy,
      'courseDuration': courseDuration,
      'courseTraining': courseTraining,
      'courseValidity': courseValidity,
      'courseCertificate': courseCertificate,
      'smeSupport': smeSupport,
      'courseContent': courseContent,
      'courseStatus': courseStatus,
      'addedOn': addedOn,
    };
  }
}

class OnlineCoursesVideoModel {
  String? postId;
  String? videoName;
  String? videoDescription;
  String? videoEmbed;
  String? videoThumbnail;
  String? videoDuration;
  String? courseId;
  String? videoStatus;
  String? addedOn;

  OnlineCoursesVideoModel(
    this.postId,
    this.videoName,
    this.videoDescription,
    this.videoEmbed,
    this.videoThumbnail,
    this.videoDuration,
    this.courseId,
    this.videoStatus,
    this.addedOn,
  );

  factory OnlineCoursesVideoModel.fromJson(Map<String, dynamic> json) {
    return OnlineCoursesVideoModel(
      json['postId'] ?? '',
      json['videoName'] ?? '',
      json['videoDescription'] ?? '',
      json['videoEmbed'] ?? '',
      json['videoThumbnail'] ?? '',
      json['videoDuration'] ?? '',
      json['courseId'] ?? '',
      json['videoStatus'] ?? '',
      json['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'videoName': videoName,
      'videoDescription': videoDescription,
      'videoEmbed': videoEmbed,
      'videoThumbnail': videoThumbnail,
      'videoDuration': videoDuration,
      'courseId': courseId,
      'videoStatus': videoStatus,
      'addedOn': addedOn,
    };
  }
}

class MyCourseModel {
  String id;
  String orderId;
  String userId;
  String courseId;
  String transactionId;
  double orderAmount;
  String orderStatus;
  String purchaseDate;

  MyCourseModel({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.courseId,
    required this.transactionId,
    required this.orderAmount,
    required this.orderStatus,
    required this.purchaseDate,
  });

  factory MyCourseModel.fromJson(Map<String, dynamic> json) {
    return MyCourseModel(
      id: json['id'],
      orderId: json['orderId'],
      userId: json['userId'],
      courseId: json['courseId'],
      transactionId: json['transactionId'],
      orderAmount: double.parse(json['orderAmount']),
      orderStatus: json['orderStatus'],
      purchaseDate: json['purchaseDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'userId': userId,
      'courseId': courseId,
      'transactionId': transactionId,
      'orderAmount': orderAmount.toString(),
      'orderStatus': orderStatus,
      'purchaseDate': purchaseDate,
    };
  }
}
