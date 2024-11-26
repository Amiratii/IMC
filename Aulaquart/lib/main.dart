import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ImcCalculator(),
    debugShowCheckedModeBanner: false,
  ));
}

class ImcCalculator extends StatefulWidget {
  @override
  _ImcCalculatorState createState() => _ImcCalculatorState();
}

class _ImcCalculatorState extends State<ImcCalculator> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String _result = "";

  void _reset() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _result = "";
    });
  }

  void _calculateImc() {
    setState(() {
      double peso = double.parse(pesoController.text.replaceAll(',', '.'));
      double altura = double.parse(alturaController.text.replaceAll(',', '.')) /
          100; // Convert cm to meters

      if (altura <= 0 || peso <= 0) {
        _result = "Entrada inválida. Por favor insira peso e altura válidos.";
        return;
      }

      double imc = peso / (altura * altura);
      String interpretation = _getInterpretation(imc);
      _result = "Seu imc é:  $interpretation ";
    });
  }

  String _getInterpretation(double imc) {
    if (imc < 18.5) {
      return "Você está abaixo do peso.";
    } else if (imc < 25) {
      return "Você está com peso normal.";
    } else if (imc < 30) {
      return "Você está acima do peso.";
    } else {
      return "Você é obeso.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculador IMC",
          style: TextStyle(color: Color(0xff350202)),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber[900],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh, color: Color(0xff3d1d1d)),
            onPressed: _reset,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person,
                size: 150.0,
                color: Colors.amber[900],
              ),
              TextFormField(
                controller: pesoController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Digite seu peso.";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.grey[900]),
                ),
                style: TextStyle(color: Colors.amber[900], fontSize: 26.0),
              ),
              TextFormField(
                controller: alturaController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Digite sua altura (cm).";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.grey[900]),
                ),
                style: TextStyle(color: Colors.amber[900], fontSize: 26.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: _calculateImc, // Fixed error: added onPressed
                    child: Text(
                      "Calcular imc",
                      style:
                          TextStyle(color: Color(0xff3b1f1f), fontSize: 26.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[900],
                    ),
                  ),
                ),
              ),
              Text(
                _result, // Display the result of BMI calculation
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
