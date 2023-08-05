import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_consware_prueba/data/model/model.usuario.dart';
import 'package:flutter_consware_prueba/presentation/screens/login/register.user.dart.dart';
import 'package:flutter_consware_prueba/presentation/screens/register/registro.exitoso.dart';

class ProviderRegiserUser with ChangeNotifier {
  Usuario _usuario = Usuario();
  GestureRecognizer tapGestureRecognizer = TapGestureRecognizer();
  final GlobalKey<FormState> _formularioLogin = GlobalKey<FormState>();
  final GlobalKey<FormState> _formularioRegister = GlobalKey<FormState>();
  bool check = false;
  String _nombre = "";
  String _correo = "";
  String _identificacion = "";
  String _pass = "";

  GestureRecognizer get gettapGestureRecognizer => tapGestureRecognizer;
  String get getnombre => _nombre;
  String get getcorreo => _correo;
  String get getidentificacion => _identificacion;
  String get getpass => _pass;
  bool get getCheck => check;

  Usuario get getusuario => _usuario;
  GlobalKey<FormState> get getformularioLogin => _formularioLogin;
  GlobalKey<FormState> get getformularioRegister => _formularioRegister;

  set setnombre(valor) => _nombre = valor;
  set settapGestureRecognizer(valor) => tapGestureRecognizer = valor;

  set setcorreo(valor) => _correo = valor;
  set setidentifica(valor) => _identificacion = valor;
  set setpass(valor) => _pass = valor;

  set setusuario(value) => _usuario = value;
  set setCheck(value) => check = value;

  registrarUsuario(
      {required String nombre,
      required String idendificacion,
      required String email,
      required String pass,
      required bool chek,
      required BuildContext context}) {
    if (getformularioRegister.currentState!.validate()) {
      if (getCheck) {
        setusuario = Usuario(
          correo: email,
          fullnombre: nombre,
          idendificacion: idendificacion,
          pass: pass,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const RegistroExitoso(),
          ),
        );
        debugPrint("registrado");
      } else {
        debugPrint("Check vacio");
      }
    } else {
      debugPrint("Formulario no valido");
    }

    notifyListeners();
  }

  changechek({required bool check}) {
    setCheck = check;
    notifyListeners();
  }

  ontapRegsiter({required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => RegisterScreen(),
      ),
    );
  }
}
