class ContainerList {
  int jobOrderId;
  int truckingContainersId;
  String id;
  String containerNumber;
  dynamic cargoWeight;
  String totalVolume;
  String specialCondition;
  String instructionsOthers;

  ContainerList({
    this.jobOrderId = 0,
    this.truckingContainersId = 0,
    this.id = '',
    this.containerNumber = '',
    this.cargoWeight,
    this.totalVolume = '',
    this.specialCondition = '',
    this.instructionsOthers = '',
  });

  factory ContainerList.fromJson(Map<String, dynamic> json) => ContainerList(
        jobOrderId: json["jobOrderId"],
        truckingContainersId: json["truckingContainersId"],
        id: json["id"],
        containerNumber: json["containerNumber"],
        cargoWeight: json["cargoWeight"],
        totalVolume: json["totalVolume"],
        specialCondition: json["specialCondition"],
        instructionsOthers: json["instructionsOthers"],
      );

  Map<String, dynamic> toJson() => {
        "jobOrderId": jobOrderId,
        "truckingContainersId": truckingContainersId,
        "id": id,
        "containerNumber": containerNumber,
        "cargoWeight": cargoWeight,
        "totalVolume": totalVolume,
        "specialCondition": specialCondition,
        "instructionsOthers": instructionsOthers,
      };
}
