import 'package:flutter/material.dart';
import 'package:flutter_consware_prueba/presentation/screens/login/login.user.dart';
import 'package:flutter_consware_prueba/providers/register/provider.register.dart';
import 'package:flutter_consware_prueba/styles/styles_onboarding.dart';
import 'package:provider/provider.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerRead = context.watch<ProviderRegiserUser>();
    return Scaffold(
      body: Form(
        key: providerRead.getformularioRegister,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/login/spinner-two.png',
                            scale: 4,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Banca créditos",
                            style: txtStyle.copyWith(
                                color: Colors.black, fontSize: 28),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text(
                        "Regístrate",
                        style: txtStyle.copyWith(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        "Solo te tomará unos minutos",
                        style:
                            txtStyle.copyWith(color: Colors.grey, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 29, vertical: 10),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Nombre completo",
                        hintText: "Nombre completo",
                        isDense: true,
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Digite nombre completo";
                        }
                        return null;
                      },
                      onChanged: (valor) {
                        providerRead.setnombre = valor;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Escribe tu número de identificación",
                        hintText: "Identificación",
                        isDense: true,
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Digite identificación";
                        }
                        return null;
                      },
                      onChanged: (valor) {
                        providerRead.setidentifica = valor;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Uname@mail.com",
                        hintText: "Email",
                        isDense: true,
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Digite un correo valido";
                        }
                        return null;
                      },
                      onChanged: (valor) {
                        providerRead.setcorreo = valor;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        hintText: "Constraseña",
                        isDense: true,
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Digite una contraseña";
                        }
                        return null;
                      },
                      onChanged: (valor) {
                        providerRead.setpass = valor;
                      },
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    CheckboxListTile(
                      value: providerRead.getCheck,
                      dense: true,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text(
                          "Acpeto los Términos y Condiciones y Politica de privacidad de Banca créditos"),
                      onChanged: (value) {
                        providerRead.changechek(check: value!);
                      },
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.only(
                          bottom: 50, left: 16, right: 16),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(colorBtnRegister),
                        ),
                        onPressed: () {
                          providerRead.registrarUsuario(
                            nombre: providerRead.getnombre,
                            idendificacion: providerRead.getidentificacion,
                            email: providerRead.getcorreo,
                            pass: providerRead.getpass,
                            chek: providerRead.getCheck,
                            context: context,
                          );
                        },
                        child: Text(
                          'Continuar',
                          style: txtStyle.copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Ya tienes una cuenta? ",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const LoginScreenUser(),
                                ),
                              );
                            },
                            child: Text(
                              "Inicia sesión",
                              style: TextStyle(
                                color: colorBtnRegister,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
