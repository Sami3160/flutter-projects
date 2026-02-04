import 'package:digitomize/app/config/app_colors.dart';
import 'package:digitomize/presentation/controllers/blog_controller.dart';
import 'package:digitomize/presentation/widgets/grid_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogsView extends GetView<BlogController> {
  const BlogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Blogs',
          style: GoogleFonts.inter(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: GridPainter())),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.article_outlined,
                      size: 80,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Welcome to Daily Blogs',
                    style: GoogleFonts.outfit(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "Blogs",
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () => controller.isLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                )
                              : _buildBlogsGrid(),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => ElevatedButton.icon(
                            onPressed: () => controller.loadPrevious(),
                            icon: const Icon(Icons.arrow_back_rounded),
                            label: Text(
                              'Previous',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary.withOpacity(
                                0.1,
                              ),
                              foregroundColor: controller.hasPrevious.value
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Obx(
                          () => ElevatedButton.icon(
                            onPressed: () => controller.loadMore(),
                            icon: const Icon(Icons.arrow_forward_rounded),
                            label: Text(
                              'Next',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary.withOpacity(
                                0.1,
                              ),
                              foregroundColor: controller.hasNext.value
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogsGrid() {
    return Column(
      children: controller.blogs.map((blog) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF151520), // Dark blueish
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.surfaceLight,
                    backgroundImage:
                        (blog.owner.profileUrl != null &&
                            blog.owner.profileUrl!.isNotEmpty)
                        ? NetworkImage(blog.owner.profileUrl!)
                        : null,
                    child:
                        (blog.owner.profileUrl == null ||
                            blog.owner.profileUrl!.isEmpty)
                        ? Text(
                            blog.owner.username.isNotEmpty
                                ? blog.owner.username[0].toUpperCase()
                                : "?",
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      blog.owner.username,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Get.toNamed('/blog-detail', arguments: {"blogId":blog.id});
                    },
                    icon: const Icon(
                      Icons.open_in_new_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    label: Text(
                      'View',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                blog.title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (blog.thumbnailUrl != null &&
                  blog.thumbnailUrl!.isNotEmpty) ...[
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      blog.thumbnailUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.surfaceLight,
                        child: const Icon(
                          Icons.broken_image,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 10),
              Text(
                blog.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: Colors.grey,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _getHostLogo(String host) {
    if (host.isEmpty) return const SizedBox.shrink();

    // Use Clearbit Logo API
    final logoUrl = "https://logo.clearbit.com/$host.com";
    final logoMap = {
      "devfolio":
          "https://yt3.googleusercontent.com/3EOobmaqaLu33EqKU4UyE3Wn-JdiES8gySvLl3t6liHxkYOtBsEkdkcmFYI4loAd_ghJqGle=s900-c-k-c0x00ffffff-no-rj",
      "devpost":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_bLVz0qPKC8X2OVOspl3_xC5B20HfCB6Tdg&s",
      "codechef":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMHK6xbsYOjPIQqavwttsH872LvAM9J0oNzA&s",
      "codingninjas":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8syRZMXv1_WobLr2R6pIQsAte5ayWMcCJdQ&s",
      "leetcode":
          "https://img.icons8.com/external-tal-revivo-shadow-tal-revivo/48/external-level-up-your-coding-skills-and-quickly-land-a-job-logo-shadow-tal-revivo.png",
      "atcoder":
          "https://tysonblog-whitelabel.com/wp-content/uploads/2021/09/atcoder-1536x1300.png",
      "codeforces":
          "https://img.icons8.com/external-tal-revivo-color-tal-revivo/24/external-codeforces-programming-competitions-and-contests-programming-community-logo-color-tal-revivo.png",
      "geeksforgeeks": "https://img.icons8.com/color/96/GeeksforGeeks.png",
      "hackerrank": "https://img.icons8.com/color/96/hackerrank.png",
    };

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: logoMap.containsKey(host)
              ? NetworkImage(logoMap[host]!)
              : NetworkImage(logoUrl) as ImageProvider,
          fit: BoxFit.contain,
          onError: (exception, stackTrace) {
            // Fallback will be handled by the child below if image fails
          },
        ),
      ),
      // Fallback text if image fails loading (though NetworkImage onError is limited)
      // A better approach in production is using a dedicated CachedNetworkImage with errorWidget
      child: Image.network(
        logoMap[host] ?? logoUrl,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              host[0].toUpperCase(),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
                fontSize: 20,
              ),
            ),
          );
        },
      ),
    );
  }
}
