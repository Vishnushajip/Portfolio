import 'dart:html' as html;
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:vishnup/core/theme/app_colors.dart';
import '../Styles/Contactme.dart';
import 'AnimationText.dart';
import 'Professional.dart';
import 'package:vishnup/Landing/Experince.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _bubbleController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  Future<void> downloadPDF() async {
    try {
      final pdfData = await rootBundle.load('assets/Vishnu.p_CV_2025.pdf');
      final pdfBytes = pdfData.buffer.asUint8List();
      final blob = html.Blob([pdfBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..target = '_blank'
        ..download = 'Vishnu.p_CV_2025.pdf';
      anchor.click();
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      debugPrint("Error downloading PDF: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 100), () {
      _fadeController.forward();
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth > 900;
    final bool isTablet = screenWidth > 600 && screenWidth <= 900;

    return SingleChildScrollView(
      child: Stack(
        children: [
          _BackgroundBubbles(controller: _bubbleController),
          if (isDesktop) _DesktopPhotoBlend(),
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: isDesktop
                  ? _DesktopLayout(downloadPDF: downloadPDF)
                  : _MobileLayout(
                      isTablet: isTablet,
                      downloadPDF: downloadPDF,
                      screenWidth: screenWidth,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopPhotoBlend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final circleSize = screenWidth * 0.35;

    return Positioned(
      right: screenWidth * 0.05,
      top: screenHeight / 2 - circleSize / 2,
      child: Container(
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary,width: 1),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 25,
              spreadRadius: 8,
              offset: const Offset(0, 8),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.2),
              Colors.transparent,
            ],
          ),
        ),
        child: ClipOval(
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.background,
                Colors.transparent,
              ],
              stops: [0.0, 0.38],
            ).createShader(bounds),
            blendMode: BlendMode.dstOut,
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  AppColors.background,
                ],
                stops: [0.0, 0.65, 1.0],
              ).createShader(bounds),
              blendMode: BlendMode.dstOut,
              child: Image.asset(
                'assets/me.jpeg',
                width: circleSize,
                height: circleSize,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final Future<void> Function() downloadPDF;
  const _DesktopLayout({required this.downloadPDF});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 72),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _GreetingBadge(isDesktop: true),
                  const SizedBox(height: 10),
                  const _NameHeadline(isDesktop: true, isTablet: false),
                  const SizedBox(height: 10),
                  const _AnimatedRole(isDesktop: true, isTablet: false),
                  const SizedBox(height: 28),
                  _AboutText(screenWidth: screenWidth),
                  const SizedBox(height: 24),
                  const ProfessionalDetails(),
                  const SizedBox(height: 28),
                  _ActionButtons(
                    isDesktop: true,
                    downloadPDF: downloadPDF,
                  ),
                  const SizedBox(height: 40),
                  const ResponsiveExperiencePage(),
                ],
              ),
            ),
            const Expanded(flex: 45, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final bool isTablet;
  final Future<void> Function() downloadPDF;
  final double screenWidth;

  const _MobileLayout({
    required this.isTablet,
    required this.downloadPDF,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 36,
        horizontal: isTablet ? 40 : 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProfileRow(
            screenWidth: screenWidth,
            isDesktop: false,
            isTablet: isTablet,
          ),
          const SizedBox(height: 28),
          _AboutText(screenWidth: screenWidth),
          const SizedBox(height: 24),
          const ProfessionalDetails(),
          const SizedBox(height: 28),
          _ActionButtons(
            isDesktop: false,
            downloadPDF: downloadPDF,
          ),
          const SizedBox(height: 32),
          const ResponsiveExperiencePage(),
        ],
      ),
    );
  }
}

class _BackgroundBubbles extends StatelessWidget {
  final AnimationController controller;
  const _BackgroundBubbles({required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Positioned.fill(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _BubblePainter(
              progress: controller.value,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
          );
        },
      ),
    );
  }
}

class _BubblePainter extends CustomPainter {
  final double progress;
  final double screenWidth;
  final double screenHeight;

  _BubblePainter({
    required this.progress,
    required this.screenWidth,
    required this.screenHeight,
  });

  static const List<_BubbleConfig> bubbles = [
    _BubbleConfig(x: 0.85, y: 0.08, radius: 90, speed: 1.0, opacity: 0.18),
    _BubbleConfig(x: 0.05, y: 0.15, radius: 55, speed: 1.4, opacity: 0.12),
    _BubbleConfig(x: 0.92, y: 0.45, radius: 130, speed: 0.7, opacity: 0.10),
    _BubbleConfig(x: 0.70, y: 0.80, radius: 70, speed: 1.2, opacity: 0.14),
    _BubbleConfig(x: 0.12, y: 0.65, radius: 100, speed: 0.9, opacity: 0.09),
    _BubbleConfig(x: 0.50, y: 0.05, radius: 42, speed: 1.6, opacity: 0.16),
    _BubbleConfig(x: 0.30, y: 0.90, radius: 60, speed: 1.1, opacity: 0.11),
    _BubbleConfig(x: 0.78, y: 0.25, radius: 34, speed: 1.8, opacity: 0.20),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (final b in bubbles) {
      final floatOffset =
          math.sin((progress * math.pi * 2 * b.speed) + b.x * 10) * 18;
      final cx = b.x * size.width;
      final cy = b.y * size.height + floatOffset;

      final gradient = RadialGradient(
        colors: [
          AppColors.secondary.withOpacity(b.opacity * 1.6),
          AppColors.primary.withOpacity(b.opacity * 0.4),
          AppColors.accent.withOpacity(0),
        ],
        stops: const [0.0, 0.55, 1.0],
      );

      final paint = Paint()
        ..shader = gradient.createShader(
            Rect.fromCircle(center: Offset(cx, cy), radius: b.radius));
      canvas.drawCircle(Offset(cx, cy), b.radius, paint);

      final borderPaint = Paint()
        ..color = AppColors.secondary.withOpacity(b.opacity * 0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawCircle(Offset(cx, cy), b.radius, borderPaint);
    }
  }

  @override
  bool shouldRepaint(_BubblePainter old) => old.progress != progress;
}

class _BubbleConfig {
  final double x, y, radius, speed, opacity;
  const _BubbleConfig({
    required this.x,
    required this.y,
    required this.radius,
    required this.speed,
    required this.opacity,
  });
}

class _GreetingBadge extends StatelessWidget {
  final bool isDesktop;
  const _GreetingBadge({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        "Hello 👋, I'm",
        style: GoogleFonts.dmSans(
          fontSize: isDesktop ? 13 : 10,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _NameHeadline extends StatelessWidget {
  final bool isDesktop;
  final bool isTablet;
  const _NameHeadline({required this.isDesktop, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [AppColors.primary, AppColors.secondary],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(bounds),
      child: Text(
        "Vishnu.P",
        style: GoogleFonts.lexend(
          fontSize: isDesktop ? 52 : (isTablet ? 30 : 24),
          fontWeight: FontWeight.w700,
          color: AppColors.white,
          height: 1.1,
        ),
      ),
    );
  }
}

class _AnimatedRole extends StatelessWidget {
  final bool isDesktop;
  final bool isTablet;
  const _AnimatedRole({required this.isDesktop, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "And I'm a ",
          style: GoogleFonts.dmSans(
            color: AppColors.textSecondary,
            fontSize: isDesktop ? 17 : (isTablet ? 14 : 12),
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: AnimatedText(
            texts: const [
              "Flutter Developer",
              "Node.js Developer",
              "Mobile App Developer",
              "Web Developer",
              "Cross-Platform Developer",
            ],
            fontSize: isDesktop ? 17 : (isTablet ? 14 : 12),
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final double screenWidth;
  final bool isDesktop;
  final bool isTablet;

  const _ProfileRow({
    required this.screenWidth,
    required this.isDesktop,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    final double avatarSize = isDesktop ? 130 : (isTablet ? 100 : 72);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _AvatarWithGlow(size: avatarSize),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _GreetingBadge(isDesktop: isDesktop),
              const SizedBox(height: 6),
              _NameHeadline(isDesktop: isDesktop, isTablet: isTablet),
              const SizedBox(height: 6),
              _AnimatedRole(isDesktop: isDesktop, isTablet: isTablet),
            ],
          ),
        ),
      ],
    );
  }
}

class _AvatarWithGlow extends StatefulWidget {
  final double size;
  const _AvatarWithGlow({required this.size});

  @override
  State<_AvatarWithGlow> createState() => _AvatarWithGlowState();
}

class _AvatarWithGlowState extends State<_AvatarWithGlow>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (_, child) => Transform.scale(
        scale: _pulseAnimation.value,
        child: child,
      ),
      child: Container(
        width: widget.size + 12,
        height: widget.size + 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.45),
              blurRadius: 28,
              spreadRadius: 4,
            ),
          ],
        ),
        padding: const EdgeInsets.all(3),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
          ),
          padding: const EdgeInsets.all(3),
          child: ClipOval(
            child: Image.asset(
              'assets/me.jpeg',
              width: widget.size,
              height: widget.size,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class _AboutText extends StatelessWidget {
  final double screenWidth;
  const _AboutText({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = screenWidth > 900;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.55),
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: AppColors.secondary.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              "Software Developer with 2+ years of experience specializing in Flutter for frontend, and Node.js (NestJS) for backend. Expert in managing full cycle development.",
              textAlign: TextAlign.justify,
              style: GoogleFonts.dmSans(
                fontSize: isDesktop ? 15.5 : 13.5,
                height: 1.75,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final bool isDesktop;
  final Future<void> Function() downloadPDF;

  const _ActionButtons({
    required this.isDesktop,
    required this.downloadPDF,
  });

  @override
  Widget build(BuildContext context) {
    final buttons = [
      _GlowButton(
        label: "Download CV",
        icon: FontAwesomeIcons.download,
        onPressed: downloadPDF,
        filled: true,
      ),
      _GlowButton(
        label: "Contact Now",
        icon: CupertinoIcons.chat_bubble_text,
        onPressed: () => ContactUtils.showContactAlert(context),
        filled: false,
      ),
    ];

    if (isDesktop) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buttons[0],
          const SizedBox(width: 16),
          buttons[1],
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buttons[0],
        const SizedBox(height: 14),
        buttons[1],
      ],
    );
  }
}

class _GlowButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool filled;

  const _GlowButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.filled,
  });

  @override
  State<_GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<_GlowButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  bool _hovering = false;

  static const Color _brand = AppColors.primary;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(_) => _controller.forward();
  void _onTapUp(_) => _controller.reverse();
  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _scaleAnim,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnim.value,
            child: child,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: widget.filled
                ? BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _brand,
                        Color.lerp(_brand, AppColors.secondary, 0.55)!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: _brand.withOpacity(_hovering ? 0.55 : 0.30),
                        blurRadius: _hovering ? 22 : 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  )
                : BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: _brand.withOpacity(_hovering ? 1.0 : 0.6),
                      width: 1.8,
                    ),
                    boxShadow: _hovering
                        ? [
                            BoxShadow(
                              color: _brand.withOpacity(0.18),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: widget.filled
                        ? AppColors.white.withOpacity(0.15)
                        : _brand.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FaIcon(
                    widget.icon,
                    size: 14,
                    color: widget.filled ? AppColors.white : _brand,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: widget.filled
                        ? AppColors.white
                        : _brand.withOpacity(_hovering ? 1.0 : 0.85),
                    letterSpacing: 0.3,
                  ),
                ),
                if (widget.filled) ...[
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: _hovering ? 20 : 0,
                    child: _hovering
                        ? const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(Icons.arrow_forward_rounded,
                                size: 15, color: AppColors.white),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
