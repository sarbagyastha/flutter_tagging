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
  });
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
      textFieldConfiguration: TextFieldConfiguration(
        focusNode: _focusNode,
        controller: labeledController,
        decoration: widget.textFieldDecoration,
      ),
      suggestionsCallback: widget.suggestionsCallback,
      itemBuilder: (context, suggestion) {
        if(labeledChips!=null){
          for (var chips in labeledChips) {
            var tag = {
              'name': chips.key.toString().split("'")[1],
              'value':
              _selectedTagValues[chips.key.toString().split("'")[1]]
            };
            print(suggestion);
            print(tag);
            if(suggestion.toString()==tag.toString()){
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
                    label: Text(suggestion['name'], style: TextStyle(fontSize: widget.chipsFontSize,color: widget.chipsFontColor,fontFamily: widget.chipsFontFamily),),
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
        label: Text(suggestion['name'], style: TextStyle(fontSize: widget.chipsFontSize,color: widget.chipsFontColor,fontFamily: widget.chipsFontFamily),),
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
