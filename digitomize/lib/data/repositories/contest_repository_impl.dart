import 'package:digitomize/data/providers/network/apis/contest_api.dart';
import 'package:digitomize/domain/entities/contest.dart';
import 'package:digitomize/domain/repositories/contest_repository.dart';

class ContestRepositoryImpl extends ContestRepository {
  @override
  Future<List<Contest>> getContests({
    required int page,
    required int pageSize,
  }) async {
    final response = await ContestAPI.fetchAllContests().request();

    // Handle if response is a Map with a 'contests' or 'results' key, or a direct List
    List<dynamic> list = [];
    if (response is List) {
      list = response;
    } else if (response is Map && response['results'] != null) {
      list = response['results'];
    } else if (response is Map && response['contests'] != null) {
      list = response['contests'];
    }

    return list.map((item) => Contest.fromJson(item)).toList();
  }
}
