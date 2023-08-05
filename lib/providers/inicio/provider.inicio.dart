// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_consware_prueba/presentation/screens/historial/historial.credito.dart';
import 'package:flutter_consware_prueba/presentation/screens/loading/loading.dart';

import 'package:flutter_consware_prueba/providers/register/provider.register.dart';
import 'package:flutter_consware_prueba/styles/styles_onboarding.dart';
import 'package:intl/intl.dart';

import 'package:flutter_consware_prueba/presentation/screens/inicio/view_home.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;

class ProviderInicio with ChangeNotifier {
  bool simuladorOn = false;
  final moneyFormat = NumberFormat("#,##0", "es_ES");
  TextEditingController txtControllerCredito = TextEditingController();
  String salary = "";
  String maxCredit = "";
  double cuotaValue = 0.0;
  double intenreses = 0.0;
  int contador = 0;
  String selectedValue = 'Seleccione el tipo de créditos';
  List<String> dropdownItems = [
    'Seleccione el tipo de créditos',
    'Credito Vehículo',
    'Credito Vivienda',
    'Credito de Libre Inversión'
  ];
  List<Map<String, dynamic>> detalleCredit = [];
  List<Map<String, dynamic>> historialCreditos = [];
  int selectedCuotas = 84;
  List<int> cuotasOptions = [12, 24, 36, 48, 60, 72, 84];
  int selectedIndex = 0;
  int get getselectedIndex => selectedIndex;
  int get getcontador => contador;
  String get getsalary => salary;
  String get getmaxCredit => maxCredit;
  List<Widget> get getwidgetOptions => widgetOptions;
  List<Map<String, dynamic>> get getdetalleCredit => detalleCredit;
  set setselectedIndex(valor) => selectedIndex = valor;
  set setcontador(valor) => contador = valor;
  set setsalary(valor) => salary = valor;
  set setmaxCredit(valor) => maxCredit = valor;

  static List<Widget> widgetOptions = <Widget>[
    const ViewHome(),
    const CreditHistoriScreen()
  ];

  void onItemTapped(int index) {
    simuladorOn = false;
    setselectedIndex = index;
    notifyListeners();
  }

  void obtenerMaxCredit({required String credito}) {
    var maxCredito;
    String valornew = credito.replaceAll('\$', '').replaceAll(',', '');
    if (valornew.isNotEmpty) {
      maxCredito = (int.parse(valornew) * 7) / 0.15;
      txtControllerCredito.text = moneyFormat.format(maxCredito.toInt());
    } else {
      txtControllerCredito.text = "";
    }

    notifyListeners();
  }

  Future simulateLoadingAndNavigate(BuildContext context) async {
    BuildContext? loading;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        loading = context;
        return const LoadingScreen();
      },
    );
    await Future.delayed(const Duration(seconds: 1));
    return loading;
  }

  simularcreedito({required BuildContext context}) async {
    BuildContext contextloading = await simulateLoadingAndNavigate(context);
    detalleCredit.clear();

    double montoPrestamo = double.parse(txtControllerCredito.text
        .replaceAll('.', '')
        .replaceAll(',', '')
        .replaceAll('\$', ''));
    int numeroCuotas = selectedCuotas;

    double cuota =
        (montoPrestamo * intenreses) / (1 - pow(1 + intenreses, -numeroCuotas));
    cuotaValue = cuota;
    double saldoPeriodo = montoPrestamo;
    for (int cuotaNum = 1; cuotaNum <= numeroCuotas; cuotaNum++) {
      double interes = saldoPeriodo * intenreses;
      double abonoCapital = cuota - interes;
      saldoPeriodo -= abonoCapital;
      detalleCredit.add({
        'numero_cuota': cuotaNum,
        'saldo_inicial':
            moneyFormat.format(saldoPeriodo.toInt() + abonoCapital.toInt()),
        'cuota': moneyFormat.format(cuota.toInt()),
        'interes': moneyFormat.format(interes.toInt()),
        'abono_capital': moneyFormat.format(abonoCapital.toInt()),
        'saldo_periodo': moneyFormat.format(saldoPeriodo.toInt()),
        'num_cuotas': numeroCuotas,
        "interesP": intenreses
      });
    }

    simuladorOn = true;
    Navigator.pop(contextloading);
    notifyListeners();
  }

  obtenerinteres({required String credito}) {
    if (credito.isNotEmpty) {
      switch (credito) {
        case 'Credito Vehículo':
          intenreses = 0.03;
          break;
        case 'Credito Vivienda':
          intenreses = 0.01;
          break;
        case 'Credito de Libre Inversión':
          intenreses = 0.035;
          break;
        default:
      }

      notifyListeners();
    }
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    return formattedDate;
  }

  Future modalGuardarCredito({
    required BuildContext context,
    required ProviderRegiserUser datosUsuario,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 350,
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: Image.asset(
                    'assets/amortizacion/Group_36405.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿Está seguro que desea Guardar la cotización?',
                          textAlign: TextAlign.center,
                          style: txtStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'La cotización realizada la podrás consultar en tu historial de créditos.',
                          textAlign: TextAlign.center,
                          style: txtStyle.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10),
                        height: 40,
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                            backgroundColor:
                                MaterialStatePropertyAll(colorBtnRegister),
                          ),
                          onPressed: () {
                            historialCreditos.add({
                              "numero_credito": contador,
                              "usuario_credito":
                                  datosUsuario.getusuario.idendificacion,
                              "fecha_credito": getCurrentDate(),
                              "detalle_credito": detalleCredit,
                              "monto_total": detalleCredit[0]["saldo_inicial"],
                              "interes": detalleCredit[0]["interes"],
                              "num_cuotas": detalleCredit[0]["num_cuotas"],
                              "interesP": detalleCredit[0]["interesP"],
                            });
                            contador = contador + 1;
                            simuladorOn = false;
                            selectedIndex = 1;
                            Navigator.pop(context);
                            notifyListeners();
                          },
                          child: Text(
                            'Guardar',
                            style: txtStyle.copyWith(fontSize: 16),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10),
                        height: 40,
                        child: TextButton(
                          style: ButtonStyle(
                            side: MaterialStatePropertyAll(
                              BorderSide(
                                width: 1.0,
                                color: colorBtnRegister,
                              ),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancelar',
                            style: txtStyle.copyWith(
                                fontSize: 16, color: colorBtnRegister),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> exportToExcel(
      {required List<Map<String, dynamic>> registros}) async {
    int contadorFilas = 1;
    final xlsio.Workbook workbook = xlsio.Workbook(1);

    final xlsio.CellStyle cellStyle1 =
        xlsio.CellStyle(workbook.worksheets[0].workbook);

    cellStyle1.bold = true;
    workbook.worksheets[0].getRangeByName('A1').setText('# Cuota');
    workbook.worksheets[0].getRangeByName('B1').setText('Saldo Inicial');
    workbook.worksheets[0].getRangeByName('C1').setText('Cuota');
    workbook.worksheets[0].getRangeByName('D1').setText('Interés');
    workbook.worksheets[0].getRangeByName('E1').setText('Abono a Capital');
    workbook.worksheets[0].getRangeByName('F1').setText('Saldo del Periodo');
    workbook.worksheets[0].name =
        '${historialCreditos[0]['usuario_credito']}-$selectedValue-${historialCreditos[0]['fecha_credito']}';
    workbook.worksheets[0].getRangeByName('A1:F1').cellStyle = cellStyle1;

    int cantidadRegistros = registros.length;
    for (var i = 0; i < cantidadRegistros; i++) {
      workbook.worksheets[0]
          .getRangeByIndex(contadorFilas + 1, 1, contadorFilas + 1, 1)
          .setText('${registros[i]['numero_cuota']}');

      workbook.worksheets[0]
          .getRangeByIndex(contadorFilas + 1, 2, contadorFilas + 1, 2)
          .setText('${registros[i]['saldo_inicial']}');
      workbook.worksheets[0]
          .getRangeByIndex(contadorFilas + 1, 3, contadorFilas + 1, 3)
          .setText('${registros[i]['cuota']}');

      workbook.worksheets[0]
          .getRangeByIndex(contadorFilas + 1, 4, contadorFilas + 1, 4)
          .setText('${registros[i]['interes']}');

      workbook.worksheets[0]
          .getRangeByIndex(contadorFilas + 1, 5, contadorFilas + 1, 5)
          .setText('${registros[i]['abono_capital']}');

      workbook.worksheets[0]
          .getRangeByIndex(contadorFilas + 1, 6, contadorFilas + 1, 6)
          .setText('${registros[i]['saldo_periodo']}');

      contadorFilas++;
    }
    final List<int> byte = workbook.saveAsStream();

    workbook.dispose();
    Directory dir = await getTemporaryDirectory();
    String filename = 'Archivo.xlsx';

    // if (await File("${dir.path}/$filename").exists()) {
    //   await File("${dir.path}/$filename").delete();
    // }
    File file =
        await File("${dir.path}/$filename").writeAsBytes(byte, flush: true);

    OpenFile.open(file.path);
  }
}
