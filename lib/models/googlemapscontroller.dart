
// Model class Filterlist
class Filterlist {
  int? id;
  String? areaType;
  String? title;
  String? image;
  int? proPrice;
  String? snum;
  String? cityName;
  String? areaTitle;

  Filterlist({
    this.id,
    this.areaType,
    this.title,
    this.image,
    this.proPrice,
    this.snum,
    this.cityName,
    this.areaTitle,
  });

  Filterlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    areaType = json['areaType'];
    title = json['title'];
    image = json['image'];
    proPrice = json['proPrice'];
    snum = json['snum'];
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
    data['snum'] = this.snum;
    data['city_name'] = this.cityName;
    data['area_title'] = this.areaTitle;
    return data;
  }
}