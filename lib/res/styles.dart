import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'colors.dart';
import 'dimens.dart';

class TextStyles {
  
  static const TextStyle textSize12 = TextStyle(
    fontSize: Dimens.font_sp12,
  );
  static const TextStyle textSize16 = TextStyle(
    fontSize: Dimens.font_sp16,
  );
  static const TextStyle textBold14 = TextStyle(
    fontSize: Dimens.font_sp14,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBold16 = TextStyle(
    fontSize: Dimens.font_sp16,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBold18 = TextStyle(
    fontSize: Dimens.font_sp18,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBold24 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBold26 = TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.bold
  );
 
  static const TextStyle textGray14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: MyColor.text_gray,
  );
  static const TextStyle textDarkGray14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: MyColor.dark_text_gray,
  );

  static const TextStyle textWhite14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colors.white,
  );
  
  static const TextStyle text = TextStyle(
    fontSize: Dimens.font_sp14,
    color: MyColor.textColorPrimaryLight,
    textBaseline: TextBaseline.alphabetic
  );
  static const TextStyle textDark = TextStyle(
    fontSize: Dimens.font_sp14,
    color: MyColor.textColorPrimaryNight,
    textBaseline: TextBaseline.alphabetic
  );

  static const TextStyle textSecondary = TextStyle(
      fontSize: Dimens.font_sp14,
      color: MyColor.textColorSecondaryLight,
      textBaseline: TextBaseline.alphabetic
  );
  static const TextStyle textSecondaryDark = TextStyle(
      fontSize: Dimens.font_sp14,
      color: MyColor.textColorSecondaryNight,
      textBaseline: TextBaseline.alphabetic
  );

  static const TextStyle textGray12 = TextStyle(
    fontSize: Dimens.font_sp12,
    color: MyColor.textColorSecondaryLight,
    fontWeight: FontWeight.normal
  );
  static const TextStyle textDarkGray12 = TextStyle(
    fontSize: Dimens.font_sp12,
    color: MyColor.textColorSecondaryNight,
    fontWeight: FontWeight.normal
  );
  
  static const TextStyle textHint14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: MyColor.dark_unselected_item_color
  );
}
