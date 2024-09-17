import 'package:flutter/material.dart';
import 'package:consultarcep/services/cep_service.dart';
import 'package:consultarcep/models/cep_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cepController = TextEditingController();
  CepModel? _cepModel;
  bool _isLoading = false;
  String? _error;

  void _buscarCep() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final service = CepService();
      final result = await service.buscarCep(_cepController.text);
      setState(() {
        _cepModel = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Página Inicial',
        style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Text('Consultar Cep'),
            SizedBox(height: 38),
            TextField(
              controller: _cepController,
              decoration: InputDecoration(
                labelText: 'Digite o CEP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white
              ),
              onPressed: _buscarCep,
              child: Text('Buscar'),
            ),
            SizedBox(height: 16.0),
            // Verificação de estado e exibição dos widgets apropriados
            _isLoading
                ? CircularProgressIndicator()
                : _error != null
                    ? Text('Erro: $_error')
                    : _cepModel != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Logradouro: ${_cepModel!.logradouro}'),
                              Text('Bairro: ${_cepModel!.bairro}'),
                              Text('Cidade: ${_cepModel!.cidade}'),
                              Text('UF: ${_cepModel!.uf}'),
                            ],
                          )
                        : Container(), // Fallback quando não há nada para mostrar
          ],
        ),
      ),
    );
  }
}
