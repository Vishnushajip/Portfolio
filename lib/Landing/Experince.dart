import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResponsiveExperiencePage extends StatelessWidget {
  const ResponsiveExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return (Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 50 : 20,
        vertical: isDesktop ? 50 : 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "2+ ",
                  style: GoogleFonts.montserrat(
                    fontSize: isDesktop ? 35 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                TextSpan(
                  text: "Years of\n Experience",
                  style: GoogleFonts.poppins(
                    fontSize: isDesktop ? 15 : 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: isDesktop ? 20 : 10),
          Container(
            width: 2,
            height: isDesktop ? 50 : 30,
            color: Colors.grey,
          ),
          SizedBox(width: isDesktop ? 20 : 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "6+ ",
                  style: GoogleFonts.montserrat(
                    fontSize: isDesktop ? 35 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                TextSpan(
                  text: "Projects\nCompleted",
                  style: GoogleFonts.poppins(
                    fontSize: isDesktop ? 15 : 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: isDesktop ? 20 : 10),
          Container(
            width: 2,
            height: isDesktop ? 50 : 30,
            color: Colors.grey,
          ),
          SizedBox(width: isDesktop ? 20 : 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "2+ ",
                  style: GoogleFonts.montserrat(
                    fontSize: isDesktop ? 35 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                TextSpan(
                  text: "Technologies\nMastered",
                  style: GoogleFonts.poppins(
                    fontSize: isDesktop ? 15 : 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
