class Driver {
  final int? driverId;
  final String? driverGuid;
  final String? truckingCompanyId;
  final String? driverImage;
  final String? userName;
  final String? firstName;
  final String? lastName;
  final int? age;
  final int? status;
  final String? licenseNumber;
  final String? licenseTypeId;
  final String? licenseName;
  final String? mobileNumberPrefix;
  final String? mobileNumber;
  final String? emailAddress;

  Driver({
    this.driverId,
    this.driverGuid,
    this.truckingCompanyId,
    this.driverImage,
    this.userName,
    this.firstName,
    this.lastName,
    this.age = 0,
    this.status,
    this.licenseNumber,
    this.licenseTypeId,
    this.licenseName,
    this.mobileNumberPrefix,
    this.mobileNumber,
    this.emailAddress,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      driverId: json['driverId'],
      driverGuid: json['driverGuid'],
      truckingCompanyId: json['truckingCompanyId'],
      driverImage: json['driverImage'],
      userName: json['userName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      age: json['age'],
      status: json['status'],
      licenseNumber: json['licenseNumber'],
      licenseTypeId: json['licenseTypeId'],
      licenseName: json['licenseName'],
      mobileNumberPrefix: json['mobileNumberPrefix'],
      mobileNumber: json['mobileNumber'],
      emailAddress: json['emailAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['driverId'] = driverId;
    data['driverGuid'] = driverGuid;
    data['truckingCompanyId'] = truckingCompanyId;
    data['driverImage'] = driverImage;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['age'] = age;
    data['status'] = status;
    data['licenseNumber'] = licenseNumber;
    data['licenseTypeId'] = licenseTypeId;
    data['licenseName'] = licenseName;
    data['mobileNumberPrefix'] = mobileNumberPrefix;
    data['mobileNumber'] = mobileNumber;
    data['emailAddress'] = emailAddress;
    return data;
  }
}
