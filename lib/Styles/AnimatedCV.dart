import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedIconButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomElevatedIconButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      iconAlignment: IconAlignment.start,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        minimumSize: const Size(150, 40),
        side: BorderSide(
          color: Colors.blue.shade100,
          width: 2,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      icon: Transform.translate(
        offset: const Offset(-4, 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade500,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
      onPressed: onPressed,
      label: Transform.translate(
        offset: const Offset(-8, 0),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
