
import 'dart:convert';
// importa o pacote http
import 'package:http/http.dart' as http;

class CurriculoApi {
  final String baseUrl;
  const CurriculoApi(this.baseUrl);


  Future<Map<String, dynamic>> buscarCurriculo(int id) async {
    final uri = Uri.parse('$baseUrl/api/curriculos/$id');

    try {
      final resposta = await http.get(uri).timeout(const Duration(seconds: 10)
      );

      if (resposta.statusCode == 200) {
        final dados =  jsonDecode(resposta.body);
        if(dados is! Map<String, dynamic>) {
          throw Exception('Formato de dados inválido');
        }
        return dados;
      }
      if (resposta.statusCode == 404) {
        throw Exception('Currículo não encontrado');
      }
      throw Exception('Erro HTTP: ${resposta.statusCode}');
    } catch (erro) {
      throw Exception('Erro ao buscar currículo: $erro');
    }
  }
}