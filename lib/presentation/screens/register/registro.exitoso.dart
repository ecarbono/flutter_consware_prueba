import 'package:flutter/material.dart';
import 'package:flutter_consware_prueba/presentation/screens/inicio/inicio.dart';
import 'package:flutter_consware_prueba/styles/styles_onboarding.dart';

class RegistroExitoso extends StatelessWidget {
  const RegistroExitoso({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 36),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Image.asset(
                'assets/register/Group_69.png',
                fit: BoxFit.contain,
                height: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Registro Exitoso',
                textAlign: TextAlign.center,
                style: txtStyle.copyWith(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Hemos guardado tus credenciales de forma exitosa, Presiona continuar para seguir adelante.',
                textAlign: TextAlign.center,
                style: txtStyle.copyWith(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(colorBtnRegister),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const InicioApp(),
                      ),
                    );
                  },
                  child: Text(
                    'Continuar',
                    style: txtStyle.copyWith(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
