import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final nameProvider = StateProvider<String>((ref) => '');
final isLoadingProvider = StateProvider<bool>((ref) => false);
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

class NameStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(),
    webOptions: WebOptions(
      dbName: 'flutter_secure_storage',
    ),
  );
  static Future<void> saveName(String name) async {
    await _storage.write(key: 'saved_name', value: name);
  }

  static Future<String?> getSavedName() async {
    return await _storage.read(key: 'saved_name');
  }
}

class AlertLog {
  static Future<void> show(BuildContext context, WidgetRef ref) async {
    TextEditingController nameController = TextEditingController();
    bool isSaving = false;

    showDialog(
      barrierColor: Colors.black45,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Center(
                child: Text(
                  "Welcome",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              content: TextField(
                style:
                    GoogleFonts.montserrat(fontSize: 12, color: Colors.black),
                controller: nameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Your Name",
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              actions: [
                Center(
                  child: isSaving
                      ? LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.blue, size: 20)
                      : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () async {
                          String name = nameController.text.trim();
                          if (name.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Please enter your name",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.NONE,
                            );
                            return;
                          }
                      
                          setState(() => isSaving = true);
                          ref.read(isLoadingProvider.notifier).state = true;
                      
                          await ref
                              .read(firestoreProvider)
                              .collection('logged_users')
                              .add({
                            'name': name,
                            'timestamp': FieldValue.serverTimestamp(),
                          });
                      
                          await NameStorage.saveName(name);
                      
                          ref.read(nameProvider.notifier).state = name;
                          ref.read(isLoadingProvider.notifier).state =
                              false;
                      
                          Fluttertoast.showToast(
                            msg: "Saved successfully!",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.NONE,
                          );
                      
                          if (context.mounted) Navigator.pop(context);
                        },
                        child: Text("Okay",
                            style:
                                GoogleFonts.poppins(color: Colors.white)),
                      ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
