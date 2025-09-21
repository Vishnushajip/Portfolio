import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class KealthyPortfolioPage extends StatelessWidget {
  const KealthyPortfolioPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;

        return isMobile
            ? _buildColumnLayout(context)
            : _buildRowLayout(context);
      },
    );
  }

  Widget _buildColumnLayout(context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Projects",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: screenWidth > 800 ? 30 : 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        const ProjectWidget(
          imagePath: 'assets/kealthy.png',
          projectName: 'Kealthy: Healthy Food & Grocery',
          url:
              'https://play.google.com/store/apps/details?id=com.COTOLORE.Kealthy&pcampaignid=web_share',
          buttonText: 'View in Google Play',
        ),
        const SizedBox(height: 20),
        const ProjectWidget(
          imagePath: 'assets/delivery.png',
          projectName: 'Kealthy Delivery',
          url: '',
          buttonText: 'Url Not Available',
        ),
        const SizedBox(height: 20),
        const ProjectWidget(
          imagePath: 'assets/Logo.jpg',
          projectName: 'Dreams Land Realty',
          url: 'https://dreamslandrealty.com/',
          buttonText: 'Dream Land Realty',
        ),
      ],
    );
  }

  Widget _buildRowLayout(context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "Projects",
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: screenWidth > 800 ? 30 : 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ProjectWidget(
                imagePath: 'assets/kealthy.png',
                projectName: 'Kealthy',
                url:
                    'https://play.google.com/store/apps/details?id=com.COTOLORE.Kealthy&pcampaignid=web_share',
                buttonText: 'View in Google Play',
              ),
              SizedBox(width: 30),
              ProjectWidget(
                imagePath: 'assets/delivery.png',
                projectName: 'Kealthy Delivery',
                url: '',
                buttonText: 'Url Not Available',
              ),
              SizedBox(width: 30),
              ProjectWidget(
                imagePath: 'assets/Logo.jpg',
                projectName: 'Dreams Land Realty',
                url: 'https://dreamslandrealty.com/',
                buttonText: 'Dream Land Realty',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProjectWidget extends StatelessWidget {
  final String imagePath;
  final String projectName;
  final String? url;
  final String buttonText;

  const ProjectWidget({
    super.key,
    required this.imagePath,
    required this.projectName,
    this.url,
    required this.buttonText,
  });

  void _launchURL() async {
    if (url != null && await canLaunch(url!)) {
      await launch(url!);
    } else {
      debugPrint('Could not launch URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: isMobile ? 75 : 100,
                height: isMobile ? 75 : 100,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              Text(
                projectName,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 14 : 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              if (url != null)
                GestureDetector(
                  onTap: _launchURL,
                  child: Text(
                    buttonText,
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 10 : 14,
                      color: Colors.blue,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
