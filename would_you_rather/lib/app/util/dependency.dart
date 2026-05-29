import 'package:get/get.dart';
import '../../data/repositories/game_repository_impl.dart';
import '../../domain/repositories/game_repository.dart';

class DependencyCreator {
  static void init() {
    Get.put<GameRepository>(GameRepositoryImpl(), permanent: true);
  }
}
