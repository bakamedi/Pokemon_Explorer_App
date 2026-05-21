import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  // --- TEMA CLARO ---
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: .light,
      primaryColor: AppColors.primaryRed,
      scaffoldBackgroundColor: AppColors.lightBackground,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryRed,
        primary: AppColors
            .primaryRed,
      ),

      // Colores generales de texto
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.lightTextPrimary),
        bodyMedium: TextStyle(color: AppColors.lightTextPrimary),
        titleLarge: TextStyle(
          color: AppColors.lightTextPrimary,
          fontWeight: .bold,
        ),
      ),

      // Configuración de la AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightHeader,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // Tarjetas
      cardTheme: const CardThemeData(
        color: AppColors.lightCard,
        elevation: 2,
        margin: .all(8),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightInput,

        hintStyle: const TextStyle(color: AppColors.lightTextSecondary),

        labelStyle: const TextStyle(color: AppColors.lightTextPrimary),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.lightTextSecondary),
        ),
      ),

      // Botones
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryRed,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(borderRadius: .circular(8)),
        ),
      ),
    );
  }

  // --- TEMA OSCURO ---
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: .dark,
      primaryColor: AppColors.primaryRed,
      scaffoldBackgroundColor: AppColors.darkBackground,

      // SOLUCIÓN: Agregamos explícitamente el brightness para sincronizar el esquema
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark, // <-- ESTA LÍNEA ES LA CLAVE
        seedColor: AppColors.primaryRed,
        primary: AppColors.primaryRed,
      ),

      // Colores generales de texto
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
        bodyMedium: TextStyle(color: AppColors.darkTextPrimary),
        titleLarge: TextStyle(
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkHeader,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // Cards
      cardTheme: const CardThemeData(
        color: AppColors.darkCard,
        elevation: 1,
        margin: EdgeInsets.all(8),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkInput,
        hintStyle: const TextStyle(color: AppColors.darkTextSecondary),
        labelStyle: const TextStyle(color: AppColors.darkTextPrimary),

        border: OutlineInputBorder(
          borderRadius: .circular(8),
          borderSide: const BorderSide(color: AppColors.darkInput),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: .circular(8),
          borderSide: const BorderSide(color: AppColors.primaryRed, width: 2),
        ),
      ),

      // Botones
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryRed,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(borderRadius: .circular(8)),
        ),
      ),
    );
  }
}
