class Vehicle {
  String id;
  int vehicleId;
  String brand;
  String model;
  String plateNumber;
  String imageUrl;
  String type;
  int year;
  Vehicle(
      {this.id = '',
      this.vehicleId = 0,
      this.brand = '',
      this.model = '',
      this.imageUrl = '',
      this.plateNumber = '',
      this.type = '',
      this.year = 0});

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
