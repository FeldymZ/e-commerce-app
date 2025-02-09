import 'package:e_commerce/create_account.dart';
import 'package:e_commerce/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  // Validation de l'email
  bool isValidEmail(String email) {
    RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(email);
  }

  // Validation du mot de passe
  bool isValidPassword(String password) {
    return password.length >= 6;
  }

  // Connexion avec email et mot de passe
  Future<void> signInWithEmail() async {
    if (!isValidEmail(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email invalide")),
      );
      return;
    }
    if (!isValidPassword(passwordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Le mot de passe doit avoir au moins 6 caractères")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Si la connexion réussie, redirection vers une autre page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ProfilePage()), // Page d'accueil après connexion
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Connexion réussie !")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Connexion avec Google
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return; // L'utilisateur a annulé la connexion

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Afficher un message de succès et rediriger l'utilisateur
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Connexion réussie avec Google !")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage()), // Page d'accueil après connexion
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: ListView(
          children: [
            SizedBox(height: 120.h),
            Center(
              child: Text(
                'Sign In',
                style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1),
              ),
            ),
            Center(
              child: Text("Hi! Welcome back, you've been missed"),
            ),
            SizedBox(height: 70.h),
            Text(
              'Email',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[150],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
              cursorColor: Color(0xff3c5a5d),
            ),
            SizedBox(height: 20),
            Text(
              'Password',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[150],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
              cursorColor: Color(0xff3c5a5d),
            ),
            SizedBox(height: 10.h),
            Text(
              'Forgot Password?',
              style: TextStyle(
                  color: Colors.blue,
                  letterSpacing: -0.5,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
              textAlign: TextAlign.end,
            ),
            SizedBox(height: 20),
            Center(
                child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : signInWithEmail, // Désactiver pendant le chargement
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff3c5a5d),
                      padding: EdgeInsets.symmetric(
                          horizontal: 145.w, vertical: 15.h),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ))),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Or sign in with",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        )),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      child: Image.asset(
                        'assets/img/apple.png',
                        width: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: signInWithGoogle,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          )),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        child: Image.asset(
                          'assets/img/google.png',
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        )),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      child: Image.asset(
                        'assets/img/facebook.png',
                        width: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff3c5a5d),
                  ),
                  children: [
                    TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: ' ',
                    ),
                    WidgetSpan(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAccount()),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xff3c5a5d),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(child: Text("Bienvenue dans l'application !")),
    );
  }
}
