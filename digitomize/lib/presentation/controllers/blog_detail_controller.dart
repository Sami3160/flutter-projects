import 'package:digitomize/domain/entities/blog.dart';
import 'package:digitomize/domain/usecases/get_one_blog_usecase.dart';
import 'package:digitomize/domain/usecases/get_summary_usecase.dart';
import 'package:get/get.dart';

class BlogDetailController extends GetxController {
  final GetOneBlogUseCase getOneBlogUseCase;
  final GetSummaryUsecase getSummaryUsecase;
  BlogDetailController({required this.getOneBlogUseCase, required this.getSummaryUsecase});

  final Rxn<Blog> blog = Rxn<Blog>();
  final RxBool isLoading = true.obs;
  final RxBool isSummaryLoading = false.obs;
  final RxString summaryError = ''.obs;
  final RxString error = ''.obs;
  final RxString summary = ''.obs;
  late String blogId;

  @override
  void onInit() {
    super.onInit();
    blogId = Get.arguments['blogId'] as String;
    fetchBlog();
  }

  Future<void> fetchBlog() async {
    try {
      isLoading.value = true;
      error.value = '';
      final result = await getOneBlogUseCase.execute(blogId);
      blog.value = result;
    } catch (e) {
      print("❌ BlogDetailController Error: $e");
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchSummary()async{
    try {
      isSummaryLoading.value = true;
      summaryError.value = '';
      final result = await getSummaryUsecase.execute(GetSummaryParams(id: blogId));
      summary.value = result;
    } catch (e) {
      print("❌ BlogDetailController Error: $e");
      summaryError.value = e.toString();
    } finally {
      isSummaryLoading.value = false;
    }
  }

  @override
  void refresh() {
    fetchBlog();
  }
}
