import 'package:digitomize/app/config/app_colors.dart';
import 'package:digitomize/presentation/controllers/home_controller.dart';
import 'package:digitomize/presentation/widgets/app_drawer.dart';
import 'package:digitomize/presentation/widgets/grid_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          // Background Grid Effect (Optional, simplified here)
          Positioned.fill(child: CustomPaint(painter: GridPainter())),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  // Hero Section
                  _buildHeroSection(),

                  const SizedBox(height: 60),

                  // Hackathons Section
                  Obx(
                    () =>
                        (controller.selectedFilter.value == "All" ||
                            controller.selectedFilter.value == "Contests")
                        ? Container(
                            child: Column(
                              children: [
                                Text(
                                  "Upcoming Contests",
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
                                      : _buildContestGrid(),
                                ),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                  ),

                  const SizedBox(height: 60),
                  Obx(
                    () =>
                        (controller.selectedFilter.value == "All" ||
                            controller.selectedFilter.value == "Hackathons")
                        ? Container(
                            child: Column(
                              children: [
                                Text(
                                  "Upcoming Hackthons",
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
                                      : _buildHackathonGrid(),
                                ),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                  ),

                  const SizedBox(height: 60),
                  Obx(
                    () =>
                        (controller.selectedFilter.value == "All" ||
                            controller.selectedFilter.value == "Blogs")
                        ? Container(
                            child: Column(
                              children: [
                                Text(
                                  "Daily Blogs",
                                  style: GoogleFonts.inter(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Explore our blog: your coding corner with practical tips.",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Obx(
                                  () => controller.isLoading.value
                                      ? const SizedBox.shrink()
                                      : _buildBlogsGrid(),
                                ),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                  ),

                  // Blogs Section
                  const SizedBox(height: 100), // Bottom spacing
                ],
              ),
            ),
          ),

          // Hamburger Menu Button
          Positioned(
            top: 16,
            left: 16,
            child: Builder(
              builder: (context) => Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: AppColors.primary,
                    size: 28,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Center(
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "All at ",
                  style: GoogleFonts.outfit(
                    fontSize: 48, 
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                WidgetSpan(
                  child: Container(
                    // padding: const EdgeInsets.symmetric(
                    //   horizontal: 8,
                    //   vertical: 0,
                    // ),
                    padding: EdgeInsets.only(
                      top: 0,
                      left: 8,
                      right: 8,
                      bottom: 0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.5),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Text(
                      "one",
                      style: GoogleFonts.outfit(
                        fontSize: 48, 
                        fontWeight: FontWeight.w900,
                        color: AppColors.background,
                      ),
                    ),
                  ),
                ),
                TextSpan(
                  text: " place",
                  style: GoogleFonts.outfit(
                    fontSize: 48, 
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                _buildFilterChip(
                  "All",
                  Icons.select_all_outlined,
                  isActive: controller.selectedFilter.value == 'All',
                  onTap: () => controller.setFilter('All'),
                ),
                _buildFilterChip(
                  "Contests",
                  Icons.show_chart,
                  isActive: controller.selectedFilter.value == 'Contests',
                  onTap: () => controller.setFilter('Contests'),
                ),
                _buildFilterChip(
                  "Hackathons",
                  Icons.rocket_launch,
                  isActive: controller.selectedFilter.value == 'Hackathons',
                  onTap: () => controller.setFilter('Hackathons'),
                ),
                _buildFilterChip(
                  "Blogs",
                  Icons.rocket_launch,
                  isActive: controller.selectedFilter.value == 'Blogs',
                  onTap: () => controller.setFilter('Blogs'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Text(
            "Want hackathons from more platforms? Join our Discord or click here and let us know!",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    IconData icon, {
    bool isActive = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isActive ? AppColors.textPrimary : Colors.transparent,
          border: Border.all(color: AppColors.textSecondary.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: isActive ? AppColors.background : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isActive) ...[
              const SizedBox(width: 8),
              const Icon(Icons.check, size: 16, color: AppColors.background),
            ],
          ],
        ),
      ),
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

  Future<void> _launchUrl(String? urlString) async {
    if (urlString == null || urlString.isEmpty) return;
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.snackbar("Error", "Could not launch $urlString");
    }
  }

  Widget _buildContestGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: (controller.upcomingContests.length > 3
          ? 3
          : controller.upcomingContests.length),
      itemBuilder: (context, index) {
        final contest = controller.upcomingContests[index];
        final DateTime startDate = DateTime.fromMillisecondsSinceEpoch(
          (contest.startTimeUnix ?? 0) * 1000,
        );
        final String formattedDate = DateFormat(
          'dd MMM yyyy, hh:mm a',
        ).format(startDate);

        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.surfaceLight),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Host Logo
              _getHostLogo(contest.host ?? ''),
              const SizedBox(width: 16),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contest.name ?? "Unknown Contest",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Starts: $formattedDate",
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "By ${contest.host}",
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${(contest.duration ?? 0)} min",
                          style: GoogleFonts.inter(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () => _launchUrl(contest.url),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.5),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Visit",
                                  style: GoogleFonts.inter(
                                    color: AppColors.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.arrow_forward,
                                  size: 12,
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHackathonGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: (controller.upcomingHackthons.length > 3
          ? 3
          : controller.upcomingHackthons.length),
      itemBuilder: (context, index) {
        final hackathon = controller.upcomingHackthons[index];
        final DateTime startDate = DateTime.fromMillisecondsSinceEpoch(
          (hackathon.hackathonStartTimeUnix ?? 0) * 1000,
        );
        final String formattedDate = DateFormat(
          'dd MMM yyyy, hh:mm a',
        ).format(startDate);

        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.surfaceLight),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Host Logo
              _getHostLogo(hackathon.host ?? ''),
              const SizedBox(width: 16),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hackathon.name ?? "Unknown Hackathon",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Starts: $formattedDate",
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "By ${hackathon.host}",
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${(hackathon.duration! / (24 * 60)).round()} days",
                          style: GoogleFonts.inter(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () => _launchUrl(hackathon.url),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.5),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Visit",
                                  style: GoogleFonts.inter(
                                    color: AppColors.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.arrow_forward,
                                  size: 12,
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBlogsGrid() {
    return Column(
      children: controller.recentBlogs.map((blog) {
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
}
