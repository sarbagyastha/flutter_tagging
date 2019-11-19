// Copyright 2019 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'configurations.dart';
import 'taggable.dart';

class FlutterTagging<T extends Taggable> extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<List<T>> onChanged;
  final InputDecoration textFieldDecoration;
  final FutureOr<List<T>> Function(String) suggestionsCallback;
  final ChipConfiguration Function(T) configureChip;
  final SuggestionConfiguration Function(T) configureSuggestion;
  final T Function(String) additionCallback;
  final Widget Function(BuildContext) loadingBuilder;
  final Widget Function(BuildContext) noItemsFoundBuilder;
  final Widget Function(BuildContext, T) errorBuilder;
  final bool getImmediateSuggestions;
  final double spacing;
  final double runSpacing;

  /// Creates a [FlutterTagging] widget.
  FlutterTagging({
    this.controller,
    @required this.onChanged,
    @required this.textFieldDecoration,
    @required this.suggestionsCallback,
    @required this.configureChip,
    @required this.configureSuggestion,
    this.additionCallback,
    this.getImmediateSuggestions = false,
    this.errorBuilder,
    this.loadingBuilder,
    this.noItemsFoundBuilder,
    this.spacing = 0.0,
    this.runSpacing = 0.0,
  }) : assert(suggestionsCallback != null);

  @override
  _FlutterTaggingState<T> createState() => _FlutterTaggingState<T>();
}

class _FlutterTaggingState<T extends Taggable>
    extends State<FlutterTagging<T>> {
  TextEditingController _textController;
  FocusNode _focusNode = FocusNode();
  List<T> _selectedValues = [];
  T _additionItem;

  @override
  void initState() {
    super.initState();
    _textController = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TypeAheadField<T>(
          getImmediateSuggestions: widget.getImmediateSuggestions,
          errorBuilder: widget.errorBuilder,
          loadingBuilder: (context) {
            return widget.loadingBuilder ??
                SizedBox(
                  height: 3.0,
                  child: LinearProgressIndicator(),
                );
          },
          noItemsFoundBuilder: widget.noItemsFoundBuilder,
          textFieldConfiguration: TextFieldConfiguration<T>(
            focusNode: _focusNode,
            controller: _textController,
            decoration: widget.textFieldDecoration,
          ),
          suggestionsCallback: (query) async {
            var suggestions = await widget.suggestionsCallback(query);
            suggestions.removeWhere(
              (suggestion) => _selectedValues.contains(suggestion),
            );
            if (widget.additionCallback != null && query.isNotEmpty) {
              var additionItem = widget.additionCallback(query);
              if (!suggestions.contains(additionItem) &&
                  !_selectedValues.contains(additionItem)) {
                _additionItem = additionItem;
                suggestions.insert(0, additionItem);
              } else {
                _additionItem = null;
              }
            }
            return suggestions;
          },
          itemBuilder: (context, item) {
            var conf = widget.configureSuggestion(item);
            return ListTile(
              key: ObjectKey(item),
              title: conf.title,
              subtitle: conf.subtitle,
              leading: conf.leading,
              trailing: InkWell(
                splashColor: conf.splashColor ?? Theme.of(context).splashColor,
                borderRadius: conf.splashRadius,
                onTap: () {
                  setState(() {
                    _selectedValues.add(item);
                  });
                  widget.onChanged(_selectedValues);
                  _textController.clear();
                  _focusNode.unfocus();
                },
                child: Builder(
                  builder: (context) {
                    if (_additionItem != null && _additionItem == item) {
                      return conf.additionWidget;
                    } else {
                      return SizedBox(width: 0);
                    }
                  },
                ),
              ),
            );
          },
          onSuggestionSelected: (suggestion) {
            if (_additionItem != suggestion) {
              setState(() {
                _selectedValues.add(suggestion);
              });
              widget.onChanged(_selectedValues);
              _textController.clear();
            }
          },
        ),
        Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          runAlignment: WrapAlignment.start,
          runSpacing: widget.runSpacing,
          spacing: widget.spacing,
          children: _selectedValues.map<Widget>((item) {
            var conf = widget.configureChip(item);
            return Chip(
              label: conf.label,
              shape: conf.shape,
              avatar: conf.avatar,
              backgroundColor: conf.backgroundColor,
              clipBehavior: conf.clipBehavior,
              deleteButtonTooltipMessage: conf.deleteButtonTooltipMessage,
              deleteIcon: conf.deleteIcon,
              deleteIconColor: conf.deleteIconColor,
              elevation: conf.elevation,
              labelPadding: conf.labelPadding,
              labelStyle: conf.labelStyle,
              materialTapTargetSize: conf.materialTapTargetSize,
              padding: conf.padding,
              shadowColor: conf.shadowColor,
              onDeleted: () {
                setState(() {
                  _selectedValues.remove(item);
                });
                widget.onChanged(_selectedValues);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
