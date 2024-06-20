import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Triângulo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TrianguloCalculadora(),
    );
  }
}

class TrianguloCalculadora extends StatefulWidget {
  @override
  _TrianguloCalculadoraState createState() => _TrianguloCalculadoraState();
}

class _TrianguloCalculadoraState extends State<TrianguloCalculadora> {
  TextEditingController baseController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String resultado = "";
  bool isLoading = false;

  void calcularArea() {
    setState(() {
      isLoading = true;
    });

    // Simula um processamento demorado
    Future.delayed(Duration(seconds: 2), () {
      double base = double.tryParse(baseController.text) ?? 0.0;
      double altura = double.tryParse(alturaController.text) ?? 0.0;

      double area = 0.5 * base * altura;

      setState(() {
        resultado = "Área do Triângulo: $area";
        isLoading = false;
      });

      // Fecha a tela de carregamento
      Navigator.of(context, rootNavigator: true).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Triângulo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: baseController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Base do Triângulo'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Altura do Triângulo'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Row(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 16),
                          Text("Processando, aguarde..."),
                        ],
                      ),
                    );
                  },
                );

                calcularArea();
              },
              child: Text('Calcular Área'),
            ),
            SizedBox(height: 16),
            if (isLoading) CircularProgressIndicator() else Text(resultado),
          ],
        ),
      ),
    );
  }
}
