import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_consware_prueba/presentation/screens/inicio/view_amortizacion.dart';
import 'package:flutter_consware_prueba/providers/inicio/provider.inicio.dart';
import 'package:flutter_consware_prueba/styles/styles_onboarding.dart';
import 'package:provider/provider.dart';

class ViewHome extends StatelessWidget {
  const ViewHome({super.key});

  @override
  Widget build(BuildContext context) {
    final providerRead = context.watch<ProviderInicio>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: (providerRead.simuladorOn)
          ? CreditSimulationScreen(data: providerRead.getdetalleCredit)
          : ListView(
              children: [
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Simulador de crédito",
                      style: txtStyle.copyWith(
                          color: colorBtnRegister,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Text(
                    "Ingresa los datos para tu crédito según lo que necesites.",
                    style: txtStyle.copyWith(color: Colors.black, fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "¿Que tipo de créditos deseas realizar?",
                  style: txtStyle.copyWith(color: Colors.black, fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                  value: providerRead.selectedValue,
                  onChanged: (newValue) {
                    providerRead.selectedValue = newValue!;
                    providerRead.obtenerinteres(credito: newValue);
                  },
                  items: providerRead.dropdownItems.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "¿Cúantos es tu salario base?",
                  style: txtStyle.copyWith(color: Colors.black, fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    CurrencyTextInputFormatter(
                      decimalDigits: 0,
                      locale: null,
                      enableNegative: false,
                      symbol: '\$',
                      name: '',
                      turnOffGrouping: false,
                    ),
                  ],
                  decoration: const InputDecoration(
                    labelText: "\$10.000.000,00",
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Digite el valor del salario";
                    }
                    return null;
                  },
                  onChanged: (valor) {
                    providerRead.setsalary = valor;
                    providerRead.obtenerMaxCredit(credito: valor);
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12),
                  child: Text(
                    "Digíta tu salario para calcular el préstamo que necesitas",
                    style: txtStyle.copyWith(
                        color: colorlabelBotondown, fontSize: 12),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: providerRead.txtControllerCredito,
                  inputFormatters: <TextInputFormatter>[
                    CurrencyTextInputFormatter(
                      decimalDigits: 0,
                      locale: null,
                      enableNegative: false,
                      symbol: '\$',
                      name: '',
                      turnOffGrouping: false,
                    ),
                  ],
                  validator: (value) {
                    if (int.parse(value!) <
                        int.parse(providerRead.txtControllerCredito.text)) {
                      return null;
                    } else {
                      return "No puede solicitar un credito mayor al maximo";
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade400,
                    filled: true,
                    // labelText: "\$0",
                    hintText: "\$0",
                    isDense: true,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                  onChanged: (valor) {},
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "¿A cuántos meses?",
                  style: txtStyle.copyWith(color: Colors.black, fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                  value: providerRead.selectedCuotas,
                  onChanged: (newValue) {
                    providerRead.selectedCuotas = newValue!;
                  },
                  items: providerRead.cuotasOptions.map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12),
                  child: Text(
                    "Elije un plazo desde 12 hasta 84 meses",
                    style: txtStyle.copyWith(
                        color: colorlabelBotondown, fontSize: 12),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.only(
                      bottom: 50, left: 16, right: 16, top: 50),
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      )),
                      backgroundColor:
                          MaterialStatePropertyAll(colorBtnRegister),
                    ),
                    onPressed: () {
                      providerRead.simularcreedito(context: context);
                    },
                    child: Text(
                      'Simular',
                      style: txtStyle.copyWith(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
