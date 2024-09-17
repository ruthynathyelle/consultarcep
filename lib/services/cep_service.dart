import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:consultarcep/models/cep_model.dart';

class CepService {
  Future<CepModel?> buscarCep(String cep) async {
    final response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
    if (response.statusCode == 200) {
      return CepModel.fromJson(jsonDecode(response.body));
    } else {
      return null; 
    }
  }
}
