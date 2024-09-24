class CapturedImage {
  final int id;
  final String imagePath;
  final String dateCaptured;

  CapturedImage({
    required this.id,
    required this.imagePath,
    required this.dateCaptured,
  });

  factory CapturedImage.fromJson(Map<String, dynamic> json) {
    return CapturedImage(
      id: json['id'],
      imagePath: json['imagePath'],
      dateCaptured: json['dateCaptured'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
      'dateCaptured': dateCaptured,
    };
  }
}
