import 'package:e_commerce/screens/homme_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;

  final List<IconData> _icons = [
    IconsaxPlusLinear.home_2,
    IconsaxPlusLinear.bag_2,
    IconsaxPlusLinear.heart,
    IconsaxPlusLinear.message,
    IconsaxPlusLinear.user,
  ];

  final List<IconData> _iconss = [
    IconsaxPlusBold.home_2,
    IconsaxPlusBold.bag_2,
    IconsaxPlusBold.heart,
    IconsaxPlusBold.message,
    IconsaxPlusBold.user,
  ];

  // Liste des pages à afficher
  final List<Widget> _pages = [
    HommePage(),
    BagPage(),
    HeartPage(),
    MessagePage(),
    UserPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[
          _selectedIndex], // Affiche la page correspondant à l'index sélectionné
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_icons.length, (index) {
            bool isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.white : Colors.transparent,
                ),
                child: Icon(
                  isSelected ? _iconss[index] : _icons[index],
                  size: 27,
                  color: isSelected ? const Color(0xff064635) : Colors.white,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// Exemple de pages

class BagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Text('TEXT'),
        ),
      ],
    );
  }
}

class HeartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Page du Coeur"));
  }
}

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Page des Messages"));
  }
}

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Page de l'Utilisateur"));
  }
}
