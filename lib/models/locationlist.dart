class Locationlist {
  int? id;
  int? locationId;
  String? areaTitle;
  int? statusAdd;
  String? addDate;

  Locationlist(
      {this.id, this.locationId, this.areaTitle, this.statusAdd, this.addDate});

  Locationlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationId = json['location_id'];
    areaTitle = json['area_title'];
    statusAdd = json['status_add'];
    addDate = json['add_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location_id'] = this.locationId;
    data['area_title'] = this.areaTitle;
    data['status_add'] = this.statusAdd;
    data['add_date'] = this.addDate;
    return data;
  }
}
