import 'package:digitomize/data/providers/network/apis/hackthon_api.dart';
import 'package:digitomize/domain/entities/hackthon.dart';
import 'package:digitomize/domain/repositories/hackthon_repository.dart';

class HackthonRepositoryImpl extends HackthonRepository {
  @override
  Future<List<Hackthon>> getHackthons({
    required int page,
    required int pageSize,
  }) async {
    final response = await HackthonApi.fetchAllHackthons().request();

    // Handle if response is a Map with a 'hackathons' or 'results' key, or a direct List
    List<dynamic> list = [];
    if (response is List) {
      list = response;
    } else if (response is Map && response['results'] != null) {
      list = response['results'];
    } else if (response is Map && response['hackathons'] != null) {
      list = response['hackathons'];
    }

    return list.map((item) => Hackthon.fromJson(item)).toList();
  }
}
