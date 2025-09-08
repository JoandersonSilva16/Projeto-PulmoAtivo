import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.home),
          ),
          title: Text('Bem vindo(a), usuário!'),
          centerTitle: true,
          backgroundColor: Color(0xFF0b6a8f),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.people),
            ),
          ],
        ),
        backgroundColor: Color(0xFF41e0e6),
        body: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.only(left: 100, right: 100),
                        backgroundColor: Color(0xFFd82424),
                      ),
                      child: Text('Medicamentos',
                        style: TextStyle (
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(left: 130, right: 130),
                    backgroundColor: Color(0xFF00bf63),
                  ),
                  child: Text('Horário',
                    style: TextStyle (
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),

                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left: 130, right: 120),
                      backgroundColor: Color(0xFF1f80ff)
                  ),
                  child: Text('Consultas',
                    style: TextStyle (
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left: 130, right: 120),
                      backgroundColor: Color(0xFF035752)
                  ),
                  child: Text('Ouvidoria',
                    style: TextStyle (
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
