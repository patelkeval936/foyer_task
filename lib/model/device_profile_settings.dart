import 'dart:ui';

//json_serializable can also be used for to_json and from_json functionality
class DeviceProfileSettings {
  int? id;
  String latitude;
  String longitude;
  Color themeColor;
  double fontSize;

  DeviceProfileSettings({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.themeColor,
    required this.fontSize,
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'themeColor': themeColor.value.toString(),
      'fontSize': fontSize,
    };
  }

  factory DeviceProfileSettings.fromJson(Map<String, dynamic> data) {
    return DeviceProfileSettings(
      id: data['id'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      themeColor: Color(int.parse(data['themeColor'])),
      fontSize: data['fontSize'],
    );
  }
}
