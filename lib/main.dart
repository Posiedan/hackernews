import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/serialzer.dart';


Future<Album> fetchAlbum() async {
  final response =
      await http.get('https://hacker-news.firebaseio.com/v0/item/8863.json?print=pretty');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
 
  final String title;

  Album({ this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
     
      title: json['title'],
    );
  }
}
 


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Album> futureAlbum;
  List<int> liam;
  Future<Album> geib() async {
    final result=await http.get("https://hacker-news.firebaseio.com/v0/topstories.json?");
     liam=getintegers(result.body);
    final reso=await http.get("https://hacker-news.firebaseio.com/v0/item/${liam.first}.json");   
    return Album.fromJson(json.decode(reso.body));
  }
  
  

  @override
  void initState() {
    super.initState();
    futureAlbum = geib();
    
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}