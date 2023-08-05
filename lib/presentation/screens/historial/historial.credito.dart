import 'package:flutter/material.dart';
import 'package:flutter_consware_prueba/presentation/screens/historial/historial.credito.detalle.dart';
import 'package:flutter_consware_prueba/providers/inicio/provider.inicio.dart';
import 'package:flutter_consware_prueba/providers/register/provider.register.dart';
import 'package:flutter_consware_prueba/styles/styles_onboarding.dart';
import 'package:provider/provider.dart';

class CreditHistoriScreen extends StatelessWidget {
  const CreditHistoriScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerRead = context.watch<ProviderInicio>();
    final providerUser = context.watch<ProviderRegiserUser>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            ListTile(
              dense: true,
              title: Text(
                "Historial de créditos",
                style: txtStyle.copyWith(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Aquí encontrarás tu historial de créditos y el registro de todas tus simulaciones.",
                  style: txtStyle.copyWith(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            (providerRead.historialCreditos.isEmpty)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.info,
                        color: Colors.grey,
                      ),
                      Text(
                        "No hay mas datos por mostrar",
                        style: txtStyle.copyWith(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      )
                    ],
                  )
                : Expanded(
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      slivers: [
                        SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            childAspectRatio: 2,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final headerText = [
                                'Monto de credito',
                                'Fecha',
                                'No. Cuotas',
                                'Interés'
                              ];
                              return Container(
                                alignment: Alignment.center,
                                child: Text(
                                  headerText[index],
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: txtStyle.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              );
                            },
                            childCount: 4,
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              List<Map<String, dynamic>> filteredList =
                                  providerRead
                                      .historialCreditos
                                      .where((user) =>
                                          user['usuario_credito'] ==
                                          providerUser
                                              .getusuario.idendificacion)
                                      .toList();

                              final table = filteredList[index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          CreditSimulationDetalleScreen(
                                        data: table['detalle_credito'],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          child: Text(
                                            '\$ ${table['monto_total'].toString()}',
                                            textAlign: TextAlign.center,
                                            style: txtStyle.copyWith(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          child: Text(
                                            table['fecha_credito'].toString(),
                                            textAlign: TextAlign.right,
                                            style: txtStyle.copyWith(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          child: Text(
                                            table['num_cuotas'].toString(),
                                            textAlign: TextAlign.right,
                                            style: txtStyle.copyWith(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          child: Text(
                                            table['interesP'].toString(),
                                            textAlign: TextAlign.right,
                                            style: txtStyle.copyWith(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            childCount: providerRead.historialCreditos.length,
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
