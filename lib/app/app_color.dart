// lib/core/app_colors.dart
//
// DayChallenge color system.
// Every color here has a JOB — not decoration.
// Gold = reward (dopamine). Red = loss (loss-aversion). Purple = action.
// Blue = relief (the one "you're safe" color in the app).
// Rare colors stay powerful. Don't add new accent colors without a reason.

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ════════════════════════════════════════════════════════
  // BRAND — same in both modes. Never shifts. This is how
  // users recognize the app instantly regardless of theme.
  // ════════════════════════════════════════════════════════
  static const Color primary = Color(0xFF6C63FF); // purple — primary actions
  static const Color coinGold = Color(0xFFF59E0B); // gold   — coins & reward

  // ════════════════════════════════════════════════════════
  // DARK MODE
  // ════════════════════════════════════════════════════════
  static const Color darkBg = Color(0xFF0F0E17); // 60% — page background
  static const Color darkSurface = Color(
    0xFF1E1E2E,
  ); // 30% — cards, lighter than bg for lift
  static const Color darkSurface2 = Color(
    0xFF2A2A3E,
  ); // progress track / inputs
  static const Color darkBorder = Color(
    0xFF3A3A52,
  ); // subtle hairline, replaces shadow

  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);

  static const Color darkSuccess = Color(
    0xFF43C59E,
  ); // soft green — reads clean on dark
  static const Color darkDanger = Color(
    0xFFEF4444,
  ); // red — loss-aversion trigger
  static const Color darkFreeze = Color(
    0xFF60A5FA,
  ); // blue — the "you're safe" color

  static const Color darkCoinBg = Color(0xFF2D2500); // gold pill background
  static const Color darkDangerBg = Color(0xFF2A0A0A); // red banner background
  static const Color darkFreezeBg = Color(0xFF0A1A2A); // blue banner background
  static const Color darkSuccessBg = Color(
    0xFF0D2218,
  ); // green banner background
  static const Color darkPrimaryBg = Color(
    0xFF1A0D2E,
  ); // purple tint background

  // ════════════════════════════════════════════════════════
  // LIGHT MODE
  // ════════════════════════════════════════════════════════
  static const Color lightBg = Color(
    0xFFF8F7FF,
  ); // 60% — faint purple-tinted white
  static const Color lightSurface = Color(
    0xFFFFFFFF,
  ); // 30% — pure white card, pops off bg
  static const Color lightSurface2 = Color(
    0xFFEDEBFF,
  ); // progress track / inputs
  static const Color lightBorder = Color(0xFFE2E0FF); // soft lavender hairline

  static const Color lightTextPrimary = Color(0xFF1E1E2E);
  static const Color lightTextSecondary = Color(0xFF6B7280);

  static const Color lightSuccess = Color(
    0xFF10B981,
  ); // punchier green — needed for contrast on white
  static const Color lightDanger = Color(
    0xFFDC2626,
  ); // punchier red — same reason
  static const Color lightFreeze = Color(0xFF3B82F6); // punchier blue

  static const Color lightCoinBg = Color(0xFFFEF3C7);
  static const Color lightDangerBg = Color(0xFFFEE2E2);
  static const Color lightFreezeBg = Color(0xFFDDEBFF);
  static const Color lightSuccessBg = Color(0xFFD1FAE5);
  static const Color lightPrimaryBg = Color(0xFFEEEDFE);
}
