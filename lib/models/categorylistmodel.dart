class Categorylist {
  int? id;
  String? listTitle;
  String? pricetype;
  int? listOrder;
  int? statusAdd;
  String? addDate;

  Categorylist(
      {this.id,
      this.listTitle,
      this.pricetype,
      this.listOrder,
      this.statusAdd,
      this.addDate});

  Categorylist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    listTitle = json['list_title'];
    pricetype = json['pricetype'];
    listOrder = json['list_order'];
    statusAdd = json['status_add'];
    addDate = json['add_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['list_title'] = this.listTitle;
    data['pricetype'] = this.pricetype;
    data['list_order'] = this.listOrder;
    data['status_add'] = this.statusAdd;
    data['add_date'] = this.addDate;
    return data;
  }
}
