import 'package:api_app/Model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScreenThree extends StatefulWidget {
  const ScreenThree({super.key});

  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserModel() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    // Decoding the response
    var data = jsonDecode(response.body.toString());

    // Check if the response is successful
    if (response.statusCode == 200) {
      // Loop through the data and add each user to the userList
      for (Map i in data) {
        userList.add(UserModel.fromJson(i as Map<String, dynamic>));
      }
      return userList;
    } else {
      // Return empty list or handle error appropriately
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('api course'),
          centerTitle: true,
          backgroundColor: Colors.amber,
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getUserModel(),
                  builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ReuseableRow(
                                        title: 'name',
                                        value: snapshot.data![index].name
                                            .toString()),
                                    ReuseableRow(
                                        title: 'username',
                                        value: snapshot.data![index].username
                                            .toString()),
                                    ReuseableRow(
                                        title: 'email',
                                        value: snapshot.data![index].email
                                            .toString()),
                                    ReuseableRow(
                                        title: 'address',
                                        value: snapshot
                                            .data![index].address.city
                                            .toString()),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }),
            )
          ],
        ));
  }
}

class ReuseableRow extends StatelessWidget {
  final String title;
  final String value;

  const ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
