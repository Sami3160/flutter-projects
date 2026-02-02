import 'package:digitomize/app/config/app_colors.dart';
import 'package:digitomize/presentation/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
                  Text(
                    "Upcoming Hackathons",
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
                        : _buildHackathonsGrid(),
                  ),

                  const SizedBox(height: 60),

                  // Blogs Section
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

                  const SizedBox(height: 100), // Bottom spacing
                ],
              ),
            ),
          ),

          // Floating Navigation Bar
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Center(child: _buildNavBar()),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _navItem("Home"),
          const SizedBox(width: 20),
          _navItem("Top Companies"),
          const SizedBox(width: 20),
          _navItem("Contests"),
          const SizedBox(width: 20),
          _navItem("Blogs"),
          const SizedBox(width: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Sign in",
              style: GoogleFonts.inter(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: AppColors.background,
        fontWeight: FontWeight.w600,
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
                    fontSize: 64,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                WidgetSpan(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.5),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: Text(
                      "one",
                      style: GoogleFonts.outfit(
                        fontSize: 64,
                        fontWeight: FontWeight.w900,
                        color: AppColors.background,
                      ),
                    ),
                  ),
                ),
                TextSpan(
                  text: " place",
                  style: GoogleFonts.outfit(
                    fontSize: 64,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFilterChip("Contests", Icons.show_chart),
              const SizedBox(width: 16),
              _buildFilterChip("Challenges", Icons.code),
              const SizedBox(width: 16),
              _buildFilterChip(
                "Hackathons",
                Icons.rocket_launch,
                isActive: true,
              ),
            ],
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
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? AppColors.textPrimary : Colors.transparent,
        border: Border.all(color: AppColors.textSecondary.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
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
            const Icon(
              Icons.arrow_outward,
              size: 16,
              color: AppColors.background,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHackathonsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Assuming desktop/web view as per screenshots
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: controller.upcomingContests.length,
      itemBuilder: (context, index) {
        final contest = controller.upcomingContests[index];
        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.surfaceLight),
          ),
          padding: const EdgeInsets.all(20),
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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Text(
                "Host: ${contest.host}",
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Starts: ${(contest.startTimeUnix ?? 0)}", // TODO: Format date
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBlogsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Assuming desktop/web view as per screenshots
        childAspectRatio: 0.8,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: controller.recentBlogs.length,
      itemBuilder: (context, index) {
        final blog = controller.recentBlogs[index];
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF151520), // Dark blueish
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(backgroundColor: Colors.grey, radius: 15),
                  const SizedBox(width: 10),
                  Text(
                    blog.owner,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
              ),
              const SizedBox(height: 10),
              Text(
                blog.content,
                maxLines: 3,
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
      },
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..strokeWidth = 1;

    const double step = 60;

    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
