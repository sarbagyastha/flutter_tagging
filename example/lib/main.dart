import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

void main() => runApp(MyApp());

///
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Tagging Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MyHomePage(),
    );
  }
}

///
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedValuesJson = 'Nothing to show';
  List<Language> _selectedLanguages;

  @override
  void initState() {
    _selectedLanguages = [];
    super.initState();
  }

  @override
  void dispose() {
    _selectedLanguages.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Tagging Demo'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlutterTagging<Language>(
              initialItems: _selectedLanguages,
              textFieldConfiguration: TextFieldConfiguration(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.green.withAlpha(30),
                  hintText: 'Search Tags',
                  labelText: 'Select Tags',
                ),
              ),
              findSuggestions: LanguageService.getLanguages,
              additionCallback: (value) {
                return Language(
                  name: value,
                  position: 0,
                );
              },
              onAdded: (language) {
                // api calls here, triggered when add to tag button is pressed
                return Language();
              },
              configureSuggestion: (lang) {
                return SuggestionConfiguration(
                  title: Text(lang.name),
                  subtitle: Text(lang.position.toString()),
                  additionWidget: Chip(
                    avatar: Icon(
                      Icons.add_circle,
                      color: Colors.white,
                    ),
                    label: Text('Add New Tag'),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              configureChip: (lang) {
                return ChipConfiguration(
                  label: Text(lang.name),
                  backgroundColor: Colors.green,
                  labelStyle: TextStyle(color: Colors.white),
                  deleteIconColor: Colors.white,
                );
              },
              onChanged: () {
                setState(() {
                  _selectedValuesJson = _selectedLanguages
                      .map<String>((lang) => '\n${lang.toJson()}')
                      .toList()
                      .toString();
                  _selectedValuesJson =
                      _selectedValuesJson.replaceFirst('}]', '}\n]');
                });
              },
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: SyntaxView(
              code: _selectedValuesJson,
              syntax: Syntax.JAVASCRIPT,
              withLinesCount: false,
              syntaxTheme: SyntaxTheme.standard(),
            ),
          ),
        ],
      ),
    );
  }
}

/// LanguageService
class LanguageService {
  /// Mocks fetching language from network API with delay of 500ms.
  static Future<List<Language>> getLanguages(String query) async {
    await Future.delayed(Duration(milliseconds: 500), null);
    return <Language>[
      Language(name: 'JavaScript', position: 1),
      Language(name: 'Python', position: 2),
      Language(name: 'Java', position: 3),
      Language(name: 'PHP', position: 4),
      Language(name: 'C#', position: 5),
      Language(name: 'C++', position: 6),
    ]
        .where((lang) => lang.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

/// Language Class
class Language extends Taggable {
  ///
  final String name;

  ///
  final int position;

  /// Creates Language
  Language({
    this.name,
    this.position,
  });

  @override
  List<Object> get props => [name];

  /// Converts the class to json string.
  String toJson() => '''  {
    "name": $name,\n
    "position": $position\n
  }''';
}
