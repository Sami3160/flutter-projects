import 'package:digitomize/domain/entities/blog.dart';
import 'package:digitomize/domain/entities/contest.dart';
import 'package:digitomize/domain/entities/hackthon.dart';
import 'package:digitomize/domain/usecases/get_blogs_usecase.dart';
import 'package:digitomize/domain/usecases/get_contest_usecase.dart';
import 'package:digitomize/domain/usecases/get_hackthons_usecase.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GetContestsUseCase _getContestsUseCase;
  final GetBlogsUseCase _getBlogsUseCase;
  final GetHackthonsUseCase _getHackthonsUseCase;

  HomeController(this._getContestsUseCase, this._getBlogsUseCase, this._getHackthonsUseCase);

  final RxList<Contest> upcomingContests = <Contest>[].obs;
  final RxList<Hackthon> upcomingHackthons = <Hackthon>[].obs;

  final RxList<Blog> recentBlogs = <Blog>[].obs;
  final RxBool isLoading = true.obs;
  final RxString selectedFilter = 'All'.obs;


  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    print("🏠 HomeController: Starting to fetch home data...");
    isLoading.value = true;
    try {
      // Fetch concurrently
      final results = await Future.wait([
        _getContestsUseCase.execute(GetContestsParams(page: 1, pageSize: 3)),
        _getBlogsUseCase.execute(GetBlogsParams(page: 1, pageSize: 3)),
        _getHackthonsUseCase.execute(GetHackthonsParams(page: 1, pageSize: 3)),
      ]);

      final contests = results[0] as List<Contest>;
      final blogs = results[1] as List<Blog>;
      final hackthons = results[2] as List<Hackthon>;

      print(
        "📊 HomeController: Fetched ${contests.length} contests and ${blogs.length} blogs.",
      );

      upcomingContests.value = contests;
      recentBlogs.value = blogs;
      upcomingHackthons.value = hackthons;
    } catch (e) {
      print("❌ HomeController Error: $e");
    } finally {
      isLoading.value = false;
      print("🏁 HomeController: Fetch process completed.");
    }
  }
}
