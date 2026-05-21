import 'package:flutter/material.dart';
import 'package:poke_test/presentation/globals/common/widgets/global_loader_wrapper_gw.dart';
import 'package:poke_test/routes/app_pages.dart';
import 'package:poke_test/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderWrapperGW(
      body: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.routerProvider.read(),
        title: 'Pokémon Explorer App',
        theme: ThemeMode.light == ThemeMode.dark
            ? AppTheme.darkTheme
            : AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: .light,
        builder: (context, child) => child!,
      ),
    );
  }
}
