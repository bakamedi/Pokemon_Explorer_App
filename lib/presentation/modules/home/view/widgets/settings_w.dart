import 'package:flutter/material.dart';
import 'package:poke_test/presentation/modules/home/utils/open_settings.dart';

class SettingsW extends StatelessWidget {
  const SettingsW({super.key});


  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings, color: Colors.white),
      tooltip: 'Cerrar Sesión',
      onPressed: () => openSettings(context, ),
    );
  }
}
