// Copyright 2018 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a Apache license that can be found
// in the LICENSE file.

/// Flutter Tagging
/// Author: Sarbagya Dhaubanjar
///
///                               ,,
///    .M"""bgd                  *MM
///   ,MI    "Y                   MM
///   `MMb.      ,6"Yb.  `7Mb,od8 MM,dMMb.   ,6"Yb.  .P"Ybmmm `7M'   `MF',6"Yb.
///     `YMMNq. 8)   MM    MM' "' MM    `Mb 8)   MM :MI  I8     VA   ,V 8)   MM
///   .     `MM  ,pm9MM    MM     MM     M8  ,pm9MM  WmmmP"      VA ,V   ,pm9MM
///   Mb     dM 8M   MM    MM     MM.   ,M9 8M   MM 8M            VVV   8M   MM
///   P"Ybmmd"  `Moo9^Yo..JMML.   P^YbmdP'  `Moo9^Yo.YMMMMMb      ,V    `Moo9^Yo.
///                                              6'     dP    ,V
///                                              Ybmmmd'   OOb"
///
///
///                ,,                           ,,                             ,,
///   `7MM"""Yb. `7MM                          *MM                             db
///     MM    `Yb. MM                           MM
///     MM     `Mb MMpMMMb.   ,6"Yb.`7MM  `7MM  MM,dMMb.   ,6"Yb.  `7MMpMMMb.`7MM  ,6"Yb.  `7Mb,od8
///     MM      MM MM    MM  8)   MM  MM    MM  MM    `Mb 8)   MM    MM    MM  MM 8)   MM    MM' "'
///     MM     ,MP MM    MM   ,pm9MM  MM    MM  MM     M8  ,pm9MM    MM    MM  MM  ,pm9MM    MM
///     MM    ,dP' MM    MM  8M   MM  MM    MM  MM.   ,M9 8M   MM    MM    MM  MM 8M   MM    MM
///   .JMMmmmdP' .JMML  JMML.`Moo9^Yo.`Mbod"YML.P^YbmdP'  `Moo9^Yo..JMML  JMML.MM `Moo9^Yo..JMML.
///                                                                         QO MP
///                                                                         `bmP

/// Website: https://sarbagyastha.com.np
/// Github: https://github.com/sarbagyastha/flutter_tagging
///
library flutter_tagging;

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

typedef FlutterTaggingCallBack(dynamic);
typedef void SuggestionSelectionCallback<T>(T suggestion);

/// [FlutterTagging] widget displays list of suggestions and enables to select or add those suggestions in the form of tags.
class FlutterTagging extends StatefulWidget {
  /// [FlutterTaggingCallBack] is callback for registering any change in output data.
  final FlutterTaggingCallBack onChanged;

  /// [InputDecoration](https://docs.flutter.io/flutter/material/InputDecoration-class.html) for [TextField](https://docs.flutter.io/flutter/material/TextField-class.html) displayed by FlutterTagging Widget.
  final InputDecoration textFieldDecoration;

  /// Called with the search pattern to get the search suggestions.
  ///
  /// This callback must not be null. It is be called by the TypeAhead widget
  /// and provided with the search pattern. It should return a [List](https://api.dartlang.org/stable/2.0.0/dart-core/List-class.html)
  /// of suggestions either synchronously, or asynchronously (as the result of a
  /// [Future](https://api.dartlang.org/stable/dart-async/Future-class.html)).
  /// Typically, the list of suggestions should not contain more than 4 or 5
  /// entries. These entries will then be provided to [itemBuilder] to display
  /// the suggestions.
  final SuggestionsCallback suggestionsCallback;

  /// A button [Widget](https://docs.flutter.io/flutter/widgets/Widget-class.html) to be shown when new pattern is typed, which could be added to tag list.
  final Widget addButtonWidget;

  /// A [deleteIcon] is an [Icon](https://docs.flutter.io/flutter/widgets/Icon-class.html) used for deleting chips.
  final Icon deleteIcon;

  /// A [chipsColor] is a [Color](https://docs.flutter.io/flutter/dart-ui/Color-class.html) to be used as chips background.
  final Color chipsColor;

  /// A [chipsPadding] is a [EdgeInsetsGeometry](https://docs.flutter.io/flutter/painting/EdgeInsetsGeometry-class.html) for defining chips padding.
  final EdgeInsetsGeometry chipsPadding;

  /// Defines the font size of chips with [double](https://api.dartlang.org/stable/2.1.0/dart-core/double-class.html) value.
  final double chipsFontSize;

  /// A [chipsFontColor] is a [Color](https://docs.flutter.io/flutter/dart-ui/Color-class.html) to be used as chips font color.
  final Color chipsFontColor;

  /// Defines the font family [String](https://docs.flutter.io/flutter/dart-core/String-class.html).
  final String chipsFontFamily;

  /// Defines the spacing between chips with [double](https://api.dartlang.org/stable/2.1.0/dart-core/double-class.html) value.
  final double chipsSpacing;

  /// [WidgetBuilder](https://docs.flutter.io/flutter/widgets/WidgetBuilder.html) to build loading widget.
  final WidgetBuilder loadingBuilder;

  /// [WidgetBuilder](https://docs.flutter.io/flutter/widgets/WidgetBuilder.html) to build widget when no items are available.
  final WidgetBuilder noItemsFoundBuilder;

  final Duration animationDuration;

  /// Determine the [SuggestionBox]'s direction.
  ///
  /// If [AxisDirection.down], the [SuggestionBox] will be below the [TextField]
  /// and the [_SuggestionsList] will grow **down**.
  ///
  /// If [AxisDirection.up], the [SuggestionBox] will be above the [TextField]
  /// and the [_SuggestionsList] will grow **up**.
  ///
  /// [AxisDirection.left] and [AxisDirection.right] are not allowed.
  final AxisDirection direction;

  /// The value at which the [transitionBuilder] animation starts.
  ///
  /// This argument is best used with [transitionBuilder] and [animationDuration]
  /// to fully control the animation.
  ///
  /// Defaults to 0.25.
  final double animationStart;

  /// How far below the text field should the suggestions box be
  ///
  /// Defaults to 5.0
  final double suggestionsBoxVerticalOffset;

  /// If set to true, suggestions will be fetched immediately when the field is
  /// added to the view.
  ///
  /// But the suggestions box will only be shown when the field receives focus.
  /// To make the field receive focus immediately, you can set the `autofocus`
  /// property in the [textFieldConfiguration] to true
  ///
  /// Defaults to false
  final bool getImmediateSuggestions;

  /// If set to true, no loading box will be shown while suggestions are
  /// being fetched. [loadingBuilder] will also be ignored.
  ///
  /// Defaults to false.
  final bool hideOnLoading;

  /// If set to true, nothing will be shown if there are no results.
  /// [noItemsFoundBuilder] will also be ignored.
  ///
  /// Defaults to false.
  final bool hideOnEmpty;

  /// If set to true, nothing will be shown if there is an error.
  /// [errorBuilder] will also be ignored.
  ///
  /// Defaults to false.
  final bool hideOnError;

  /// If set to false, the suggestions box will stay opened after
  /// the keyboard is closed.
  ///
  /// Defaults to true.
  final bool hideSuggestionsOnKeyboardHide;

  /// If set to false, the suggestions box will show a circular
  /// progress indicator when retrieving suggestions.
  ///
  /// Defaults to true.
  final bool keepSuggestionsOnLoading;

  /// The duration to wait after the user stops typing before calling
  /// [suggestionsCallback]
  ///
  /// This is useful, because, if not set, a request for suggestions will be
  /// sent for every character that the user types.
  ///
  /// This duration is set by default to 300 milliseconds
  final Duration debounceDuration;

  /// Called when [suggestionsCallback] throws an exception.
  ///
  /// It is called with the error object, and expected to return a widget to
  /// display when an exception is thrown
  /// For example:
  /// ```dart
  /// (BuildContext context, error) {
  ///   return Text('$error');
  /// }
  /// ```
  ///
  /// If not specified, the error is shown in [ThemeData.errorColor](https://docs.flutter.io/flutter/material/ThemeData/errorColor.html)
  final ErrorBuilder errorBuilder;

  /// Called to display animations when [suggestionsCallback] returns suggestions
  ///
  /// It is provided with the suggestions box instance and the animation
  /// controller, and expected to return some animation that uses the controller
  /// to display the suggestion box.
  ///
  /// For example:
  /// ```dart
  /// transitionBuilder: (context, suggestionsBox, animationController) {
  ///   return FadeTransition(
  ///     child: suggestionsBox,
  ///     opacity: CurvedAnimation(
  ///       parent: animationController,
  ///       curve: Curves.fastOutSlowIn
  ///     ),
  ///   );
  /// }
  /// ```
  /// This argument is best used with [animationDuration] and [animationStart]
  /// to fully control the animation.
  ///
  /// To fully remove the animation, just return `suggestionsBox`
  ///
  /// If not specified, a [SizeTransition](https://docs.flutter.io/flutter/widgets/SizeTransition-class.html) is shown.
  final AnimationTransitionBuilder transitionBuilder;

  /// The decoration of the material sheet that contains the suggestions.
  ///
  /// If null, default decoration with an elevation of 4.0 is used
  final SuggestionsBoxDecoration suggestionsBoxDecoration;

  /// Creates a [FlutterTagging] Widget
  FlutterTagging({
    @required this.onChanged,
    @required this.textFieldDecoration,
    @required this.suggestionsCallback,
    @required this.addButtonWidget,
    this.deleteIcon = const Icon(Icons.cancel, size: 20.0),
    this.chipsColor,
    this.chipsPadding,
    this.chipsFontSize,
    this.chipsFontColor,
    this.chipsFontFamily,
    this.chipsSpacing = 5.0,
    this.loadingBuilder,
    this.noItemsFoundBuilder,
    this.animationStart: 0.25,
    this.animationDuration: const Duration(milliseconds: 500),
    this.getImmediateSuggestions: false,
    this.suggestionsBoxVerticalOffset: 5.0,
    this.direction: AxisDirection.down,
    this.hideOnLoading: false,
    this.hideOnEmpty: false,
    this.hideOnError: false,
    this.hideSuggestionsOnKeyboardHide: true,
    this.keepSuggestionsOnLoading: true,
    this.errorBuilder,
    this.suggestionsBoxDecoration: const SuggestionsBoxDecoration(),
    this.transitionBuilder,
    this.debounceDuration: const Duration(milliseconds: 300),
  })  : assert(suggestionsCallback != null),
        assert(animationStart != null &&
            animationStart >= 0.0 &&
            animationStart <= 1.0),
        assert(animationDuration != null),
        assert(debounceDuration != null),
        assert(suggestionsBoxDecoration != null),
        assert(suggestionsBoxVerticalOffset != null),
        assert(
            direction == AxisDirection.down || direction == AxisDirection.up);

  @override
  _FlutterTaggingState createState() => _FlutterTaggingState();
}

class _FlutterTaggingState extends State<FlutterTagging> {
  TextEditingController labeledController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  var labeledChips = <Widget>[];
  Map _selectedTagValues = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _labelInputForm(),
          _buildChips(),
        ],
      ),
    );
  }

  /// [_buildChips] builds the [Wrap](https://docs.flutter.io/flutter/widgets/Wrap-class.html) for selected chips.
  Widget _buildChips() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: widget.chipsSpacing,
      crossAxisAlignment: WrapCrossAlignment.start,
      runAlignment: WrapAlignment.start,
      children: labeledChips,
    );
  }

  /// [_labelInputForm] builds the [TypeAheadField](https://pub.dartlang.org/documentation/flutter_typeahead/latest/flutter_typeahead/flutter_typeahead-library.html)
  Widget _labelInputForm() {
    return TypeAheadField(
      getImmediateSuggestions: true,
      loadingBuilder: widget.loadingBuilder,
      noItemsFoundBuilder: widget.noItemsFoundBuilder,
      animationDuration: widget.animationDuration,
      animationStart: widget.animationStart,
      debounceDuration: widget.debounceDuration,
      direction: widget.direction,
      errorBuilder: widget.errorBuilder,
      hideOnEmpty: widget.hideOnEmpty,
      hideOnError: widget.hideOnError,
      hideOnLoading: widget.hideOnLoading,
      hideSuggestionsOnKeyboardHide: widget.hideSuggestionsOnKeyboardHide,
      keepSuggestionsOnLoading: widget.keepSuggestionsOnLoading,
      suggestionsBoxDecoration: widget.suggestionsBoxDecoration,
      suggestionsBoxVerticalOffset: widget.suggestionsBoxVerticalOffset,
      transitionBuilder: widget.transitionBuilder,
      textFieldConfiguration: TextFieldConfiguration(
        focusNode: _focusNode,
        controller: labeledController,
        decoration: widget.textFieldDecoration,
      ),
      suggestionsCallback: widget.suggestionsCallback,
      itemBuilder: (context, suggestion) {
        if (labeledChips != null) {
          for (var chips in labeledChips) {
            var tag = {
              'name': chips.key.toString().split("'")[1],
              'value': _selectedTagValues[chips.key.toString().split("'")[1]]
            };
            print(suggestion);
            print(tag);
            if (suggestion.toString() == tag.toString()) {
              return Container();
            }
          }
        }
        return ListTile(
          title: Text(suggestion['name']),
          trailing: suggestion['value'] == 0
              ? InkWell(
                  child: widget.addButtonWidget,
                  onTap: () {
                    setState(() {
                      _selectedTagValues[suggestion['name']] =
                          suggestion['value'];
                      labeledController.clear();
                      labeledChips.add(
                        Chip(
                          key: Key(suggestion['name']),
                          label: Text(
                            suggestion['name'],
                            style: TextStyle(
                                fontSize: widget.chipsFontSize,
                                color: widget.chipsFontColor,
                                fontFamily: widget.chipsFontFamily),
                          ),
                          labelPadding: widget.chipsPadding,
                          deleteIcon: widget.deleteIcon,
                          backgroundColor: widget.chipsColor,
                          onDeleted: () {
                            if (labeledChips.length > 0) {
                              for (var chips in labeledChips) {
                                if (chips.key
                                    .toString()
                                    .contains(suggestion['name'])) {
                                  setState(() {
                                    labeledChips.remove(chips);
                                    _selectedTagValues
                                        .remove(suggestion['name']);
                                    List<dynamic> tags = <dynamic>[];
                                    var tag;
                                    for (var chips in labeledChips) {
                                      tag = {
                                        'name':
                                            chips.key.toString().split("'")[1],
                                        'value': _selectedTagValues[
                                            chips.key.toString().split("'")[1]]
                                      };
                                      tags.add(tag);
                                    }
                                    widget.onChanged(tags);
                                  });
                                }
                              }
                            }
                          },
                        ),
                      );
                      List<dynamic> tags = <dynamic>[];
                      var tag;
                      for (var chips in labeledChips) {
                        tag = {
                          'name': chips.key.toString().split("'")[1],
                          'value': _selectedTagValues[
                              chips.key.toString().split("'")[1]]
                        };
                        tags.add(tag);
                      }
                      _focusNode.unfocus();
                      widget.onChanged(tags);
                    });
                  },
                )
              : null,
        );
      },
      onSuggestionSelected: (suggestion) {
        setState(() {
          if (suggestion['value'] != 0) {
            _buildSuggestions(suggestion);
          }
        });
      },
    );
  }

  /// [_buildSuggestions] builds the suggestions for [onSuggestionSelected] Callback.
  void _buildSuggestions(suggestion) {
    _selectedTagValues[suggestion['name']] = suggestion['value'];
    labeledController.clear();
    labeledChips.add(
      Chip(
        key: Key(suggestion['name']),
        label: Text(
          suggestion['name'],
          style: TextStyle(
              fontSize: widget.chipsFontSize,
              color: widget.chipsFontColor,
              fontFamily: widget.chipsFontFamily),
        ),
        labelPadding: widget.chipsPadding,
        deleteIcon: widget.deleteIcon,
        backgroundColor: widget.chipsColor,
        onDeleted: () {
          if (labeledChips.length > 0) {
            for (var chips in labeledChips) {
              if (chips.key.toString().contains(suggestion['name'])) {
                setState(() {
                  labeledChips.remove(chips);
                  _selectedTagValues.remove(suggestion['name']);
                  List<dynamic> tags = <dynamic>[];
                  var tag;
                  for (var chips in labeledChips) {
                    tag = {
                      'name': chips.key.toString().split("'")[1],
                      'value':
                          _selectedTagValues[chips.key.toString().split("'")[1]]
                    };
                    tags.add(tag);
                  }
                  widget.onChanged(tags);
                });
              }
            }
          }
        },
      ),
    );
    List<dynamic> tags = <dynamic>[];
    var tag;
    for (var chips in labeledChips) {
      tag = {
        'name': chips.key.toString().split("'")[1],
        'value': _selectedTagValues[chips.key.toString().split("'")[1]]
      };
      tags.add(tag);
    }
    widget.onChanged(tags);
  }
}
