class ReasonRejection {
  String driverReasonofRejectionId = '';
  String description = '';

  ReasonRejection({this.driverReasonofRejectionId = '', this.description = ''});

  factory ReasonRejection.fromJson(Map<String, dynamic> json) {
    return ReasonRejection(
      driverReasonofRejectionId: json['driverReasonofRejectionId'] as String,
      description: json['description'] as String,
    );
  }
}
