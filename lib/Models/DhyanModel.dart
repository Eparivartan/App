class ReviewModel {
  String? reviewId;
  String? reviewerName;
  String? review;
  String? reviewImage;
  String? courseName;
  String? className;
  String? reviewStatus;
  String? addedOn;

  ReviewModel(
    this.reviewId,
    this.reviewerName,
    this.review,
    this.reviewImage,
    this.courseName,
    this.className,
    this.reviewStatus,
    this.addedOn,
  );

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      json['reviewId'] ?? '',
      json['reviewerName'] ?? '',
      json['review'] ?? '',
      json['reviewImage'] ?? '',
      json['courseName'] ?? '',
      json['className'] ?? '',
      json['reviewStatus'] ?? '',
      json['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviewId': reviewId,
      'reviewerName': reviewerName,
      'review': review,
      'reviewImage': reviewImage,
      'courseName': courseName,
      'className': className,
      'reviewStatus': reviewStatus,
      'addedOn': addedOn,
    };
  }
}

class GalleryModel {
  String? imageId;
  String? imageName;
  String? galleryId;
  String? galleryName;
  String? addedOn;

  GalleryModel(
    this.imageId,
    this.imageName,
    this.galleryId,
    this.galleryName,
    this.addedOn,
  );

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      json['imageId'] ?? '',
      json['imageName'] ?? '',
      json['galleryId'] ?? '',
      json['galleryName'] ?? '',
      json['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageId': imageId,
      'imageName': imageName,
      'galleryId': galleryId,
      'galleryName': galleryName,
      'addedOn': addedOn,
    };
  }
}

class CoursesModel {
  String? courseId;
  String? courseName;
  String? courseDescription;
  String? trainingOptions;
  String? courseDuration;
  String? courseCertificate;
  String? courseStatus;
  String? addedOn;

  CoursesModel(
    this.courseId,
    this.courseName,
    this.courseDescription,
    this.trainingOptions,
    this.courseDuration,
    this.courseCertificate,
    this.courseStatus,
    this.addedOn,
  );

  factory CoursesModel.fromJson(Map<String, dynamic> json) {
    return CoursesModel(
      json['courseId'] ?? '',
      json['courseName'] ?? '',
      json['courseDescription'] ?? '',
      json['trainingOptions'] ?? '',
      json['courseDuration'] ?? '',
      json['courseCertificate'] ?? '',
      json['courseStatus'] ?? '',
      json['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'courseName': courseName,
      'courseDescription': courseDescription,
      'trainingOptions': trainingOptions,
      'courseDuration': courseDuration,
      'courseCertificate': courseCertificate,
      'courseStatus': courseStatus,
      'addedOn': addedOn,
    };
  }
}
