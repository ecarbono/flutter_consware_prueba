import 'package:flutter/material.dart';
import 'package:flutter_consware_prueba/providers/inicio/provider.inicio.dart';
import 'package:flutter_consware_prueba/providers/register/provider.register.dart';
import 'package:flutter_consware_prueba/styles/styles_onboarding.dart';
import 'package:provider/provider.dart';

class InicioApp extends StatelessWidget {
  const InicioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final providerRead = context.watch<ProviderInicio>();
    final providerUser = context.watch<ProviderRegiserUser>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Hola ${providerUser.getusuario.fullnombre}. 👋 ',
                style: txtStyle.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(
              Icons.notifications_on_outlined,
              color: Colors.black,
              size: 30,
            )
          ],
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: providerRead.getwidgetOptions
            .elementAt(providerRead.getselectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Historial creditos',
          )
        ],
        currentIndex: providerRead.getselectedIndex,
        selectedItemColor: colorBtnRegister,
        onTap: providerRead.onItemTapped,
      ),
    );
  }
}
