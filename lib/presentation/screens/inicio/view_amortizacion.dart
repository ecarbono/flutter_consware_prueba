import 'package:flutter/material.dart';
import 'package:flutter_consware_prueba/providers/inicio/provider.inicio.dart';
import 'package:flutter_consware_prueba/providers/register/provider.register.dart';
import 'package:flutter_consware_prueba/styles/styles_onboarding.dart';
import 'package:provider/provider.dart';

class CreditSimulationScreen extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const CreditSimulationScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final providerRead = context.watch<ProviderInicio>();
    final providerUser = context.watch<ProviderRegiserUser>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Resultado de tu simulador de crédito",
              style: txtStyle.copyWith(
                color: colorBtnRegister,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Te presentamos en tu tabla de amortización el resultado del movimiento de tu crédito.",
              style: txtStyle.copyWith(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Tabla de créditos",
              textAlign: TextAlign.start,
              style: txtStyle.copyWith(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                slivers: [
                  SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      childAspectRatio: 1,
                      crossAxisSpacing: 1,
                      mainAxisExtent: 35,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final headerText = [
                          'No.',
                          'Saldo Inicial',
                          'Valor Cuota',
                          'Interés',
                          'Abono a Capital',
                          'Saldo del Periodo',
                        ];
                        return Container(
                          child: Text(
                            headerText[index],
                            textAlign: TextAlign.start,
                          ),
                        );
                      },
                      childCount: 6,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final table = data[index];
                        return Container(
                          alignment: Alignment.center,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: Text(
                                  table['numero_cuota'].toString(),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: txtStyle.copyWith(
                                    fontSize: 10,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Text(
                                    '\$ ${table['saldo_inicial'].toString()}',
                                    maxLines: 1,
                                    softWrap: true,
                                    textAlign: TextAlign.right,
                                    style: txtStyle.copyWith(
                                      fontSize: 9,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Text(
                                    '\$ ${table['cuota'].toString()}',
                                    maxLines: 1,
                                    softWrap: true,
                                    textAlign: TextAlign.right,
                                    style: txtStyle.copyWith(
                                      fontSize: 9,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Text(
                                    '\$ ${table['interes'].toString()}',
                                    maxLines: 1,
                                    softWrap: true,
                                    textAlign: TextAlign.right,
                                    style: txtStyle.copyWith(
                                        fontSize: 9, color: Colors.black),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Text(
                                    '+ \$${table['abono_capital'].toString()}',
                                    textAlign: TextAlign.right,
                                    maxLines: 1,
                                    softWrap: true,
                                    style: txtStyle.copyWith(
                                        fontSize: 9,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Text(
                                    '\$ ${table['saldo_periodo'].toString()}',
                                    maxLines: 1,
                                    softWrap: true,
                                    textAlign: TextAlign.right,
                                    style: txtStyle.copyWith(
                                        fontSize: 9, color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: data.length,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10),
              height: 40,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  )),
                  backgroundColor: MaterialStatePropertyAll(colorBtnRegister),
                ),
                onPressed: () {
                  providerRead.exportToExcel(registros: data);
                },
                child: Text(
                  'Descargar Tabla',
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
                  ), // Ajusta el ancho del borde y el color

                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  backgroundColor: const MaterialStatePropertyAll(Colors.white),
                ),
                onPressed: () {
                  providerRead.modalGuardarCredito(
                      datosUsuario: providerUser, context: context);
                },
                child: Text(
                  'Guardar cotización',
                  style:
                      txtStyle.copyWith(fontSize: 16, color: colorBtnRegister),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
