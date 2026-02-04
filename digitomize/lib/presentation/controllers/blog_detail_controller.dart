import 'package:digitomize/domain/entities/blog.dart';
import 'package:digitomize/domain/usecases/get_one_blog_usecase.dart';
import 'package:get/get.dart';

class BlogDetailController extends GetxController {
  final GetOneBlogUseCase getOneBlogUseCase;
  BlogDetailController({required this.getOneBlogUseCase});

  final Rxn<Blog> blog = Rxn<Blog>();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

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

  void refresh() {
    fetchBlog();
  }
}
