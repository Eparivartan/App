// ignore_for_file: unnecessary_this

class ProprtyType {
  List<Allproperties>? allproperties;

  ProprtyType({this.allproperties});

  ProprtyType.fromJson(Map<String, dynamic> json) {
    if (json['allproperties'] != null) {
      allproperties = <Allproperties>[];
      json['allproperties'].forEach((v) {
        allproperties!.add(Allproperties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.allproperties != null) {
      data['allproperties'] =
          this.allproperties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Allproperties {
  String? id;
  String? type;
  String? status;
  String? addDate;

  Allproperties({this.id, this.type, this.status, this.addDate});

  Allproperties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    addDate = json['add_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['type'] = this.type;
    data['status'] = this.status;
    data['add_date'] = this.addDate;
    return data;
  }
}
