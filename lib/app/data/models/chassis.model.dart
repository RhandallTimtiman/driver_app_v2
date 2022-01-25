class Chassis {
  final int? chassisId;
  final String? id;
  final String image;
  final String brand;
  final String model;
  final int? year;
  final String plateNumber;

  Chassis({
    this.chassisId,
    this.id,
    this.image = '',
    this.brand = '',
    this.model = '',
    this.year,
    this.plateNumber = '',
  });

  factory Chassis.fromJson(Map<String, dynamic> json) {
    return Chassis(
      chassisId: json['chassisId'],
      id: json['id'],
      image: json['image'],
      brand: json['brand'],
      model: json['model'],
      year: json['year'],
      plateNumber: json['plateNumber'],
    );
  }
}
