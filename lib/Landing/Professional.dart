import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfessionalDetails extends StatelessWidget {
  const ProfessionalDetails({super.key});

  void launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print('Could not launch $url');
    }
  }

  void sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Could not launch $emailUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment:
                isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment:
                    isMobile ? WrapAlignment.center : WrapAlignment.start,
                children: [
                  SocialIconButton(
                    icon: FontAwesomeIcons.github,
                    color: const Color(0xFF181717),
                    label: "GitHub",
                    onPressed: () {
                      launchURL("https://github.com/Vishnushajip");
                    },
                  ),
                  SocialIconButton(
                    icon: FontAwesomeIcons.linkedin,
                    color: const Color(0xFF0077B5),
                    label: "LinkedIn",
                    onPressed: () {
                      launchURL(
                          "https://www.linkedin.com/in/vishnu-p-43b588240?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app");
                    },
                  ),
                  SocialIconButton(
                    icon: FontAwesomeIcons.instagram,
                    color: const Color.fromARGB(255, 205, 56, 106),
                    label: "Instagram",
                    onPressed: () {
                      launchURL(
                          "https://www.instagram.com/_v1s_hnu/profilecard/?igsh=MXFndGsyNzd0azYwbQ==");
                    },
                  ),
                  SocialIconButton(
                    icon: Icons.email,
                    color: const Color.fromARGB(255, 218, 72, 72),
                    label: "Gmail",
                    onPressed: () {
                      sendEmail("vishnup.contact@gmail.com");
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

class SocialIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onPressed;

  const SocialIconButton({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: IconButton(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(icon, size: 40, color: color),
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
