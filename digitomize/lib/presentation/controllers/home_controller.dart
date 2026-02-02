import 'package:digitomize/domain/entities/blog.dart';
import 'package:digitomize/domain/entities/contest.dart';
import 'package:digitomize/domain/usecases/get_blogs_usecase.dart';
import 'package:digitomize/domain/usecases/get_contest_usecase.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GetContestsUseCase _getContestsUseCase;
  final GetBlogsUseCase _getBlogsUseCase;

  HomeController(this._getContestsUseCase, this._getBlogsUseCase);

  final RxList<Contest> upcomingContests = <Contest>[].obs;
  final RxList<Blog> recentBlogs = <Blog>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      // Fetch concurrently
      final results = await Future.wait([
        _getContestsUseCase.execute(GetContestsParams(page: 1, pageSize: 3)),
        _getBlogsUseCase.execute(GetBlogsParams(page: 1, pageSize: 3)),
      ]);

      upcomingContests.value = results[0] as List<Contest>;
      recentBlogs.value = results[1] as List<Blog>;
    } catch (e) {
      print("Error fetching home data: $e");
      // Add snackbar error handling here
    } finally {
      isLoading.value = false;
    }
  }
}
