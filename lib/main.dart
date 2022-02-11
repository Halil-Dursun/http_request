import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Http Request'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return const Center(child: CircularProgressIndicator(),);
            }else{
              return ListView.builder(shrinkWrap: true,scrollDirection: Axis.vertical,itemCount: snapshot.data.length,itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    title: Text('${snapshot.data[index].name}'),
                    subtitle: Text('${snapshot.data[index].username}'),
                    trailing: Text('${snapshot.data[index].email}'),
                  ),
                );
              });
            }
          },
        ),
      ),
    );
  }

   Future<List<User>> getData() async{
    Uri url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    List<User> _users = [];
    for(var value in data){
      User user = User(username: value['username'], name: value['name'], email: value['email']);
      _users.add(user);
    }
    return _users;
  }
}

class User{
  String name,username,email;
  
  User({required this.username,required this.name,required this.email});
}
