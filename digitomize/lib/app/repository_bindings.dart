import 'package:digitomize/data/repositories/auth_repository_impl.dart';
import 'package:digitomize/data/repositories/blog_repository_impl.dart';
import 'package:digitomize/data/repositories/contest_repository_impl.dart';
import 'package:digitomize/data/repositories/hackthon_repository_impl.dart';
import 'package:digitomize/domain/repositories/auth_repository.dart';
import 'package:digitomize/domain/repositories/blog_repository.dart';
import 'package:digitomize/domain/repositories/contest_repository.dart';
import 'package:digitomize/domain/repositories/hackthon_repository.dart';
import 'package:get/get.dart';

class RepositoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl());
    Get.lazyPut<BlogRepository>(() => BlogRepositoryImpl());
    Get.lazyPut<ContestRepository>(() => ContestRepositoryImpl());
    Get.lazyPut<HackthonRepository>(() => HackthonRepositoryImpl());
  }
}
