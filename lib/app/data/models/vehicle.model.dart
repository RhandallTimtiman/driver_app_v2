class Vehicle {
  final String? id;
  final int? vehicleId;
  final String brand;
  final String model;
  final String plateNumber;
  final String imageUrl;
  final String? type;
  final int? year;

  Vehicle({
    this.id,
    this.vehicleId,
    this.brand = '',
    this.model = '',
    this.imageUrl = '',
    this.plateNumber = '',
    this.type = '',
    this.year = 0,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json['id'],
        vehicleId: json['vehicleId'],
        model: json['model'],
        brand: json['brand'],
        imageUrl: json['vehicleImage'],
        plateNumber: json['plateNumber'],
        year: json['year'],
        type: json['type'],
      );

  factory Vehicle.chassisFromJson(Map<String, dynamic> json) => Vehicle(
        id: json['id'],
        vehicleId: json['chassisId'],
        model: json['model'],
        brand: json['brand'],
        imageUrl: json['image'],
        plateNumber: json['plateNumber'],
        year: json['year'],
        type: json['type'],
      );
}
