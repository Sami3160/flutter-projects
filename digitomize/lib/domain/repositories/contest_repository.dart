import 'package:digitomize/domain/entities/contest.dart';

abstract class ContestRepository {
  Future<List<Contest>> getContests({required int page, required int pageSize}); 
}