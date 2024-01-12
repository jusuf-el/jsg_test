class Endpoints {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/';

  static const String posts = 'posts';
  static const String users = 'users';
  static const String comments = 'comments';
  static const String photos = 'photos';

  static String setUrlParameters(List<Map<String, dynamic>> parameters) {
    String urlParameters = '';

    for (var element in parameters) {
      if (element['value'] != null) {
        if (urlParameters.isEmpty) {
          urlParameters =
              '$urlParameters?${element['key']}=${element['value']}';
        } else {
          urlParameters =
              '$urlParameters&${element['key']}=${element['value']}';
        }
      }
    }

    return urlParameters;
  }
}
