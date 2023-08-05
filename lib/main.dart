import 'package:flutter/material.dart';
import 'package:flutter_consware_prueba/presentation/screens/onboarding/onboarding.dart';
import 'package:flutter_consware_prueba/providers/inicio/provider.inicio.dart';
import 'package:flutter_consware_prueba/providers/onboarding/provider_onboardin.dart';
import 'package:flutter_consware_prueba/providers/register/provider.register.dart';

import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProviderOnboardin()),
          ChangeNotifierProvider(create: (_) => ProviderRegiserUser()),
          ChangeNotifierProvider(create: (_) => ProviderInicio()),
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}
