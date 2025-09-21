import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vishnup/Landing/About.dart';
import 'package:vishnup/Styles/Name_AlertLog.dart';
import '../Styles/Nameprovider.dart';
import 'PhotoSection.dart';
import 'Projects.dart';

class PortfolioPage extends ConsumerStatefulWidget {
  const PortfolioPage({super.key});

  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends ConsumerState<PortfolioPage> {
  @override
  void initState() {
    super.initState();
    _checkForSavedName(context, ref);
  }

  Future<void> _checkForSavedName(BuildContext context, WidgetRef ref) async {
    String? savedName = await NameStorage.getSavedName();

    if (savedName == null || savedName.isEmpty) {
      AlertLog.show(context, ref);
    } else {
      showLongToast(context, "Welcome back $savedName!");
      await Future.delayed(const Duration(milliseconds: 4000));
      showLongToast(context, "Enjoy your time here!");
    }
  }

  void showLongToast(BuildContext context, String message) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: MediaQuery.of(context).size.width * 0.2,
        right: MediaQuery.of(context).size.width * 0.2,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.aBeeZee(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(Icons.sentiment_satisfied_alt, color: Colors.black)
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(const Duration(milliseconds: 3500), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final name = ref.watch(nameStorageProvider);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (name == null && name!.isEmpty) AlertLog.show(context, ref);
      },
      onPanDown: (_) {
        if (name == null && name!.isEmpty) AlertLog.show(context, ref);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Port",
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "folio",
                  style: GoogleFonts.montserrat(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const HeroSection(),
              const AboutContent(),
              const SizedBox(height: 20),
              const KealthyPortfolioPage(
                
              ),
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      FontAwesomeIcons.envelope,
                      color: Colors.blue,
                      size: 18,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "vishnup.contact@gmail.com",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
