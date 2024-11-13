class headerModel{

  String? headId;
  String? headerName;
  String? headerContent;
  String? addedOn;

  headerModel(
      this.headId,
      this.headerName,
      this.headerContent,
      this.addedOn,
      );

  factory headerModel.fromJson(Map<String, dynamic> json){
    return headerModel(
      json ['headId'] ?? 0,
      json ['headerName'] ?? '',
      json ['headerContent'] ?? '',
      json ['addedOn'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'headId' : headId,
      'headerName' : headerName,
      'headerContent' : headerContent,
      'addedOn' : addedOn,
    };
  }
}
