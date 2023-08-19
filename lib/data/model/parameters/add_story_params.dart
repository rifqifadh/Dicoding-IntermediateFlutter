
class AddStoryRequestModel {
  final String description;
  final String fileName;
  final List<int> bytes;
  final double? lat;
  final double? lon;

  AddStoryRequestModel({
    required this.description,
    required this.fileName,
    required this.bytes,
    this.lat,
    this.lon,
  });

  Map<String, String> toJson() {
    if (lat == null && lon == null) {
      return {
        "description": description,
      };
    }

    return {
      "description": description,
      "lat": lat?.toString() ?? "",
      "lon": lon?.toString() ?? "",
    };
  }
}
