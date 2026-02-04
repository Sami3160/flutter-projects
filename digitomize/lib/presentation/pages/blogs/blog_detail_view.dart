import 'dart:convert';

import 'package:digitomize/app/config/app_colors.dart';
import 'package:digitomize/presentation/controllers/blog_detail_controller.dart';
import 'package:digitomize/presentation/widgets/grid_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BlogDetailView extends GetView<BlogDetailController> {
  const BlogDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: GridPainter())),

          SafeArea(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }

              if (controller.error.value.isNotEmpty) {
                return _buildErrorState();
              }

              final blog = controller.blog.value;
              if (blog == null) {
                return _buildErrorState();
              }
              print("this is title ${controller.blog.value!.title!}");

              return CustomScrollView(
                slivers: [
                  _buildSliverAppBar(blog.title, blog.thumbnailUrl),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            blog.title,
                            style: GoogleFonts.outfit(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 16),

                          _buildMetaInfo(blog),
                          const SizedBox(height: 20),

                          _buildAuthorCard(blog),
                          const SizedBox(height: 20),

                          // Tags
                          if (blog.tags != null && blog.tags!.isNotEmpty)
                            _buildTags(blog.tags!),

                          const SizedBox(height: 24),

                          // Divider
                          Container(
                            height: 1,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primary.withOpacity(0.5),
                                  AppColors.primary.withOpacity(0.1),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // HTML Content
                          _buildHtmlContent(blog.content),

                          const SizedBox(height: 32),

                          // Comments section
                          _buildCommentsSection(blog),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(String title, String? thumbnailUrl) {
    return SliverAppBar(
      expandedHeight: thumbnailUrl != null && thumbnailUrl.isNotEmpty ? 250 : 0,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.background.withOpacity(0.95),
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.background.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      flexibleSpace: thumbnailUrl != null && thumbnailUrl.isNotEmpty
          ? FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    thumbnailUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.surfaceLight,
                      child: const Icon(
                        Icons.broken_image,
                        color: AppColors.textSecondary,
                        size: 48,
                      ),
                    ),
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.background.withOpacity(0.8),
                          AppColors.background,
                        ],
                        stops: const [0.0, 0.7, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget _buildMetaInfo(blog) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          // Date
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: AppColors.primary.withOpacity(0.8),
              ),
              const SizedBox(width: 6),
              Text(
                dateFormat.format(blog.createdAt),
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),

          // Likes
          Row(
            children: [
              Icon(
                Icons.favorite_rounded,
                size: 16,
                color: Colors.redAccent.withOpacity(0.8),
              ),
              const SizedBox(width: 6),
              Text(
                '${blog.likes?.length ?? 0} likes',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),

          // Comments
          Row(
            children: [
              Icon(
                Icons.chat_bubble_outline_rounded,
                size: 16,
                color: AppColors.primary.withOpacity(0.8),
              ),
              const SizedBox(width: 6),
              Text(
                '${blog.comments?.length ?? 0} comments',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAuthorCard(blog) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.15),
            AppColors.primary.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 28,
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
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 16),

          // Author info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Written by',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  blog.owner.username,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (blog.owner.email != null && blog.owner.email!.isNotEmpty)
                  Text(
                    blog.owner.email!,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),

          // View profile button
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.person_outline_rounded,
                color: AppColors.primary,
              ),
              onPressed: () {
                Get.snackbar(
                  'Profile',
                  'Viewing ${blog.owner.username}\'s profile',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.primary.withOpacity(0.9),
                  colorText: Colors.white,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTags(List<String> tags) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.local_offer_outlined,
              size: 18,
              color: AppColors.primary.withOpacity(0.8),
            ),
            const SizedBox(width: 8),
            Text(
              'Tags',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags.map((tag) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                '#$tag',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildHtmlContent(String htmlContent) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF151520),
        borderRadius: BorderRadius.circular(16),
      ),
      child: HtmlWidget(
        htmlContent,
        textStyle: GoogleFonts.inter(
          fontSize: 15,
          color: AppColors.textPrimary,
          height: 1.7,
        ),
        customStylesBuilder: (element) {
          if (element.localName == 'a') {
            return {'color': '#4F46E5', 'text-decoration': 'underline'};
          }
          if (element.localName == 'h1' || element.localName == 'h2') {
            return {'color': '#FFFFFF', 'font-weight': 'bold'};
          }
          if (element.localName == 'code') {
            return {
              'background-color': '#1E1E2E',
              'padding': '4px 8px',
              'border-radius': '4px',
              'font-family': 'monospace',
            };
          }
          if (element.localName == 'pre') {
            return {
              'background-color': '#1E1E2E',
              'padding': '16px',
              'border-radius': '8px',
              'overflow': 'auto',
            };
          }
          return null;
        },
        onTapUrl: (url) {
          Get.snackbar(
            'Opening Link',
            url,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.primary.withOpacity(0.9),
            colorText: Colors.white,
          );
          return true;
        },
      ),
    );
  }

  Widget _buildCommentsSection(blog) {
    final comments = blog.comments ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.chat_bubble_rounded,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Comments',
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${comments.length}',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Comments list or empty state
        if (comments.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 40,
                    color: AppColors.textSecondary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No comments yet',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Be the first to share your thoughts!',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textSecondary.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ...comments.map((comment) => _buildCommentItem(comment)).toList(),
      ],
    );
  }

  Widget _buildCommentItem(dynamic comment) {
    final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.surfaceLight.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author row
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primary.withOpacity(0.2),
                backgroundImage:
                    (comment.author.profileUrl != null &&
                        comment.author.profileUrl!.isNotEmpty)
                    ? NetworkImage(comment.author.profileUrl!)
                    : null,
                child:
                    (comment.author.profileUrl == null ||
                        comment.author.profileUrl!.isEmpty)
                    ? Text(
                        comment.author.username.isNotEmpty
                            ? comment.author.username[0].toUpperCase()
                            : "?",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.author.username,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      dateFormat.format(comment.createdAt),
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppColors.textSecondary.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Comment content
          Text(
            comment.content,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Oops! Something went wrong',
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              controller.error.value.isNotEmpty
                  ? controller.error.value
                  : 'Failed to load blog',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text('Go Back'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () => controller.refresh(),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
