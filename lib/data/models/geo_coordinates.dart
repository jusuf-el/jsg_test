class GeoCoordinates {
  String lat = '';
  String lng = '';

  GeoCoordinates({this.lat = '', this.lng = ''});

  GeoCoordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] ?? '';
    lng = json['lng'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
