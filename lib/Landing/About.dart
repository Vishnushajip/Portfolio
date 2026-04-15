import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vishnup/core/theme/app_colors.dart';

class AboutContent extends StatelessWidget {
  const AboutContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    final List<Map<String, String>> skills = [
      {
        "image":
            "https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png",
        "text": "Flutter",
      },
      {
        "image":
            "data:image/png;base64,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",
        "text": "Node.js",
      },
      {
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/9/93/Amazon_Web_Services_Logo.svg",
        "text": "AWS",
      },
      {
        "image": "https://www.vectorlogo.zone/logos/firebase/firebase-icon.svg",
        "text": "Firebase",
      },
      {
        "image": "https://www.vectorlogo.zone/logos/dartlang/dartlang-icon.svg",
        "text": "Dart",
      },
      {
        "image": "https://www.vectorlogo.zone/logos/mongodb/mongodb-icon.svg",
        "text": "MongoDB",
      },
      {
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRl6wecw58g4VgI_ZEXawG1TMvhTy2tKFq6Yw&s",
        "text": "Razorpay",
      },
      {
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ79VUwBFYxXaX6rNi_delvVdh5n9t4Pd-0Ew&s",
        "text": "AI / LLM",
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 50 : 20,
        vertical: isDesktop ? 50 : 28,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _SectionHeader(isDesktop: isDesktop),
          SizedBox(height: isDesktop ? 40 : 28),
          _SkillGrid(skills: skills, isDesktop: isDesktop),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final bool isDesktop;

  const _SectionHeader({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Text(
              "TECH STACK",
              style: GoogleFonts.lexend(
                fontSize: isDesktop ? 64 : 40,
                fontWeight: FontWeight.w900,
                color: AppColors.accent.withOpacity(0.35),
                letterSpacing: 8,
              ),
            ),
            Column(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    "My Tech Stack",
                    style: GoogleFonts.lexend(
                      fontSize: isDesktop ? 32 : 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: AppColors.secondary.withOpacity(0.4)),
                  ),
                  child: Text(
                    "Technologies I've been working with recently",
                    style: GoogleFonts.lexend(
                      fontSize: isDesktop ? 14 : 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _SkillGrid extends StatelessWidget {
  final List<Map<String, String>> skills;
  final bool isDesktop;

  const _SkillGrid({required this.skills, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 36 : 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.07),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
        border: Border.all(color: AppColors.accent, width: 1.5),
      ),
      child: Wrap(
        spacing: isDesktop ? 16 : 10,
        runSpacing: isDesktop ? 16 : 10,
        alignment: WrapAlignment.center,
        children: skills
            .map((skill) => _SkillCard(skill: skill, isDesktop: isDesktop))
            .toList(),
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final Map<String, String> skill;
  final bool isDesktop;

  const _SkillCard({required this.skill, required this.isDesktop});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final size = widget.isDesktop ? 64.0 : 44.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        width: widget.isDesktop ? 120 : 90,
        padding: EdgeInsets.symmetric(
          vertical: widget.isDesktop ? 20 : 14,
          horizontal: widget.isDesktop ? 12 : 8,
        ),
        decoration: BoxDecoration(
          color: _hovering
              ? AppColors.accent.withOpacity(0.55)
              : AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovering ? AppColors.secondary : AppColors.accent,
            width: 1.5,
          ),
          boxShadow: _hovering
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _hovering
                    ? AppColors.white
                    : AppColors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color:
                        AppColors.primary.withOpacity(_hovering ? 0.12 : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CachedNetworkImage(
                imageUrl: widget.skill["image"]!,
                width: size,
                height: size,
                fit: BoxFit.contain,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: AppColors.accent,
                  highlightColor: AppColors.white,
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.code_rounded,
                  size: size * 0.6,
                  color: AppColors.secondary,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.skill["text"]!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: widget.isDesktop ? 12 : 10,
                fontWeight: FontWeight.w600,
                color: _hovering ? AppColors.primary : AppColors.textSecondary,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
