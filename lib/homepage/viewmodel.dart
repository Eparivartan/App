class Dummy {
  int? id;
  int? cityId;
  int? areaId;
  int? propertiesTypeId;
  String? title;
  String? areaType;
  int? proPrice;
  String? image;
  String? brocher;
  Null? distances;
  String? distanceCbd;
  String? distanceAirport;
  String? builtUpArea;
  String? floorPlateSize;
  String? building;
  String? efficiency;
  String? proposedSpace;
  String? spaceOffered;
  String? commercialDetails;
  String? status;
  int? orderShow;
  String? addOn;
  String? cagent;
  String? snum;
  String? semail;
  String? locationset;
  String? proGrade;
  Null? areaoffered;
  Null? floorsoffered;
  Null? offeredstatus;
  Null? power;
  Null? powerbackup;
  Null? carparking;
  Null? timeline;
  Null? leaseltenure;
  Null? lockPeriod;
  Null? noticeperiod;
  Null? quotedrentalratesINR;
  Null? quotedrentalratesSF;
  Null? cAMINR;
  Null? cAMSF;
  Null? carparkchargesINR;
  Null? carparkchargesSlot;
  Null? rentescalation;
  Null? securitydeposit;
  Null? taxes;
  Null? othercharges;
  String? ptype;
  String? areaTitle;

  Dummy(
      {this.id,
      this.cityId,
      this.areaId,
      this.propertiesTypeId,
      this.title,
      this.areaType,
      this.proPrice,
      this.image,
      this.brocher,
      this.distances,
      this.distanceCbd,
      this.distanceAirport,
      this.builtUpArea,
      this.floorPlateSize,
      this.building,
      this.efficiency,
      this.proposedSpace,
      this.spaceOffered,
      this.commercialDetails,
      this.status,
      this.orderShow,
      this.addOn,
      this.cagent,
      this.snum,
      this.semail,
      this.locationset,
      this.proGrade,
      this.areaoffered,
      this.floorsoffered,
      this.offeredstatus,
      this.power,
      this.powerbackup,
      this.carparking,
      this.timeline,
      this.leaseltenure,
      this.lockPeriod,
      this.noticeperiod,
      this.quotedrentalratesINR,
      this.quotedrentalratesSF,
      this.cAMINR,
      this.cAMSF,
      this.carparkchargesINR,
      this.carparkchargesSlot,
      this.rentescalation,
      this.securitydeposit,
      this.taxes,
      this.othercharges,
      this.ptype,
      this.areaTitle});

  Dummy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    propertiesTypeId = json['Properties_type_id'];
    title = json['title'];
    areaType = json['areaType'];
    proPrice = json['proPrice'];
    image = json['image'];
    brocher = json['brocher'];
    distances = json['Distances'];
    distanceCbd = json['distance_cbd'];
    distanceAirport = json['distance_airport'];
    builtUpArea = json['built_up_area'];
    floorPlateSize = json['floor_plate_size'];
    building = json['building'];
    efficiency = json['efficiency'];
    proposedSpace = json['ProposedSpace'];
    spaceOffered = json['SpaceOffered'];
    commercialDetails = json['CommercialDetails'];
    status = json['status'];
    orderShow = json['order_show'];
    addOn = json['addOn'];
    cagent = json['cagent'];
    snum = json['snum'];
    semail = json['semail'];
    locationset = json['locationset'];
    proGrade = json['proGrade'];
    areaoffered = json['areaoffered'];
    floorsoffered = json['floorsoffered'];
    offeredstatus = json['offeredstatus'];
    power = json['power'];
    powerbackup = json['powerbackup'];
    carparking = json['carparking'];
    timeline = json['timeline'];
    leaseltenure = json['leaseltenure'];
    lockPeriod = json['lockPeriod'];
    noticeperiod = json['noticeperiod'];
    quotedrentalratesINR = json['quotedrentalratesINR'];
    quotedrentalratesSF = json['quotedrentalratesSF'];
    cAMINR = json['CAMINR'];
    cAMSF = json['CAMSF'];
    carparkchargesINR = json['carparkchargesINR'];
    carparkchargesSlot = json['carparkchargesSlot'];
    rentescalation = json['rentescalation'];
    securitydeposit = json['securitydeposit'];
    taxes = json['taxes'];
    othercharges = json['othercharges'];
    ptype = json['ptype'];
    areaTitle = json['area_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city_id'] = this.cityId;
    data['area_id'] = this.areaId;
    data['Properties_type_id'] = this.propertiesTypeId;
    data['title'] = this.title;
    data['areaType'] = this.areaType;
    data['proPrice'] = this.proPrice;
    data['image'] = this.image;
    data['brocher'] = this.brocher;
    data['Distances'] = this.distances;
    data['distance_cbd'] = this.distanceCbd;
    data['distance_airport'] = this.distanceAirport;
    data['built_up_area'] = this.builtUpArea;
    data['floor_plate_size'] = this.floorPlateSize;
    data['building'] = this.building;
    data['efficiency'] = this.efficiency;
    data['ProposedSpace'] = this.proposedSpace;
    data['SpaceOffered'] = this.spaceOffered;
    data['CommercialDetails'] = this.commercialDetails;
    data['status'] = this.status;
    data['order_show'] = this.orderShow;
    data['addOn'] = this.addOn;
    data['cagent'] = this.cagent;
    data['snum'] = this.snum;
    data['semail'] = this.semail;
    data['locationset'] = this.locationset;
    data['proGrade'] = this.proGrade;
    data['areaoffered'] = this.areaoffered;
    data['floorsoffered'] = this.floorsoffered;
    data['offeredstatus'] = this.offeredstatus;
    data['power'] = this.power;
    data['powerbackup'] = this.powerbackup;
    data['carparking'] = this.carparking;
    data['timeline'] = this.timeline;
    data['leaseltenure'] = this.leaseltenure;
    data['lockPeriod'] = this.lockPeriod;
    data['noticeperiod'] = this.noticeperiod;
    data['quotedrentalratesINR'] = this.quotedrentalratesINR;
    data['quotedrentalratesSF'] = this.quotedrentalratesSF;
    data['CAMINR'] = this.cAMINR;
    data['CAMSF'] = this.cAMSF;
    data['carparkchargesINR'] = this.carparkchargesINR;
    data['carparkchargesSlot'] = this.carparkchargesSlot;
    data['rentescalation'] = this.rentescalation;
    data['securitydeposit'] = this.securitydeposit;
    data['taxes'] = this.taxes;
    data['othercharges'] = this.othercharges;
    data['ptype'] = this.ptype;
    data['area_title'] = this.areaTitle;
    return data;
  }
}
