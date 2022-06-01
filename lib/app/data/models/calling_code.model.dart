class CallingCode {
  final int countryId;
  final String callingCode;
  final String name;

  CallingCode({
    required this.callingCode,
    required this.name,
    required this.countryId,
  });

  Map toJson() => {
        'countryId': countryId,
        'name': name,
        'callingCode': callingCode,
      };

  factory CallingCode.fromJson(Map<String, dynamic> json) {
    return CallingCode(
      countryId: json['countryId'] as int,
      name: json['name'] as String,
      callingCode: json['callingCode'] as String,
    );
  }
}
