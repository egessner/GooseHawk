import 'package:flutter/material.dart';

const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  // Primary
  primary: Color(0xFFF27A00),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFFFD9B3),
  onPrimaryContainer: Color(0xFF5A2D00),

  // Secondary
  secondary: Color(0xFF5B6D7B),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD6E0E8),
  onSecondaryContainer: Color(0xFF1E2C36),

  // Tertiary
  tertiary: Color(0xFF7C8A6D),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFDCE4D3),
  onTertiaryContainer: Color(0xFF2E3627),

  // Error
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF410002),

  // CORE surface (the main scaffold background)
  surface: Color(0xFFFAF9F7),
  onSurface: Color(0xFF1B1B1B),

  // Surface variants & tint
  onSurfaceVariant: Color(0xFF494540),
  surfaceTint: Color(0xFFF27A00),

  // Additional surface nuance (light theme)
  surfaceBright: Color(0xFFFFFFFF),         // always the lightest surface
  surfaceDim: Color(0xFFE8E5E1),            // always the darkest surface tone
  surfaceContainerLowest: Color(0xFFFFFFFF),
  surfaceContainerLow: Color(0xFFF7F4F1),
  surfaceContainer: Color(0xFFF0ECE8),
  surfaceContainerHigh: Color(0xFFE6E2DE),
  surfaceContainerHighest: Color(0xFFDAD6D2),

  // Utility
  outline: Color(0xFF7B7671),
  outlineVariant: Color(0xFFCCC6C0),
  inverseSurface: Color(0xFF31302E),
  onInverseSurface: Color(0xFFF3F0ED),
  inversePrimary: Color(0xFFFFB868),

  // Fixed variants (shared light/dark anchors)
  primaryFixed: Color(0xFFFFD9B3),
  primaryFixedDim: Color(0xFFEFB071),
  onPrimaryFixed: Color(0xFF3C2000),
  onPrimaryFixedVariant: Color(0xFF744100),

  secondaryFixed: Color(0xFFD6E0E8),
  secondaryFixedDim: Color(0xFFA8B4BF),
  onSecondaryFixed: Color(0xFF1E2C36),
  onSecondaryFixedVariant: Color(0xFF3E4C56),

  tertiaryFixed: Color(0xFFDCE4D3),
  tertiaryFixedDim: Color(0xFFAAB59D),
  onTertiaryFixed: Color(0xFF2E3627),
  onTertiaryFixedVariant: Color(0xFF555E4E),

  // Overlays / misc
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
);

const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // Primary
  primary: Color(0xFFFFB868),
  onPrimary: Color(0xFF4A2700),
  primaryContainer: Color(0xFF743C00),
  onPrimaryContainer: Color(0xFFFFD9B3),

  // Secondary
  secondary: Color(0xFFA8B4BF),
  onSecondary: Color(0xFF1E2C36),
  secondaryContainer: Color(0xFF3E4C56),
  onSecondaryContainer: Color(0xFFD6E0E8),

  // Tertiary
  tertiary: Color(0xFFAAB59D),
  onTertiary: Color(0xFF2E3627),
  tertiaryContainer: Color(0xFF555E4E),
  onTertiaryContainer: Color(0xFFDCE4D3),

  // Error
  error: Color(0xFFFFB4AB),
  onError: Color(0xFF690005),
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),


  // CORE surface (main scaffold background)
  surface: Color(0xFF1B1B1B),
  onSurface: Color(0xFFE5E1DE),

  // Surface variants & tint
  onSurfaceVariant: Color(0xFFCCC6C0),
  surfaceTint: Color(0xFFFFB868),

  // Additional surface nuance (dark theme)
  surfaceBright: Color(0xFF2B2B2B),           // lightest dark surface
  surfaceDim: Color(0xFF121212),              // darkest surface tone
  surfaceContainerLowest: Color(0xFF141414),
  surfaceContainerLow: Color(0xFF1E1E1E),
  surfaceContainer: Color(0xFF242424),
  surfaceContainerHigh: Color(0xFF2E2E2E),
  surfaceContainerHighest: Color(0xFF383838),

  // Utility
  outline: Color(0xFF8C8681),
  outlineVariant: Color(0xFF494540),
  inverseSurface: Color(0xFFE5E1DE),
  onInverseSurface: Color(0xFF1B1B1B),
  inversePrimary: Color(0xFFF27A00),

  // Fixed variants
  primaryFixed: Color(0xFFFFD9B3),
  primaryFixedDim: Color(0xFFEFB071),
  onPrimaryFixed: Color(0xFF3C2000),
  onPrimaryFixedVariant: Color(0xFF744100),

  secondaryFixed: Color(0xFFD6E0E8),
  secondaryFixedDim: Color(0xFFA8B4BF),
  onSecondaryFixed: Color(0xFF1E2C36),
  onSecondaryFixedVariant: Color(0xFF3E4C56),

  tertiaryFixed: Color(0xFFDCE4D3),
  tertiaryFixedDim: Color(0xFFAAB59D),
  onTertiaryFixed: Color(0xFF2E3627),
  onTertiaryFixedVariant: Color(0xFF555E4E),

  // Overlays / misc
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
);
