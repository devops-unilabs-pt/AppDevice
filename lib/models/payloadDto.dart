

class PayloadDTO{
  String? resourceType;
  String? gender;
  String? examCode;
  String? name;
  String? birthDate;
  String? id;
  String? result;

  PayloadDTO({
   this.examCode,
    this.name,
    this.result,
    this.birthDate,
    this.gender,
    this.id,
    this.resourceType
});

  Map<String, dynamic> toJson() => {
    "resourceType": resourceType,
    "name": name,
    "result": result,
    "gender": gender,
    "birthDate": birthDate,
    "result": result,
    "id": id,
    "code": examCode,
  };
}