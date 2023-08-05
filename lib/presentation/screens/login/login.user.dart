import 'package:flutter/material.dart';
import 'package:flutter_consware_prueba/providers/register/provider.register.dart';
import 'package:flutter_consware_prueba/styles/styles_onboarding.dart';
import 'package:provider/provider.dart';

class LoginScreenUser extends StatelessWidget {
  const LoginScreenUser({super.key});

  @override
  Widget build(BuildContext context) {
    final providerRead = context.watch<ProviderRegiserUser>();
    return Scaffold(
      body: Form(
        key: providerRead.getformularioLogin,
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
                        "Inicia sesión o continua,",
                        style: txtStyle.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        "solo te tomará unos minutos.",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10, left: 0),
                      child: const Text(
                        "Email or Usuario",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Uname@mail.com",
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
                    Container(
                      margin: const EdgeInsets.only(bottom: 10, left: 0),
                      child: const Text(
                        "Contraseña",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Escribe tu número de identificación",
                        hintText: "Identificación",
                        isDense: true,
                        prefixIcon: Icon(Icons.lock_outline),
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
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CheckboxListTile(
                          value: providerRead.getCheck,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text("Recordarme"),
                          onChanged: (value) {
                            providerRead.changechek(check: value!);
                          },
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: Text(
                            "¿Olvide mi contraseña?",
                            style: txtStyle.copyWith(
                                color: colorBtnRegister, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin:
                        const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(colorBtnRegister),
                      ),
                      onPressed: () {
                        // providerRead.registrarUsuario(
                        //     nombre: providerRead.getnombre,
                        //     idendificacion: providerRead.getidentificacion,
                        //     email: providerRead.getcorreo,
                        //     pass: providerRead.getpass,
                        //     chek: providerRead.getCheck,
                        //     context: context);
                      },
                      child: Text(
                        'Iniciar sesión',
                        style: txtStyle.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 18, right: 18),
                    child: const Row(
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 1,
                        )),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.circle_outlined,
                            color: Colors.grey,
                            size: 10,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin:
                        const EdgeInsets.only(bottom: 16, left: 18, right: 18),
                    child: ElevatedButton.icon(
                      icon: Image.asset('assets/login/Logo.png'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(colorBtnIngresar),
                      ),
                      onPressed: () {},
                      label: Text(
                        'Ingresa con Google',
                        style: txtStyle.copyWith(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin:
                        const EdgeInsets.only(bottom: 16, left: 18, right: 18),
                    child: ElevatedButton.icon(
                      icon: Image.asset('assets/login/Logo-2.png'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(colorBtnIngresar),
                      ),
                      onPressed: () {},
                      label: Text(
                        ' Ingresa con Appel',
                        style: txtStyle.copyWith(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "¿No tienes una cuenta? ",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          providerRead.ontapRegsiter(context: context);
                        },
                        child: Text(
                          "Regístrate",
                          style: TextStyle(
                            color: colorBtnRegister,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
