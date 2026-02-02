import 'package:digitomize/data/providers/network/api_endpoints.dart';
import 'package:digitomize/data/providers/network/api_provider.dart';
import 'package:digitomize/data/providers/network/api_request_representable.dart';

class HackthonApi extends APIRequestRepresentable{
  HackthonApi._();
  HackthonApi.fetchAllHackthons():this._();
  final String hackthonUrl=ApiEndpoints.alternateUrl;
  @override
  get body => null;

  @override
  String get endpoint => hackthonUrl;

  @override
  Map<String, String>? get headers => {"Content-Type": "Application/json"};

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  String get path => "/hackathons";

  @override
  Map<String, String>? get query => null;

  @override
  Future<dynamic> request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;

}