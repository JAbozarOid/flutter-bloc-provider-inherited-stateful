import 'dart:convert';

import 'package:bloc_pattern/models/model.dart';
import 'package:http/http.dart' show Client,Response;

class GithubApi {
  final Client _client = Client();
  static const String _url = 'https://api.github.com/repos/tensor-programming/utopian-rocks-mobile/releases';

  Future<GithubModel> getReleases() async {
    String resBody = await _client.get(Uri.parse(_url)).then((Response res) => res.body);
    List ghJson = json.decode(resBody);
    var x = ghJson.map((gh) => GithubModel.fromJson(gh)).toList();
    return x.first;
    // we want the first item in the list because in the fisrt item there is the lastest version on utopian rock apk
  }
}