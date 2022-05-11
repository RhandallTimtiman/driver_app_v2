class DocumentCategory {
  final String documentCategoryId;
  final String description;

  DocumentCategory(
      {required this.documentCategoryId, required this.description});

  Map toJson() => {
        'documentCategoryId': documentCategoryId,
        'description': description,
      };

  factory DocumentCategory.fromJson(Map<String, dynamic> json) {
    return DocumentCategory(
      documentCategoryId: json['documentCategoryId'],
      description: json['description'] as String,
    );
  }
}
