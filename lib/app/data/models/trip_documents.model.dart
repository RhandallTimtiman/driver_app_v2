class TripDocument {
  TripDocument({
    required this.id,
    required this.fileName,
    this.link = '',
    required this.documentCategoryId,
    required this.documentCategoryName,
    required this.dateSubmission,
    required this.documentTypeId,
  });

  String id;
  String fileName;
  String? link;
  String documentCategoryId;
  String documentCategoryName;
  DocumentTypeId? documentTypeId;
  DateTime? dateSubmission;

  factory TripDocument.fromJson(Map<String, dynamic> json) => TripDocument(
        id: json["id"],
        fileName: json["fileName"],
        link: json["link"],
        documentCategoryId: json["documentCategoryId"],
        documentCategoryName: json["documentCategoryName"],
        documentTypeId: documentTypeIdValues.map[json["documentTypeId"]],
        dateSubmission: DateTime.parse(json["dateSubmission"] + 'Z'),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fileName": fileName,
        "link": link,
        "documentCategoryId": documentCategoryId,
        "documentCategoryName": documentCategoryName,
        "documentTypeId": documentTypeIdValues.reverse[documentTypeId],
        "dateSubmission": dateSubmission?.toIso8601String(),
      };
}

enum DocumentTypeId { P, A, S }

final documentTypeIdValues = EnumValues(
    {"A": DocumentTypeId.A, "P": DocumentTypeId.P, "S": DocumentTypeId.S});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap;
    return reverseMap;
  }
}
