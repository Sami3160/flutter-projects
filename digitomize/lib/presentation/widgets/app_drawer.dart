import 'package:digitomize/app/config/app_colors.dart';
import 'package:digitomize/app/routes/app_pages.dart';
import 'package:digitomize/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Obx(() {
                final isLoggedIn = authController.isLoggedIn;
                final user = authController.user;

                if (isLoggedIn && user != null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 32,
                        
                        backgroundColor:user.profileUrl!=null?Colors.transparent: AppColors.background,
                        
                        backgroundImage:  user.profileUrl!=null? NetworkImage(user.profileUrl!):null,
                        child:user.profileUrl!=null?null: Text(
                          user.username[0].toUpperCase(),
                          style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        user.username,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.background,
                        ),
                      ),
                      if (user.email != null && user.email!.isNotEmpty)
                        Text(
                          user.email!,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.background.withOpacity(0.8),
                          ),
                        ),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: AppColors.background,
                        child: Icon(
                          Icons.person_outline,
                          size: 32,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Welcome',
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.background,
                        ),
                      ),
                      Text(
                        'Guest User',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.background.withOpacity(0.8),
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),

            const SizedBox(height: 16),

            // Navigation Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  _buildDrawerItem(
                    icon: Icons.home_outlined,
                    title: 'Home',
                    onTap: () {
                      Get.back();
                      Get.offAllNamed(Routes.HOME);
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.emoji_events_outlined,
                    title: 'Contests',
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.CONTESTS);
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.rocket_launch_outlined,
                    title: 'Hackathons',
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.HACKATHONS);
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.article_outlined,
                    title: 'Blogs',
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.BLOGS);
                    },
                  ),

                  const Divider(
                    height: 32,
                    thickness: 1,
                    color: AppColors.surfaceLight,
                    indent: 16,
                    endIndent: 16,
                  ),

                  // Conditional Login/Profile
                  Obx(() {
                    final isLoggedIn = authController.isLoggedIn;

                    if (isLoggedIn) {
                      return Column(
                        children: [
                          _buildDrawerItem(
                            icon: Icons.person_outline,
                            title: 'Profile',
                            onTap: () {
                              Get.back();
                              Get.snackbar(
                                'Coming Soon',
                                'Profile page will be available soon',
                                backgroundColor: AppColors.primary.withOpacity(
                                  0.1,
                                ),
                                colorText: AppColors.textPrimary,
                              );
                            },
                          ),
                          _buildDrawerItem(
                            icon: Icons.logout,
                            title: 'Logout',
                            onTap: () {
                              Get.back();
                              authController.logout();
                            },
                          ),
                        ],
                      );
                    } else {
                      return _buildDrawerItem(
                        icon: Icons.login,
                        title: 'Login',
                        onTap: () {
                          Get.back();
                          Get.toNamed(Routes.LOGIN);
                        },
                      );
                    }
                  }),
                ],
              ),
            ),

            
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      hoverColor: AppColors.primary.withOpacity(0.1),
      onTap: onTap,
    );
  }
}
