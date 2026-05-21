// generate widget close session
import 'package:flutter/material.dart';
import 'package:poke_test/presentation/home/utils/close_session.dart';

class CloseSessionW extends StatelessWidget {
  const CloseSessionW({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout_rounded, color: Colors.white),
      tooltip: 'Cerrar Sesión',
      onPressed: () => closeSession(context),
    );
  }
}
