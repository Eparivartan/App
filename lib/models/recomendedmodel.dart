class Recomended {
  String? title;
  int? propertyId;
  String? image;
  String? cyti;
  String? areaTitle;

  Recomended(
      {this.title, this.propertyId, this.image, this.cyti, this.areaTitle});

  Recomended.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    propertyId = json['property_id'];
    image = json['image'];
    cyti = json['cyti'];
    areaTitle = json['area_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['property_id'] = this.propertyId;
    data['image'] = this.image;
    data['cyti'] = this.cyti;
    data['area_title'] = this.areaTitle;
    return data;
  }
}
