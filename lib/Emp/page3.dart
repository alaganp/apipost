import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class empo extends StatefulWidget {
  const empo({super.key});

  @override
  State<empo> createState() => _empoState();
}

class _empoState extends State<empo> {
  TextEditingController catname = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController one = TextEditingController();
  TextEditingController two = TextEditingController();
  TextEditingController three = TextEditingController();


  Future<bool>? _success;
  Future<bool> addcat(String catname,int des,String one,String two,String three) async {
    var res = await http.post(
        Uri.parse("http://catodotest.elevadosoftwares.com/Employee/InsertEmployee"),
        headers: <String,String>{
          'Content-Type':'application/json; charset=utf-8'
        },
        body: jsonEncode(<String,dynamic>{

            "employeeId": 0,
            "employeeName": catname,
            "mobile": des,
            "userName": one,
            "password": two,
            "confirmPassword": three,
            "createdBy": 1

        })
    );
    return jsonDecode(res.body)["success"];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: (_success == null ? buildColumn() : buildFuturebuilder()),
          )
        ],
      ),
    );
  }

  Column buildColumn(){
    return Column(
      children: [
        TextFormField(controller: catname,),
        TextFormField(controller: des,),
        TextFormField(controller: one,),
        TextFormField(controller: two,),
        TextFormField(controller: three,),
        ElevatedButton(
          onPressed: (){
            setState(() {
              _success = addcat(catname.text, int.parse(des.text),
              one.text,two.text,three.text);
            });
          },
          child: Text("save"),
        )
      ],
    );
  }

  FutureBuilder buildFuturebuilder(){
    return FutureBuilder(
        future: _success,
        builder: (BuildContext context, snapshot){
          if(snapshot.hasData){
            return Text("Added successfully");
          } else if(snapshot.hasError){
            return Text("error");
          } return CircularProgressIndicator();
        }
    );
  }
}
