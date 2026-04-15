import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vishnup/Landing/About.dart';
import 'package:vishnup/core/theme/app_colors.dart';
import 'PhotoSection.dart';
import 'Projects.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _bubbleController;
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _scrollController.addListener(() {
      setState(() => _scrollOffset = _scrollController.offset);
    });
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth > 900;

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child:
            _AnimatedAppBar(scrollOffset: _scrollOffset, isDesktop: isDesktop),
      ),
      body: Stack(
        children: [
          _GlobalBubbles(controller: _bubbleController),
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 64),
                const HeroSection(),
                const SizedBox(height: 8),
                _SectionDivider(),
                const SizedBox(height: 8),
                const AboutContent(),
                const SizedBox(height: 48),
                const KealthyPortfolioPage(),
                const SizedBox(height: 80),
                _Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedAppBar extends StatelessWidget {
  final double scrollOffset;
  final bool isDesktop;

  const _AnimatedAppBar({required this.scrollOffset, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final bool scrolled = scrollOffset > 10;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: scrolled
            ? AppColors.background.withOpacity(0.92)
            : Colors.transparent,
        boxShadow: scrolled
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.10),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 56 : 20,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _LogoMark(),
              _NavDot(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoMark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.35),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              "V",
              style: GoogleFonts.playfairDisplay(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Port",
                style: GoogleFonts.nunito(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: "folio",
                style: GoogleFonts.dmSans(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NavDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: AppColors.secondary.withOpacity(0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.success,
            ),
          ),
          const SizedBox(width: 7),
          Text(
            "Open to work",
            style: GoogleFonts.syne(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlobalBubbles extends StatelessWidget {
  final AnimationController controller;
  const _GlobalBubbles({required this.controller});

  static const List<_BubbleDef> defs = [
    _BubbleDef(x: 0.93, y: 0.04, r: 110, s: 0.9, o: 0.10),
    _BubbleDef(x: 0.04, y: 0.10, r: 60, s: 1.3, o: 0.08),
    _BubbleDef(x: 0.88, y: 0.38, r: 150, s: 0.7, o: 0.07),
    _BubbleDef(x: 0.55, y: 0.02, r: 45, s: 1.7, o: 0.13),
    _BubbleDef(x: 0.08, y: 0.55, r: 90, s: 1.0, o: 0.07),
    _BubbleDef(x: 0.72, y: 0.72, r: 75, s: 1.2, o: 0.09),
    _BubbleDef(x: 0.25, y: 0.88, r: 55, s: 1.5, o: 0.10),
    _BubbleDef(x: 0.42, y: 0.50, r: 30, s: 2.0, o: 0.12),
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) => CustomPaint(
            painter: _BubblePainter(progress: controller.value, defs: defs),
          ),
        ),
      ),
    );
  }
}

class _BubbleDef {
  final double x, y, r, s, o;
  const _BubbleDef({
    required this.x,
    required this.y,
    required this.r,
    required this.s,
    required this.o,
  });
}

class _BubblePainter extends CustomPainter {
  final double progress;
  final List<_BubbleDef> defs;

  const _BubblePainter({required this.progress, required this.defs});

  @override
  void paint(Canvas canvas, Size size) {
    for (final b in defs) {
      final float = math.sin((progress * math.pi * 2 * b.s) + b.x * 12) * 20;
      final cx = b.x * size.width;
      final cy = b.y * size.height + float;
      final offset = Offset(cx, cy);

      final grad = RadialGradient(
        colors: [
          AppColors.secondary.withOpacity(b.o * 1.8),
          AppColors.primary.withOpacity(b.o * 0.5),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      );
      canvas.drawCircle(
        offset,
        b.r,
        Paint()
          ..shader =
              grad.createShader(Rect.fromCircle(center: offset, radius: b.r)),
      );
      canvas.drawCircle(
        offset,
        b.r,
        Paint()
          ..color = AppColors.secondary.withOpacity(b.o * 0.7)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0,
      );
    }
  }

  @override
  bool shouldRepaint(_BubblePainter old) => old.progress != progress;
}

class _SectionDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        width: screenWidth * 0.6,
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              AppColors.secondary.withOpacity(0.45),
              AppColors.primary.withOpacity(0.3),
              AppColors.secondary.withOpacity(0.45),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth > 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 48,
        horizontal: isDesktop ? 72 : 24,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withOpacity(0.5),
            AppColors.background,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border(
          top: BorderSide(
            color: AppColors.secondary.withOpacity(0.25),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          _FooterTop(isDesktop: isDesktop),
          const SizedBox(height: 32),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.secondary.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "© 2024 Vishnu P. Built with Flutter  💜",
            style: GoogleFonts.syne(
              fontSize: 12.5,
              color: AppColors.textSecondary.withOpacity(0.6),
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterTop extends StatelessWidget {
  final bool isDesktop;
  const _FooterTop({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    const emailChip = _ContactChip(
      icon: FontAwesomeIcons.envelope,
      label: "vishnup.contact@gmail.com",
    );

    final tagline = Column(
      crossAxisAlignment:
          isDesktop ? CrossAxisAlignment.end : CrossAxisAlignment.center,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
          ).createShader(bounds),
          child: Text(
            "Let's build something\namazing together.",
            textAlign: isDesktop ? TextAlign.right : TextAlign.center,
            style: GoogleFonts.syne(
              fontSize: isDesktop ? 22 : 18,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
              height: 1.4,
            ),
          ),
        ),
      ],
    );

    if (isDesktop) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [emailChip, tagline],
      );
    }

    return Column(
      children: [
        tagline,
        const SizedBox(height: 20),
        emailChip,
      ],
    );
  }
}

class _ContactChip extends StatefulWidget {
  final IconData icon;
  final String label;

  const _ContactChip({required this.icon, required this.label});

  @override
  State<_ContactChip> createState() => _ContactChipState();
}

class _ContactChipState extends State<_ContactChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        decoration: BoxDecoration(
          color:
              _hovered ? AppColors.accent : AppColors.accent.withOpacity(0.5),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hovered
                ? AppColors.primary.withOpacity(0.6)
                : AppColors.secondary.withOpacity(0.3),
            width: 1.3,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.18),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              size: 15,
              color: _hovered ? AppColors.primary : AppColors.secondary,
            ),
            const SizedBox(width: 12),
            Text(
              widget.label,
              style: GoogleFonts.syne(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color:
                    _hovered ? AppColors.textPrimary : AppColors.textSecondary,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
