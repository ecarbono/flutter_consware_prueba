import 'package:flutter/material.dart';

class ProviderOnboardin with ChangeNotifier {
  final List<String> onboardingImages = [
    'assets/onboarding/Rectangle_3.png',
    'assets/onboarding/Img_onboarding_2.png',
  ];
  int pageChange = 0;
  String _textOnboarding =
      "Accede a créditos con un solo toque y sin complicaciones.";
  String get gettextOnboarding => _textOnboarding;
  int get getpageChange => pageChange;
  List<String> get getonboardingImages => onboardingImages;
  set settextOnboarding(value) => _textOnboarding = value;
  set setpageChange(value) => pageChange = value;
  changeText({required int index}) {
    switch (index) {
      case 0:
        settextOnboarding =
            "Accede a créditos con un solo toque y sin complicaciones.";
        break;
      case 1:
        settextOnboarding =
            "Toma el control de tus finanzas con confianza y accede a ellas sin restricciones.";
        break;
      default:
    }
    notifyListeners();
  }
}
