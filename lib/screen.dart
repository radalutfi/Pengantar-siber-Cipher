import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'logic.dart';

Logic logic = Logic();
String result = '';

class Screen extends StatefulWidget {
  final String title;

  Screen({required this.title});

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController input = TextEditingController();
  TextEditingController key = TextEditingController();

  String selectedCipher = 'CAESAR CIPHER';

  List<TextInputFormatter> inputFormattin() {
    return <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
    ];
  }

  List<TextInputFormatter> keyFormattin() {
    if (selectedCipher == 'CAESAR CIPHER') {
      return <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp("[0-9]"))
      ];
    } else if (selectedCipher == 'VIGENERE CIPHER') {
      return <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02,
                    horizontal: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: DropdownButton<String>(
                    value: selectedCipher,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCipher = newValue!;
                      });
                    },
                    items: <String>['CAESAR CIPHER', 'VIGENERE CIPHER']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02,
                    horizontal: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: TextFormField(
                    controller: input,
                    inputFormatters: inputFormattin(),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Required';
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      hintText: 'Input',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02,
                    horizontal: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: TextFormField(
                    controller: key,
                    inputFormatters: keyFormattin(),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Required';
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      hintText: 'Kunci',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              if (selectedCipher == "CAESAR CIPHER") {
                                result = logic.caesar(
                                  input.text,
                                  int.parse(key.text),
                                  1,
                                );
                              } else if (selectedCipher == "VIGENERE CIPHER") {
                                result =
                                    logic.vigenere(input.text, key.text, 1);
                              }
                            });
                          }
                        },
                        icon: Icon(Icons.lock_outline),
                        label: Text('Enkripsi'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              if (selectedCipher == "CAESAR CIPHER") {
                                result = logic.caesar(
                                  input.text,
                                  int.parse(key.text),
                                  0,
                                );
                              } else if (selectedCipher == "VIGENERE CIPHER") {
                                result =
                                    logic.vigenere(input.text, key.text, 0);
                              }
                            });
                          }
                        },
                        icon: Icon(Icons.lock_open_rounded),
                        label: Text('Deskripsi'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: ListTile(
                    title: Text(
                      'OUTPUT',
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: ListTile(
                    title: Text(
                      result,
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
