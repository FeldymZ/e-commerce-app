import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/nav_bar.dart';
import 'package:e_commerce/screens/homme_page.dart';
import 'package:e_commerce/welcome.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User? user;
  bool isPhoneVerified = false;
  String? selectedGender;
  XFile? imageFile;
  String phoneNumber = "";
  String imageUrl = "";
  final _phoneController = TextEditingController();
  PhoneNumber? initialNumber;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  // Callback pour le champ InternationalPhoneNumberInput
  void onPhoneNumberChanged(PhoneNumber number) {
    setState(() {
      phoneNumber = number.phoneNumber ?? "";
    });
  }

  Future<void> requestPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final storagePermission = await Permission.storage.request();

    if (!cameraPermission.isGranted || !storagePermission.isGranted) {
      Fluttertoast.showToast(
          msg:
              'Les permissions sont nécessaires pour utiliser cette fonctionnalité');
    }
  }

  // Fonction pour prendre une photo et la charger sur Firebase Storage
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = pickedImage;
      });
      Fluttertoast.showToast(msg: 'Image sélectionnée');

      try {
        // Créer la référence dans Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_pics/${user!.uid}.jpg');

        // Lancer l'upload du fichier
        final uploadTask = storageRef.putFile(File(pickedImage.path));

        // Attendre la fin de l'upload
        final snapshot = await uploadTask.whenComplete(() {});

        // Vérifier que l'upload a réussi
        if (snapshot.state == TaskState.success) {
          imageUrl = await storageRef.getDownloadURL();
          Fluttertoast.showToast(msg: 'Image uploadée avec succès');
        } else {
          Fluttertoast.showToast(msg: 'Échec de l\'upload de l\'image');
        }
      } catch (e) {
        Fluttertoast.showToast(msg: 'Erreur lors de l\'upload: $e');
      }
    }
  }

  // Fonction pour envoyer un OTP pour vérifier le numéro
  Future<void> verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // Traitement de la vérification automatique
      },
      verificationFailed: (FirebaseAuthException e) {
        Fluttertoast.showToast(msg: 'Erreur de vérification: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Ici, demande à l'utilisateur de saisir le code OTP
        // Pour l'instant, on utilise une chaîne vide pour l'exemple
        String smsCode = "";
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);
        FirebaseAuth.instance.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // Fonction pour vérifier si l'utilisateur a déjà configuré son profil
  Future<void> checkProfileCompletion() async {
    if (user != null) {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(user!.uid);
      final userData = await userDoc.get();
      if (!userData.exists || userData['phoneVerified'] == false) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile Setup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              children: [
                imageFile == null
                    ? CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.grey,
                        child: IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () async {
                            await requestPermissions();
                            pickImage();
                          },
                        ),
                      )
                    : CircleAvatar(
                        radius: 80,
                        backgroundImage: FileImage(File(imageFile!.path)),
                      ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: pickImage,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.edit, size: 18, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            InternationalPhoneNumberInput(
              onInputChanged: onPhoneNumberChanged,
              initialValue: initialNumber,
              textFieldController: _phoneController,
              formatInput: true,
              inputDecoration: InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
              selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.DIALOG,
                  showFlags: false),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedGender,
              decoration: InputDecoration(
                hintText: "Gender",
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
              items: [
                "Male",
                "Female",
              ].map((String gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGender = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Enregistrer les informations de profil dans Firestore
                final userDoc = FirebaseFirestore.instance
                    .collection('users')
                    .doc(user!.uid);
                await userDoc.set({
                  'imageUrl': imageUrl,
                  'phoneNumber': phoneNumber,
                  'gender': selectedGender,
                  'phoneVerified': isPhoneVerified,
                });

                Fluttertoast.showToast(msg: 'Profil mis à jour avec succès!');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CustomNavBar()),
                );
              },
              child: Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
