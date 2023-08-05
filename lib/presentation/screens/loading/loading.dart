import 'package:flutter/material.dart';
import 'package:flutter_consware_prueba/styles/styles_onboarding.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/loading/spinner.png',
              width: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Simulando Crédito',
              style: txtStyle.copyWith(
                color: colorBtnRegister,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
