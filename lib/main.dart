// ignore_for_file: prefer_final_fields, unused_field, prefer_const_constructors

import 'package:flutter/material.dart';

void main() => runApp(ImcApp());

//classes do aplicativo e classe com os dados para o calculo do IMC
class ImcApp extends StatefulWidget {
  const ImcApp({Key? key}) : super(key: key);
  @override
  _ImcApp createState() => _ImcApp();
}

class Imc {
  double altura = 0;
  double peso = 0;
  String nome = "";
  String classificacao = "";
  double resultado = 0;

  double calcImc() {
    return peso / (altura * altura);
  }
}

class _ImcApp extends State {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Imc _imc = Imc();

  @override
  //layout
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 1,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Calculadora de IMC"),
              bottom:
                  TabBar(tabs: const [Tab(icon: Icon(Icons.fitness_center))]),
            ),
            body: Container(
              padding: const EdgeInsets.all(50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (String? inValue) {
                        if (inValue!.isEmpty) {
                          return "Informe o seu nome: ";
                        }
                        return null;
                      },
                      onSaved: (String? inValue) {
                        _imc.nome = (inValue!);
                      },
                      decoration: const InputDecoration(
                          hintText: "Ex.: Maria", labelText: "Nome"),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (String? inValue) {
                        if (inValue!.isEmpty) {
                          return "Informe sua alutura em metros: ";
                        }
                        return null;
                      },
                      onSaved: (String? inValue) {
                        _imc.altura = double.parse(inValue!);
                      },
                      decoration: const InputDecoration(
                          hintText: "Ex.: 1.75", labelText: "Altura"),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (String? inValue) {
                        if (inValue!.isEmpty) {
                          return "Informe o seu peso: ";
                        }
                        return null;
                      },
                      onSaved: (String? inValue) {
                        _imc.peso = double.parse(inValue!);
                      },
                      decoration: const InputDecoration(
                          hintText: "EX.: 73.5", labelText: "Peso"),
                    ),
                    ElevatedButton(
                        child: Text("Calcular"),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            setState(() {
                              _imc.resultado = _imc.calcImc();
                              if (_imc.resultado < 18) {
                                _imc.classificacao =
                                    " Ol??, ${_imc.nome}! \n seu IMC ?? ${_imc.resultado} \n Classifica??ao: IMC baixo \n Resultado: Poss??vel subnutri????o";
                              } else if ((_imc.resultado > 20) &&
                                  (_imc.resultado < 25)) {
                                _imc.classificacao =
                                    " Ol??, ${_imc.nome}! \n seu IMC ?? ${_imc.resultado} \n Classifica??ao: IMC normal \n Resultado: ??ndice de Massa Corp??rea Saud??vel";
                              } else if (_imc.resultado > 25) {
                                _imc.classificacao =
                                    " Ol??, ${_imc.nome}! \n seu IMC ?? ${_imc.resultado} \n Classifica??ao: IMC alto \n Resultado: Poss??vel sobrepeso";
                              }
                            });
                          }
                        }),
                    // Text(
                    //"Ol??, ${_imc.nome}, seu resultado ?? ${_imc.resultado} e sua classifica??ao encontra-se abaixo:"),
                    Text(_imc.classificacao)
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
