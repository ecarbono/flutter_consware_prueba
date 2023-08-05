import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_consware_prueba/presentation/screens/login/login.user.dart';
import 'package:flutter_consware_prueba/presentation/screens/register/register.dart';
import 'package:flutter_consware_prueba/providers/onboarding/provider_onboardin.dart';
import 'package:flutter_consware_prueba/styles/styles_onboarding.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerRead = context.watch<ProviderOnboardin>();
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 10.0,
                  blurRadius: 20.0,
                  offset: const Offset(
                    20,
                    10,
                  ), // Controla la posición de la sombra en x e y
                ),
              ],
            ),
            child: CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                autoPlay: true,
                viewportFraction: 1,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  providerRead.changeText(index: index);
                },
              ),
              items: providerRead.getonboardingImages.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        image,
                        fit: BoxFit.fitWidth,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 200, left: 20, right: 20),
            child: Text(
              providerRead.gettextOnboarding,
              style: txtStyle,
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.only(bottom: 110, left: 16, right: 16),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(colorBtnIngresar),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const LoginScreenUser(),
                  ),
                );
              },
              child: Text(
                'Ingresar',
                style: txtStyle.copyWith(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.only(bottom: 50, left: 16, right: 16),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(colorBtnRegister),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const RegistroScreen(),
                  ),
                );
              },
              child: Text(
                'Registrar',
                style: txtStyle.copyWith(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
