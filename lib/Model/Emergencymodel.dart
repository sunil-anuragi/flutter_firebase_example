class Emergencymodel {
  String? id;
  String? roomno;
  String? emgdes;
  String? nurseid;
  int? attendstatus;

  Emergencymodel({
    required this.id,
    required this.roomno,
    required this.nurseid,
    required this.emgdes,
    required this.attendstatus,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomno': roomno,
      'emgdes': emgdes,
      'nurseid': nurseid,
      'attendstatus': attendstatus
    };
  }

  Emergencymodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomno = json['roomno'];
    emgdes = json['emgdes'];
    nurseid = json['nurseid'];
    attendstatus = json['attendstatus'];
  }
}
