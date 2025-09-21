import 'dart:html' as html;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vishnup/Landing/Experince.dart';
import '../Styles/AnimatedCV.dart';
import '../Styles/Contactme.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'AnimationText.dart';
import 'Professional.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

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
      print("Error downloading PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenWidth > 800 ? 50 : 20,
          horizontal: screenWidth > 800 ? 50 : 20,
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth > 600 ? 150 : 80,
                            height: screenWidth > 600 ? 150 : 80,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/me.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello👋, I'm",
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth > 800 ? 12 : 8,
                                    fontWeight: FontWeight.bold,
                                    decorationThickness: 5,
                                  ),
                                ),
                                Text(
                                  "Vishnu.P",
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth > 800 ? 35 : 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "And I'm a ",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: screenWidth > 800 ? 20 : 12,
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
                                        fontSize: screenWidth > 800 ? 20 : 12,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        textAlign: TextAlign.justify,
                        "Flutter Developer with 2 years of experience in building innovative and user friendly applications. I specialize in cross platform development using Flutter and also have backend experience with Node.js, allowing me to deliver fullstack solutions effectively.",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth > 800 ? 16 : 14,
                          height: 1.8,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const ProfessionalDetails(),
                      const SizedBox(height: 20),
                      screenWidth > 600
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomElevatedIconButton(
                                  label: "Download CV",
                                  icon: FontAwesomeIcons.download,
                                  onPressed: downloadPDF,
                                ),
                                const SizedBox(width: 10),
                                CustomElevatedIconButton(
                                  label: "Contact Now",
                                  icon: CupertinoIcons.chat_bubble_text,
                                  onPressed: () =>
                                      ContactUtils.showContactAlert(context),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomElevatedIconButton(
                                  label: "Download CV",
                                  icon: FontAwesomeIcons.download,
                                  onPressed: downloadPDF,
                                ),
                                const SizedBox(height: 10),
                                CustomElevatedIconButton(
                                  label: "Contact Now",
                                  icon: FontAwesomeIcons.message,
                                  onPressed: () =>
                                      ContactUtils.showContactAlert(context),
                                ),
                              ],
                            ),
                      const SizedBox(height: 20),
                      const ResponsiveExperiencePage()
                    ],
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
