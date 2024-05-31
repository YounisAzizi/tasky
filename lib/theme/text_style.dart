import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'colors.dart';

class Styles {
  const Styles._();
  static const subtitle = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );
  static const fadeTextStyle = TextStyle(fontSize: 16, color: Colors.grey);
  static const linkStyle = TextStyle(
      decoration: TextDecoration.underline,
      fontSize: 18,
      color: AppColors.mainThemColor,
      fontWeight: FontWeight.w500);
  static const noItemStyle = TextStyle(
    fontSize: 24,
    fontWeight: _defaultWeight,
    color: AppColors.noItemColor,
  );
  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.mainThemColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    maximumSize: const Size(160, 50),
    minimumSize: const Size(130, 50),
  );
  static const titleStyle = TextStyle(
      color: AppColors.backgroundDark,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
      fontSize: 20);
  static const mainTitleStyle = TextStyle(
      color: AppColors.backgroundDark,
      fontWeight: FontWeight.w700,
      overflow: TextOverflow.ellipsis,
      fontSize: 24);
  static const profileSubTitle = TextStyle(
      color: Color.fromRGBO(47, 47, 47, 0.6),
      fontWeight: FontWeight.w700,
      fontSize: 18);

  static const toolTipStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: _defaultDarkColor,
  );

  static const w400_14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: _defaultDarkColor,
  );

  static const w400_16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: _defaultBackgroundDark,
  );

  static const w400_20 = TextStyle(
    fontSize: 20,
    fontWeight: _defaultWeight,
    color: _defaultBackgroundDark,
  );

  static const w500_16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const w600_12 = TextStyle(
    fontSize: 12,
    fontWeight: _defaultWeight,
  );

  static const w600_14 = TextStyle(
    fontSize: 14,
    fontWeight: _defaultWeight,
  );

  static const w600_16 = TextStyle(
    fontSize: 16,
    fontWeight: _defaultWeight,
    color: _defaultDarkColor,
  );

  static const w600_18 = TextStyle(
    fontSize: 18,
    fontWeight: _defaultWeight,
  );

  static const w700_20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static const _defaultBackgroundDark = AppColors.backgroundDark;
  static const _defaultDarkColor = Colors.black;
  static const _defaultLightColor = AppColors.textLight;
  static const _defaultWeight = FontWeight.w500;
  static const _hintText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const _w400_16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const _w500_14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const _w500_18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    overflow: TextOverflow.ellipsis,
  );

  static const _w500_22 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: _defaultLightColor,
  );

  static const _w600_28 = TextStyle(
    fontSize: 28,
    fontWeight: _defaultWeight,
    color: _defaultLightColor,
  );

  static const _w600_30 = TextStyle(
    fontSize: 30,
    fontWeight: _defaultWeight,
  );

  static TextStyle hintStyle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark ? AppColors.hintTextFieldDark : AppColors.hintTextFieldLight;
    return _hintText.copyWith(
      color: color,
    );
  }

  static TextStyle drawerText(BuildContext context, WidgetRef ref) {
    const color = AppColors.unSelectedDrawerTextLight;
    return w600_18.copyWith(
      color: color,
    );
  }

  static TextStyle tableHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark ? AppColors.headerTableTextDark : AppColors.headerTableTextLight;
    return w600_16.copyWith(
      color: color,
    );
  }

  static TextStyle addManagerTableHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? _defaultDarkColor : Colors.black;
    return w600_16.copyWith(
      color: color,
    );
  }

  static TextStyle small(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? _defaultDarkColor : Colors.black;
    return toolTipStyle.copyWith(
      color: color,
    );
  }

  static TextStyle evaluationStyle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark ? AppColors.evaluationTextDark : AppColors.evaluationTextLight;
    return _w500_18.copyWith(
      color: color,
    );
  }

  static TextStyle heatMapLessMoreStyle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? Colors.white : const Color(0xff22242C);
    return w600_16.copyWith(
      color: color,
    );
  }

  static TextStyle headline12(BuildContext context) => _w400_16.copyWith(
        color: _defaultColor(context),
      );

  static TextStyle headline11(BuildContext context) => _w500_18.copyWith(
        color: _defaultColor(context),
      );

  static TextStyle headline10(BuildContext context) => w400_14.copyWith(
        color: _defaultColor(context),
      );

  static TextStyle headline9(BuildContext context) => _w500_14.copyWith(
        color: _defaultColor(context),
      );

  static TextStyle headline8(BuildContext context) => w600_14.copyWith(
        color: _defaultColor(context),
      );

  static TextStyle headline7withoverflow(BuildContext context) =>
      w500_16.copyWith(
        color: _defaultColor(context),
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle headline7(BuildContext context) => w500_16.copyWith(
        color: _defaultColor(context),
      );

  static TextStyle headline6(BuildContext context) => w600_16.copyWith(
        color: _defaultColor(context),
      );

  static TextStyle headline5(BuildContext context) => w600_18.copyWith(
        color: _defaultColor(context),
      );

  static TextStyle headline4(BuildContext context) => w700_20.copyWith(
        color: _defaultColor(context),
      );

  static TextStyle headline3(BuildContext context) => _w600_30.copyWith(
        color: _defaultColor(context),
      );

  static TextStyle headline2(BuildContext context) => _w500_22.copyWith(
        color: _defaultColor(context),
      );

  static TextStyle headline1(BuildContext context) => _w600_28.copyWith(
        color: _defaultColor(context),
      );

  static Color _defaultColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? _defaultDarkColor : _defaultLightColor;
  }
}
