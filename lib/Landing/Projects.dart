import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vishnup/core/theme/app_colors.dart';

class KealthyPortfolioPage extends StatefulWidget {
  const KealthyPortfolioPage({super.key});

  @override
  State<KealthyPortfolioPage> createState() => _KealthyPortfolioPageState();
}

class _KealthyPortfolioPageState extends State<KealthyPortfolioPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _headerCtrl;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;

  static const List<Map<String, dynamic>> _projects = [
    {
      'title': 'Kealthy',
      'subtitle': 'Food & Grocery',
      'description':
          'E-commerce platform with multiple apps for customers and delivery partners. Managed full-cycle development and deployment.',
      'tech': ['Flutter', 'Firebase', 'Node.js', 'Razorpay'],
      'playStore':
          'https://play.google.com/store/apps/details?id=com.COTOLORE.Kealthy&pcampaignid=web_share',
      'url': null,
      'index': '01',
    },
    {
      'title': 'Ybes',
      'subtitle': 'Loyalty Platform',
      'description':
          'WhatsApp automation dashboard built with Flutter Web. Integrated Meta WhatsApp Business API for bulk campaigns.',
      'tech': ['Flutter Web', 'Node.js', 'AWS', 'Meta API'],
      'url': 'https://ybes.app/',
      'playStore': null,
      'index': '02',
    },
    {
      'title': 'Dreams Land',
      'subtitle': 'Realty Ecosystem',
      'description':
          'Real estate ecosystem featuring property listings and agent tracking with real-time Firebase synchronization.',
      'tech': ['Flutter', 'Firebase', 'Maps API', 'Node.js'],
      'url': 'https://www.dreamslandrealty.com/',
      'playStore': null,
      'index': '03',
    },
    {
      'title': 'Resume',
      'subtitle': 'AI Resume Builder',
      'description':
          'ATS-friendly CV generator with dynamic template processing and AI-powered content generation.',
      'tech': ['Flutter', 'Nest.js', 'Firebase', 'AI Integrations'],
      'url': 'https://www.resumeachieve.com/',
      'playStore': null,
      'index': '04',
    },
  ];

  @override
  void initState() {
    super.initState();
    _headerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _headerFade = CurvedAnimation(parent: _headerCtrl, curve: Curves.easeOut);
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _headerCtrl, curve: Curves.easeOutCubic));
    _headerCtrl.forward();
  }

  @override
  void dispose() {
    _headerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 600;
        final bool isTablet = constraints.maxWidth < 1000;

        final double hPad = isMobile ? 20 : (isTablet ? 32 : 72);

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 56),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeTransition(
                  opacity: _headerFade,
                  child: SlideTransition(
                    position: _headerSlide,
                    child: _SectionHeader(isMobile: isMobile),
                  ),
                ),
                const SizedBox(height: 48),
                _buildGrid(isMobile: isMobile, isTablet: isTablet),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGrid({required bool isMobile, required bool isTablet}) {
    final int crossCount = isMobile ? 1 : 2;

    if (isMobile) {
      return Column(
        children: List.generate(_projects.length, (i) {
          final p = _projects[i];
          return Padding(
            padding: EdgeInsets.only(bottom: i < _projects.length - 1 ? 20 : 0),
            child: _AnimatedCard(
              delay: Duration(milliseconds: 100 + i * 80),
              child: _ProjectCard(
                title: p['title'] as String,
                subtitle: p['subtitle'] as String,
                description: p['description'] as String,
                tech: p['tech'] as List<String>,
                url: p['url'] as String?,
                playStore: p['playStore'] as String?,
                cardIndex: p['index'] as String,
              ),
            ),
          );
        }),
      );
    }

    final rows = (_projects.length / crossCount).ceil();
    return Column(
      children: List.generate(rows, (row) {
        final start = row * crossCount;
        final end = (start + crossCount).clamp(0, _projects.length);
        final rowProjects = _projects.sublist(start, end);

        return Padding(
          padding: EdgeInsets.only(bottom: row < rows - 1 ? 24 : 0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(rowProjects.length * 2 - 1, (i) {
                if (i.isOdd) return const SizedBox(width: 24);
                final p = rowProjects[i ~/ 2];
                final globalIndex = start + (i ~/ 2);
                return Expanded(
                  child: _AnimatedCard(
                    delay: Duration(milliseconds: 100 + globalIndex * 80),
                    child: _ProjectCard(
                      title: p['title'] as String,
                      subtitle: p['subtitle'] as String,
                      description: p['description'] as String,
                      tech: p['tech'] as List<String>,
                      url: p['url'] as String?,
                      playStore: p['playStore'] as String?,
                      cardIndex: p['index'] as String,
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      }),
    );
  }
}

class _AnimatedCard extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const _AnimatedCard({required this.child, required this.delay});

  @override
  State<_AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<_AnimatedCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final bool isMobile;
  const _SectionHeader({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 28,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'PORTFOLIO',
              style: GoogleFonts.syne(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                letterSpacing: 4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'Featured\nProjects',
          style: GoogleFonts.syne(
            fontSize: isMobile ? 36 : 52,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            height: 1.05,
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: isMobile ? double.infinity : 380,
          child: Text(
            'A selection of products I\'ve built end-to-end — from architecture to deployment.',
            style: GoogleFonts.nunito(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
              height: 1.65,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String description;
  final List<String> tech;
  final String? url;
  final String? playStore;
  final String cardIndex;

  const _ProjectCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.tech,
    this.url,
    this.playStore,
    required this.cardIndex,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late final AnimationController _ctrl;
  late final Animation<double> _accent;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    _accent = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onEnter(_) {
    setState(() => _hovered = true);
    _ctrl.forward();
  }

  void _onExit(_) {
    setState(() => _hovered = false);
    _ctrl.reverse();
  }

  Future<void> _launch(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0)
              ..scale(_hovered ? 1.008 : 1.0),
            transformAlignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: Color.lerp(
                  const Color(0xFFE2E2E2),
                  AppColors.primary,
                  _accent.value * 0.55,
                )!,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(
                    0.04 + _accent.value * 0.1,
                  ),
                  blurRadius: 8 + _accent.value * 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: child,
          );
        },
        child: Stack(
          children: [
            Positioned(
              right: 18,
              bottom: 14,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 260),
                style: GoogleFonts.syne(
                  fontSize: 78,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary.withOpacity(
                    _hovered ? 0.08 : 0.045,
                  ),
                  height: 1,
                ),
                child: Text(widget.cardIndex),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CardIcon(hovered: _hovered),
                      _LinkButtons(
                        playStore: widget.playStore,
                        url: widget.url,
                        launch: _launch,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.title,
                    style: GoogleFonts.syne(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    widget.subtitle,
                    style: GoogleFonts.nunito(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.description,
                    style: GoogleFonts.nunito(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _TechBadges(tech: widget.tech, hovered: _hovered),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardIcon extends StatelessWidget {
  final bool hovered;
  const _CardIcon({required this.hovered});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color:
            hovered ? AppColors.primary : AppColors.primary.withOpacity(0.09),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.terminal_rounded,
        color: hovered ? AppColors.white : AppColors.primary,
        size: 20,
      ),
    );
  }
}

class _LinkButtons extends StatelessWidget {
  final String? playStore;
  final String? url;
  final Future<void> Function(String?) launch;

  const _LinkButtons({
    required this.playStore,
    required this.url,
    required this.launch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (playStore != null)
          _IconBtn(
            icon: Icons.storefront_rounded,
            tooltip: 'Play Store',
            onTap: () => launch(playStore),
          ),
        if (url != null) ...[
          if (playStore != null) const SizedBox(width: 6),
          _IconBtn(
            icon: Icons.north_east_rounded,
            tooltip: 'Visit Site',
            onTap: () => launch(url),
          ),
        ],
      ],
    );
  }
}

class _IconBtn extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _IconBtn({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_IconBtn> createState() => _IconBtnState();
}

class _IconBtnState extends State<_IconBtn> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _h = true),
        onExit: (_) => setState(() => _h = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: _h ? AppColors.primary : const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: _h ? AppColors.primary : const Color(0xFFE2E2E2),
                width: 1,
              ),
            ),
            child: Icon(
              widget.icon,
              size: 15,
              color: _h ? AppColors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _TechBadges extends StatelessWidget {
  final List<String> tech;
  final bool hovered;

  const _TechBadges({required this.tech, required this.hovered});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 7,
      runSpacing: 7,
      children: tech
          .map(
            (t) => AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: hovered
                    ? AppColors.primary.withOpacity(0.12)
                    : AppColors.primary.withOpacity(0.07),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                t,
                style: GoogleFonts.nunito(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
