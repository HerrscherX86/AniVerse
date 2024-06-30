class StreamingService {
  final String name;
  final String url;

  StreamingService({required this.name, required this.url});

  factory StreamingService.fromJson(Map<String, dynamic> json) {
    return StreamingService(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
