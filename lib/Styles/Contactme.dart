import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactUtils {
  static void showContactAlert(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          children: [
            if (isMobile) const SizedBox.shrink(),
            const Icon(
              CupertinoIcons.envelope_fill,
              color: Colors.green,
              size: 30,
            ),
             Text(
              "Contact Options",
              style: GoogleFonts.poppins(color: Colors.black,),
            ),
          ],
        ),
        content:  Text(
          "Choose an option to contact me.",
          style: GoogleFonts.poppins(color: Colors.black,),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => _launchWhatsApp("+917994689802"),
            icon: const Icon(FontAwesomeIcons.whatsapp, color: Colors.green),
            label: isMobile
                ? const SizedBox.shrink()
                :  Text(
                    "WhatsApp",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                    ),
                  ),
          ),
          TextButton.icon(
            onPressed: () => _launchGmail("vishnup.contact@gmail.com"),
            icon: const Icon(Icons.email, color: Colors.red),
            label: isMobile
                ? const SizedBox.shrink()
                :  Text(
                    "Gmail",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                    ),
                  ),
          ),
          TextButton.icon(
            onPressed: () => _makePhoneCall("+917994689802"),
            icon: const Icon(Icons.phone, color: Colors.blue),
            label: isMobile
                ? const SizedBox.shrink()
                :  Text(
                    "Call",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  static Future<void> _launchWhatsApp(String phoneNumber) async {
    final whatsappUrl = "https://wa.me/$phoneNumber";
    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      debugPrint("Could not launch WhatsApp");
    }
  }

  static Future<void> _launchGmail(String email) async {
    final mailUrl = "mailto:$email";
    if (await canLaunchUrl(Uri.parse(mailUrl))) {
      await launchUrl(Uri.parse(mailUrl));
    } else {
      debugPrint("Could not launch Gmail");
    }
  }

  static Future<void> _makePhoneCall(String phoneNumber) async {
    final callUrl = "tel:$phoneNumber";
    if (await canLaunchUrl(Uri.parse(callUrl))) {
      await launchUrl(Uri.parse(callUrl));
    } else {
      debugPrint("Could not make the phone call");
    }
  }
}
