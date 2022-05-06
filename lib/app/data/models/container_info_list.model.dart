class ContainerInfoList {
  ContainerInfoList({
    required this.containerNumber,
    this.cargoWeight,
    this.totalVolume,
    this.specialCondition,
    this.instructionsOthers,
  });

  String containerNumber;
  dynamic cargoWeight;
  dynamic totalVolume;
  dynamic specialCondition;
  dynamic instructionsOthers;

  factory ContainerInfoList.fromJson(Map<String, dynamic> json) =>
      ContainerInfoList(
        containerNumber: json["containerNumber"],
        cargoWeight: json["cargoWeight"],
        totalVolume: json["totalVolume"],
        specialCondition: json["specialCondition"],
        instructionsOthers: json["instructionsOthers"],
      );

  Map<String, dynamic> toJson() => {
        "containerNumber": containerNumber,
        "cargoWeight": cargoWeight,
        "totalVolume": totalVolume,
        "specialCondition": specialCondition,
        "instructionsOthers": instructionsOthers,
      };
}
