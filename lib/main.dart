import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List data = [];

  Future<void> fetchdata() async {
    final res = await http.get(Uri.parse("https://reqres.in/api/users?page=1"));
    print("API Method");
    print(res.body.toString());

    setState(() {
      data = json.decode(res.body)['data'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text("API_VIEW"),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    data += [
                      {
                        "id": data.length + 1,
                        "email": "emma.wong@reqres.in",
                        "first_name": "Emma",
                        "last_name": "Wong",
                        "avatar": "https://reqres.in/img/faces/3-image.jpg"
                      }
                    ];
                  });
                },
                icon: Icon(Icons.add_outlined))
          ],
        ),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(data[index]['avatar']),
                ),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      data.removeWhere(
                          (ashok) => ashok["id"] == data[index]['id']);
                    });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                ),
                title: Text(data[index]['first_name']),
                subtitle: Text(data[index]["email"]),
              );
            }),
      ),
    );
  }
}
