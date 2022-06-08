class DocumentModel {
  int documentCategoryId;
  String documentTypeId;
  String fileName;
  String filePath;
  bool isOrigin;
  String uploadedDate;

  DocumentModel({
    this.filePath = '',
    required this.documentCategoryId,
    required this.documentTypeId,
    required this.fileName,
    required this.isOrigin,
    this.uploadedDate = '',
  });

  Map toJson() => {
        'documentCategoryId': documentCategoryId,
        'documentTypeId': documentTypeId,
        'fileName': fileName,
        'isOrigin': isOrigin,
      };

  factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
        documentCategoryId: int.parse(json['documentCategoryId']),
        documentTypeId: json['documentTypeId'],
        fileName: json['fileName'],
        filePath: json['link'],
        uploadedDate: json['uploadedDate'],
        isOrigin: json['isOrigin'],
      );
}
