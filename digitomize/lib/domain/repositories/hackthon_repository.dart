import 'package:digitomize/domain/entities/hackthon.dart';

abstract class HackthonRepository {
  Future<List<Hackthon>> getHackthons({
    required int page,
    required int pageSize,
  });
}
