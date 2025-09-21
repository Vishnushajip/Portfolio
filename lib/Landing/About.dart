import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class AboutContent extends StatelessWidget {
  const AboutContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final List<Map<String, String>> skills = [
      {
        "image": "https://cdn.worldvectorlogo.com/logos/flutter.svg",
        "text": "Flutter"
      },
      {
        "image": "https://cdn.worldvectorlogo.com/logos/nodejs-1.svg",
        "text": "Node.js"
      },
      {
        "image": "https://cdn.worldvectorlogo.com/logos/firebase-1.svg",
        "text": "Firebase"
      },
      {
        "image": "https://cdn.worldvectorlogo.com/logos/azure-2.svg",
        "text": "Azure"
      },
      {
        "image": "https://cdn.worldvectorlogo.com/logos/google-maps-logo-2020.svg",
        "text": "Maps"
      },
      {
        "image": "https://cdn.worldvectorlogo.com/logos/mongodb-icon-1.svg",
        "text": "MongoDB"
      },
      {
        "image":
            "https://cdn.worldvectorlogo.com/logos/visual-studio-code-1.svg",
        "text": "Vs Code"
      },
      {
        "image": "https://cdn.worldvectorlogo.com/logos/postman.svg",
        "text": "Postman"
      },
    ];

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedSlide(
                    duration: const Duration(seconds: 1),
                    offset: Offset.zero,
                    child: Text(
                      "My Tech Stack",
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: screenWidth > 800 ? 30 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Technologies I have been using recently",
                    style: GoogleFonts.montserrat(
                      fontSize: screenWidth > 800 ? 18 : 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              skillBox(skills),
            ],
          ),
        ),
      ],
    );
  }

  Widget skillBox(List<Map<String, String>> skills) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return Wrap(
          spacing: 50,
          runSpacing: 8,
          children: skills
              .map(
                (skill) => AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CachedNetworkImage(
                        imageUrl: skill["image"]!,
                        width: isMobile ? 50 : 100,
                        height: isMobile ? 50 : 100,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: isMobile ? 50 : 100,
                            height: isMobile ? 50 : 100,
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        skill["text"]!,
                        style: GoogleFonts.montserrat(
                          fontSize: isMobile ? 16 : 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
