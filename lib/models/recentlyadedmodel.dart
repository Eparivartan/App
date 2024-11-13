class RecentlyAded {
  int? id;
  String? areaType;
  String? title;
  String? image;
  int? proPrice;
  String? cityName;
  String? areaTitle;

  RecentlyAded(
      {this.id,
      this.areaType,
      this.title,
      this.image,
      this.proPrice,
      this.cityName,
      this.areaTitle});

  RecentlyAded.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    areaType = json['areaType'];
    title = json['title'];
    image = json['image'];
    proPrice = json['proPrice'];
    cityName = json['city_name'];
    areaTitle = json['area_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['areaType'] = this.areaType;
    data['title'] = this.title;
    data['image'] = this.image;
    data['proPrice'] = this.proPrice;
    data['city_name'] = this.cityName;
    data['area_title'] = this.areaTitle;
    return data;
  }
}
