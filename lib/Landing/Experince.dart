import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vishnup/core/theme/app_colors.dart';

class ResponsiveExperiencePage extends StatelessWidget {
  const ResponsiveExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isDesktop ? 50 : 1,
        vertical: isDesktop ? 40 : 24,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 24,
        vertical: isDesktop ? 32 : 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: AppColors.accent,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _StatItem(
            value: "2+",
            label: "Years of\nExperience",
            isDesktop: isDesktop,
            gradientColors: const [AppColors.primary, AppColors.secondary],
          ),
          _Divider(isDesktop: isDesktop),
          _StatItem(
            value: "15+",
            label: "Projects\nCompleted",
            isDesktop: isDesktop,
            gradientColors: const [AppColors.secondary, Color(0xFF9B6DE0)],
          ),
          _Divider(isDesktop: isDesktop),
          _StatItem(
            value: "5+",
            label: "Technologies\nMastered",
            isDesktop: isDesktop,
            gradientColors: const [Color(0xFF9B6DE0), AppColors.primary],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatefulWidget {
  final String value;
  final String label;
  final bool isDesktop;
  final List<Color> gradientColors;

  const _StatItem({
    required this.value,
    required this.label,
    required this.isDesktop,
    required this.gradientColors,
  });

  @override
  State<_StatItem> createState() => _StatItemState();
}

class _StatItemState extends State<_StatItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(
          horizontal: widget.isDesktop ? 28 : 16,
          vertical: widget.isDesktop ? 16 : 10,
        ),
        decoration: BoxDecoration(
          color: _hovering
              ? AppColors.accent.withOpacity(0.5)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: widget.gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                widget.value,
                style: GoogleFonts.montserrat(
                  fontSize: widget.isDesktop ? 42 : 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                  letterSpacing: -1,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.label,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: widget.isDesktop ? 13 : 9,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  final bool isDesktop;

  const _Divider({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.5,
      height: isDesktop ? 56 : 36,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent,
            AppColors.secondary.withOpacity(0.4),
            AppColors.accent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
