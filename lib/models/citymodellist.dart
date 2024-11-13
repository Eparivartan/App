
// City Model
class City {
  final int id;
  final String listTitle;
  final int statusAdd;
  final String addDate;

  City({
    required this.id,
    required this.listTitle,
    required this.statusAdd,
    required this.addDate,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      listTitle: json['list_title'],
      statusAdd: json['status_add'],
      addDate: json['add_date'],
    );
  }
}