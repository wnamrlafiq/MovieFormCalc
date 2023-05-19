import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Display extends StatelessWidget {
  final String name;
  final String email;
  final String gender;
  final String movie;
  final int quantity;
  final int total;

  const Display(
      {super.key,
      required this.name,
      required this.email,
      required this.gender,
      required this.movie,
      required this.quantity,
      required this.total});

  @override
  Widget build(BuildContext context) {
    var itemBuilder;

    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Movie Form"),
          backgroundColor: Color.fromARGB(255, 86, 86, 86),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              height: 50,
              //color: Colors.amber[600],
              child: Text('Name: \t $name'),
            ),
            Container(
              height: 50,
              //color: Colors.amber[500],
              child: Text('Email: \t $email'),
            ),
            Container(
              height: 50,
              //color: Colors.amber[400],
              child: Text('Gender: \t $gender'),
            ),
            Container(
              height: 50,
              //color: Colors.amber[400],
              child: Text('Movie: \t $movie'),
            ),
            Container(
              height: 50,
              //color: Colors.amber[400],
              child: Text('Quantity: \t $quantity'),
            ),
            Container(
              height: 50,
              //color: Colors.amber[400],
              child: Text('Total price: RM\t $total'),
            ),
          ],
        ));
  }
}
