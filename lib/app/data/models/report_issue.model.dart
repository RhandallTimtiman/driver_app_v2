class ReportIssue {
  String reportIssueTypeId = '';
  String description = '';

  ReportIssue({this.reportIssueTypeId = '', this.description = ''});

  factory ReportIssue.fromJson(Map<String, dynamic> json) {
    return ReportIssue(
      reportIssueTypeId: json['reportIssueTypeId'] as String,
      description: json['description'] as String,
    );
  }
}
