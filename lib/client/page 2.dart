import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class client extends StatefulWidget {
  const client({super.key});

  @override
  State<client> createState() => _clientState();
}

class _clientState extends State<client> {
  TextEditingController name = TextEditingController();
  TextEditingController desp = TextEditingController();
  TextEditingController one = TextEditingController();
  TextEditingController two = TextEditingController();
  TextEditingController three = TextEditingController();
  TextEditingController four = TextEditingController();
  TextEditingController five = TextEditingController();
  TextEditingController six = TextEditingController();

  Future<bool>? _success;
  Future<bool> yes(String name, int desp,String one,
      String two,String three,String four,
      String five,int six)async{
    var res =await http.post(Uri.parse("http://catodotest.elevadosoftwares.com/Client/InsertClient"),
    headers:<String,String>{
      'Content-Type':'application/json; charset=utf-8'
    } ,
      body: jsonEncode(<String,dynamic>{
        "clientId": 0,
        "clientName": name,
        "phone": desp,
        "address": one,
        "gst": two,
        "website": three,
        "email": four,
        "contactPerson": five,
        "phoneNumber": six,
        "createdBy": 1
        })
    );
    return jsonDecode(res.body)["success"];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(child:
        ( _success == null? buildColumn():buildFuturebuilder()),
        )
      ],),
    );
  }
  Column buildColumn(){
    return Column(
      children: [
        TextFormField(controller: name,),
        TextFormField(controller: desp,),
        TextFormField(controller: one,),
        TextFormField(controller: two,),
        TextFormField(controller: three,),
        TextFormField(controller: four,),
        TextFormField(controller: five,),
        TextFormField(controller: six,),

        ElevatedButton(onPressed: (){
          setState(() {
            _success = yes(name.text,int.parse(desp.text),
            one.text,two.text,three.text,four.text,five.text,int.parse(six.text));
          });
        },
            child: Text(
          'save'
        ),)
      ],
    );
  }
  FutureBuilder buildFuturebuilder(){
    return FutureBuilder(
        future: _success,
        builder: (BuildContext context,snapshot) {
          if(snapshot.hasData){
            return Text('add successfully');
          } else if (snapshot.hasError){
            return Text('error');
          }return CircularProgressIndicator();


        });
  }
}
