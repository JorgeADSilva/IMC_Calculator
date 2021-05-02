import 'package:conversor/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Body mass index (BMI | IMC)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Body mass index (BMI | IMC)'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _info = Constants.info;
  IconData imcResultIcon = Icons.paste_outlined;
  Color imcResultColor = Colors.teal;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController weigthController = TextEditingController();
  TextEditingController heigthController = TextEditingController();

  void _calculateIMC() {
    setState(() {
      double weigth = double.parse(weigthController.text);
      double heigth = double.parse(heigthController.text) / 100;
      double imc = weigth / (heigth * heigth);
      print(imc);
      if (imc < 18.6) {
        _info = 'Abaixo do Peso (${imc.toStringAsPrecision(3)})';
        imcResultIcon = Icons.arrow_downward;
        imcResultColor = Colors.red;
      } else if (imc >= 18.6 && imc < 24.9) {
        _info = 'Peso Ideal (${imc.toStringAsPrecision(3)})';
        imcResultIcon = Icons.check_circle;
        imcResultColor = Colors.green;
      } else if (imc >= 24.9 && imc < 29.9) {
        _info = 'Levemente Acima do Peso (${imc.toStringAsPrecision(3)})';
        imcResultIcon = Icons.warning;
        imcResultColor = Colors.amber;
      } else if (imc >= 29.9 && imc < 34.9) {
        _info = 'Obesidade Grau I (${imc.toStringAsPrecision(3)})';
        imcResultIcon = Icons.dangerous;
        imcResultColor = Colors.orange;
      } else if (imc >= 34.9 && imc < 39.9) {
        _info = 'Obesidade Grau II (${imc.toStringAsPrecision(3)})';
        imcResultIcon = Icons.dangerous;
        imcResultColor = Colors.purple;
      } else if (imc >= 40) {
        _info = 'Obesidade Grau III (${imc.toStringAsPrecision(3)})';
        imcResultIcon = Icons.dangerous;
        imcResultColor = Colors.red;
      }
    });
  }

  void _resetFields() {
    weigthController.text = "";
    heigthController.text = "";

    imcResultIcon = Icons.calculate;
    imcResultColor = Colors.teal;
    setState(() {
      _info = Constants.info;
      _formKey = GlobalKey<FormState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Icon(Icons.add_moderator),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                      child: Icon(Icons.restore),
                    ),
                    onTap: _resetFields,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.teal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Weigth (kg)",
                      labelStyle: TextStyle(color: Colors.teal)),
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black),
                  controller: weigthController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Missing Weight";
                    }
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10, left: 20.0, right: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Heigth (cm)",
                      labelStyle: TextStyle(color: Colors.teal)),
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black),
                  controller: heigthController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Missing Height";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 50, left: 50),
                child: Card(
                  color: imcResultColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Result",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Icon(
                        imcResultIcon,
                        color: Colors.white,
                        size: 80,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          _info,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState.validate()) _calculateIMC();
        },
        tooltip: 'Calculate IMC',
        child: Icon(Icons.calculate),
      ),
    );
  }
}
