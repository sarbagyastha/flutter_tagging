// Copyright 2019 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class SuggestionConfiguration {
  final Widget title;
  final Widget subtitle;
  final EdgeInsetsGeometry contentPadding;
  final bool dense;
  final bool isThreeLine;
  final Widget leading;
  final Widget additionWidget;
  final Color splashColor;
  final BorderRadius splashRadius;

  SuggestionConfiguration({
    @required this.title,
    @required this.subtitle,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.dense,
    this.isThreeLine = false,
    this.leading,
    this.additionWidget,
    this.splashColor,
    this.splashRadius = BorderRadius.zero,
  });
}

class ChipConfiguration {
  final Widget avatar;
  final Widget label;
  final TextStyle labelStyle;
  final EdgeInsetsGeometry labelPadding;
  final ShapeBorder shape;
  final Clip clipBehavior;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final Widget deleteIcon;
  final Color deleteIconColor;
  final String deleteButtonTooltipMessage;
  final MaterialTapTargetSize materialTapTargetSize;
  final double elevation;
  final Color shadowColor;

  ChipConfiguration({
    this.avatar,
    this.label,
    this.labelStyle,
    this.labelPadding,
    this.deleteIcon,
    this.deleteIconColor,
    this.deleteButtonTooltipMessage,
    this.shape,
    this.clipBehavior = Clip.none,
    this.backgroundColor,
    this.padding,
    this.materialTapTargetSize,
    this.elevation,
    this.shadowColor,
  });
}
