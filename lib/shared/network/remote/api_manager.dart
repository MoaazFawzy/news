import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/models/SourcesResponse.dart';
import 'package:news/shared/components/constants.dart';

import '../../../models/NewsResponse.dart';

class ApiManager {
  static Future<SourcesResponse> getSources(String cat) async {
    Uri URL = Uri.https(
        BASE, "/v2/top-headlines/sources", {"apiKey": APIKEY, "category": cat});
    http.Response response = await http.get(URL);
    var jsonResponse = jsonDecode(response.body);

    SourcesResponse sourcesResponse = SourcesResponse.fromJson(jsonResponse);
    return sourcesResponse;
  }

  static Future<NewsResponse> getNewsData(String? sourceId, {String? q}) async {
    Uri URL = Uri.https(BASE, "/v2/everything",
        {"apiKey": APIKEY, "sources": sourceId, "q": q});
    http.Response response = await http.get(URL);
    var json = jsonDecode(response.body);

    NewsResponse newsResponse = NewsResponse.fromJson(json);
    return newsResponse;
  }
}
