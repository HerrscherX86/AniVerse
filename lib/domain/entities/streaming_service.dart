class StreamingService {
  // The name of the streaming service
  final String name;

  // The URL of the streaming service
  final String url;

  // Constructor to initialize the StreamingService with required name and URL
  StreamingService({required this.name, required this.url});

  // Factory constructor to create a StreamingService instance from JSON
  factory StreamingService.fromJson(Map<String, dynamic> json) {
    return StreamingService(
      // Extract the 'name' field from the JSON, providing a default empty string if not found
      name: json['name'] ?? '',
      // Extract the 'url' field from the JSON, providing a default empty string if not found
      url: json['url'] ?? '',
    );
  }
}
