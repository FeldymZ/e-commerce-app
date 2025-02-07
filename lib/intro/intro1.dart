import 'package:e_commerce/intro/intro2.dart';
import 'package:e_commerce/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Intro1 extends StatefulWidget {
  const Intro1({super.key});

  @override
  State<Intro1> createState() => _Intro1State();
}

class _Intro1State extends State<Intro1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Center(
                  child: ClipOval(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        //Image en ellipse
                        SizedBox(
                          width: 240.w, // Ajuste la largeur comme tu veux
                          height: 350.h, // Ajuste la hauteur comme tu veux
                          child: ClipOval(
                            child: Image.asset('assets/img/A.jpeg',
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 390.h,
                  left: 230.w,
                  child: GestureDetector(
                    onTap: () {
                      // Redirection vers la page de connexion
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Intro2()),
                      );
                    },
                    child: CircleAvatar(
                      radius: 25.h,
                      backgroundColor: Color(0xff3c5a5d),
                      child: Icon(
                        Icons.arrow_outward_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 55.0),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff3c5a5d),
                    ),
                    children: [
                      TextSpan(
                          text: 'The Furniture App',
                          style: TextStyle(fontSize: 23.sp)),
                      TextSpan(
                        text: ' That\nElevates Your Home',
                        style: TextStyle(color: Colors.black),
                      ),
                    ]),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit. Proin diam felis, ultricies non quam non',
            style: TextStyle(fontSize: 12.sp, color: Color(0xff3c5a5d)),
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            onTap: () {
              // Redirection vers la page de connexion
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Intro2()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Container(
                height: 50.h,
                width: 10.w,
                decoration: BoxDecoration(
                  color: Color(0xff3c5a5d),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Center(
                  child: Text("Let's Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
            ),
          ),
          SizedBox(height: 27.h),
          Center(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Color(0xff3c5a5d),
                ),
                children: [
                  TextSpan(
                    text: 'Already have an account?',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: ' ',
                  ),
                  WidgetSpan(
                    child: InkWell(
                      onTap: () {
                        // Redirection vers la page de connexion
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Welcome()),
                        );
                      },
                      child: Text(
                        'Sign In',
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
    );
  }
}
