import 'package:digitomize/domain/entities/blog.dart';
import 'package:digitomize/domain/usecases/get_blogs_usecase.dart';
import 'package:get/get.dart';

class BlogController extends GetxController{
  final GetBlogsUseCase getBlogsUseCase;
  BlogController( {required this.getBlogsUseCase});

  final RxList<Blog> blogs = <Blog>[].obs;
  final RxBool isLoading = true.obs;
  final RxString selectedFilter = 'All'.obs;
  final RxInt page = 1.obs;
  final RxInt pageSize = 4.obs;
  final RxBool hasNext = true.obs;
  final RxBool hasPrevious = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchBlogs();
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    page.value = 1;
    fetchBlogs();
  }

  void loadMore() {
    if (hasNext.value) {
      page.value++;
      fetchBlogs();
    }
  }

  void loadPrevious() {
    print("load previous triggered ${page.value}");
    if (hasPrevious.value && page.value > 1) {
      print("Loading previous page ${page.value}");
      page.value--;
      fetchBlogs();
    }
  }

  Future<void> fetchBlogs() async {
    try {
      final blogs = await getBlogsUseCase.execute(GetBlogsParams(page:page.value, pageSize : pageSize.value));
      if(blogs.length<pageSize.value){
        hasNext.value=false;
      }else{
        hasNext.value=true;
      }
      if(page.value>1){
        hasPrevious.value=true;
      }else{
        hasPrevious.value=false;
      }
      this.blogs.value = blogs;
    } catch (e) {
      print("❌ BlogController Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}