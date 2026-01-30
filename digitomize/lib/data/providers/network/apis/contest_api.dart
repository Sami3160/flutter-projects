import 'package:digitomize/data/providers/network/api_endpoints.dart';
import 'package:digitomize/data/providers/network/api_provider.dart';
import 'package:digitomize/data/providers/network/api_request_representable.dart';

class ContestAPI implements APIRequestRepresentable {
  ContestAPI._();
  ContestAPI.fetchAllContests() : this._();

  @override
  String get endpoint => ApiEndpoints.contestsurl;

  String get path => "/allcontest";

  @override
  HTTPMethod get method {
    return HTTPMethod.get;
  }

  Map<String, String> get headers => {"Content-Type": "Application/json"};

  @override
  Map<String, String>? get query => null;

  @override
  get body => null;

  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}
