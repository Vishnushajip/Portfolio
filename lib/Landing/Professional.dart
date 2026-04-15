import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vishnup/core/theme/app_colors.dart';

class ProfessionalDetails extends StatelessWidget {
  const ProfessionalDetails({super.key});

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  void _sendEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final socials = [
      _SocialData(
        icon: FontAwesomeIcons.github,
        label: "GitHub",
        handle: "@Vishnushajip",
        gradient: const [Color(0xFF24292E), Color(0xFF404448)],
        onTap: () => _launchURL("https://github.com/Vishnushajip"),
      ),
      _SocialData(
        icon: FontAwesomeIcons.linkedin,
        label: "LinkedIn",
        handle: "vishnu-p",
        gradient: const [Color(0xFF0077B5), Color(0xFF00A0DC)],
        onTap: () => _launchURL(
            "https://www.linkedin.com/in/vishnu-p-43b588240?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app"),
      ),
      _SocialData(
        icon: FontAwesomeIcons.instagram,
        label: "Instagram",
        handle: "@_v1s_hnu",
        gradient: const [Color(0xFFE1306C), Color(0xFFF77737)],
        onTap: () => _launchURL(
            "https://www.instagram.com/_v1s_hnu/profilecard/?igsh=MXFndGsyNzd0azYwbQ=="),
      ),
      _SocialData(
        icon: Icons.email_rounded,
        label: "Gmail",
        handle: "vishnup.contact",
        gradient: const [Color(0xFFEA4335), Color(0xFFFBBC04)],
        onTap: () => _sendEmail("vishnup.contact@gmail.com"),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return Column(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 18,
                    height: 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.secondary],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Find me on",
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
              children: socials
                  .map((s) => _SocialCard(data: s, isMobile: isMobile))
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}

class _SocialData {
  final IconData icon;
  final String label;
  final String handle;
  final List<Color> gradient;
  final VoidCallback onTap;

  const _SocialData({
    required this.icon,
    required this.label,
    required this.handle,
    required this.gradient,
    required this.onTap,
  });
}

class _SocialCard extends StatefulWidget {
  final _SocialData data;
  final bool isMobile;

  const _SocialCard({required this.data, required this.isMobile});

  @override
  State<_SocialCard> createState() => _SocialCardState();
}

class _SocialCardState extends State<_SocialCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnter() {
    setState(() => _hovered = true);
    _controller.forward();
  }

  void _onExit() {
    setState(() => _hovered = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onEnter(),
      onExit: (_) => _onExit(),
      child: GestureDetector(
        onTap: widget.data.onTap,
        child: ScaleTransition(
          scale: _scaleAnim,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.isMobile ? 150 : 160,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: _hovered ? AppColors.accent : AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _hovered
                    ? widget.data.gradient.first.withOpacity(0.55)
                    : AppColors.accent,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: _hovered
                      ? widget.data.gradient.first.withOpacity(0.22)
                      : AppColors.primary.withOpacity(0.06),
                  blurRadius: _hovered ? 20 : 8,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: _hovered
                        ? LinearGradient(
                            colors: widget.data.gradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [
                              widget.data.gradient.first.withOpacity(0.15),
                              widget.data.gradient.last.withOpacity(0.15),
                            ],
                          ),
                    boxShadow: _hovered
                        ? [
                            BoxShadow(
                              color:
                                  widget.data.gradient.first.withOpacity(0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : [],
                  ),
                  child: Icon(
                    widget.data.icon,
                    size: 17,
                    color:
                        _hovered ? AppColors.white : widget.data.gradient.first,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.data.label,
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        widget.data.handle,
                        style: GoogleFonts.dmSans(
                          fontSize: 10.5,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
