import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?key=6ee018f2";

void main() async{
  runApp(MaterialApp(
    home: Home(),
  ));
}

Future<Map> getData() async{
  http.Response response = await http.get(request);
  return json.decode(response.body);
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Conversor"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return _buildMessage("Carregando dados..", Colors.black);
            default:
              if(snapshot.hasError){
                 return _buildMessage("erro ao carregar dados..", Colors.orange);
              }else{
                return _buildMessage("dados carregados com sucesso..", Colors.black);
              }
          }
        },
      ),
    );
  }//build

  Widget _buildMessage(String text, Color color){
    return Center(
      child: Text(text,
      style: TextStyle(color: color, fontSize: 25.0),
      textAlign: TextAlign.center,
      ),
    );
  }//_buildMessage
}//HomeState

