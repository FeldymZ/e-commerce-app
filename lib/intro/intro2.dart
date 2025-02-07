import 'package:e_commerce/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intro2 extends StatefulWidget {
  const Intro2({super.key});

  @override
  State<Intro2> createState() => _Intro2State();
}

class _Intro2State extends State<Intro2> {
  PageController pageController = PageController();
  int currentPage = 0; // Variable pour suivre la page actuelle

  // Fonction pour changer la page en avant ou en arrière
  void changePage(int direction) {
    if (direction == 1 && currentPage < 2) {
      pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    } else if (direction == -1 && currentPage > 0) {
      pageController.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }

    // Rediriger vers la page suivante si on est à la dernière page
    if (currentPage == 2) {
      _navigateToNextPage();
    }
  }

  // Fonction pour naviguer vers une autre page
  void _navigateToNextPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              Welcome()), // Remplace NextPage() par ta page cible
    );
  }

  @override
  void initState() {
    super.initState();

    // Écouter le changement de page
    pageController.addListener(() {
      setState(() {
        currentPage =
            pageController.page!.toInt(); // Met à jour la page actuelle
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff8f8f8), // Fond bleu pour l'exemple
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: pageController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 200),
                        child: Center(
                          child: SizedBox(
                            height: 400,
                            width: 400,
                            child: Image.asset('assets/img/page1.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 200, top: 100),
                        child: Center(
                          child: SizedBox(
                            height: 600,
                            width: 600,
                            child: Image.asset(
                              'assets/img/page2.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 200),
                        child: Center(
                          child: SizedBox(
                            height: 500,
                            width: 500,
                            child: Image.asset(
                              'assets/img/page3.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 320),
              child: SizedBox(
                height: 500.h,
                width: double.infinity,
                child: ClipPath(
                  clipper: ClipHolder(),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 230,
                        ),
                        // Texte qui change en fonction de la page
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 23.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff3c5a5d),
                            ),
                            children: [
                              TextSpan(
                                text: currentPage == 0
                                    ? 'Seamless'
                                    : currentPage == 1
                                        ? 'Enjoy the'
                                        : 'Start your',
                                style: TextStyle(fontSize: 23.sp),
                              ),
                              TextSpan(
                                text: currentPage == 0
                                    ? ' Shopping\nExperience'
                                    : currentPage == 1
                                        ? ' Shopping\nJourney'
                                        : ' Shopping\nAdventure',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit. Proin diam felis, ultricies non quam non',
                          style: TextStyle(
                              fontSize: 12.sp, color: Color(0xff3c5a5d)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Stack(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 17.0),
                                child: SmoothPageIndicator(
                                  controller: pageController,
                                  count: 3,
                                  effect: const ScrollingDotsEffect(
                                    spacing: 10.5,
                                    activeDotColor: Color(0xff3c5a5d),
                                    dotColor:
                                        Color.fromARGB(255, 179, 179, 179),
                                    activeDotScale: 1.3,
                                    dotWidth: 10.0,
                                    dotHeight: 10.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Row(
                                children: [
                                  // Bouton gauche (apparaît seulement à partir de la 2e page et jusqu'à la 3e)
                                  if (currentPage >= 1)
                                    Container(
                                      height: 40.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Color(0xff3c5a5d),
                                            width: 1,
                                          )),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.arrow_back_rounded,
                                          color: Color(0xff3c5a5d),
                                          size: 20.sp,
                                        ),
                                        onPressed: () {
                                          changePage(-1); // Reculer d'une page
                                        },
                                      ),
                                    ),
                                  // Spacer pour occuper l'espace avant l'indicateur
                                  if (currentPage >= 0) Spacer(),

                                  if (currentPage < 2) Spacer(),
                                  // Bouton droite pour avancer
                                  CircleAvatar(
                                    radius: 20.sp,
                                    backgroundColor: Color(0xff3c5a5d),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                        size: 20.sp,
                                      ),
                                      onPressed: () {
                                        changePage(
                                            1); // Passer à la page suivante
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class ClipHolder extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.3); // Point de départ (gauche)

    // Courbe en V inversé (descend au milieu et remonte)
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.5, size.width, size.height * 0.3);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nouvelle Page')),
      body: Center(child: Text('Bienvenue sur la nouvelle page!')),
    );
  }
}
