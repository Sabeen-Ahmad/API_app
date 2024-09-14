import 'package:api_app/Model/postsmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'
    as http; //http is the alias you’ve given to the http package, making it clear that get is coming from this package.
import 'dart:convert'; //provides utilities for encoding and decoding JSOn

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Postsmodel> postList = []; // Create an empty list to store posts

  Future<List<Postsmodel>> getPostApi() async {
    // Make an HTTP GET request to get posts from the API
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Decode the JSON response into a Dart object (list)
      var data = jsonDecode(response.body.toString());//This line of code converts the JSON string from the HTTP response body into a Dart object. This Dart object can be used to access and manipulate the data that was retrieved from the API.

      // Loop through the list of posts (data) and convert each item into a Postsmodel object
      for (Map i in data) {//fromJson This method is typically defined in a class to facilitate creating instances from JSON data.
        postList.add(Postsmodel.fromJson(i as Map<String,//add.This method adds the newly created Postsmodel instance to the postList.
            dynamic>)); // Add the post to postList//i as Map<String, dynamic> ensures that i is treated as a map with string keys and dynamic values, which is what your Postsmodel.fromJson() method expects.
      }

      return postList; // After all posts are added, return the complete postList
    } else {
      return postList; // If the request fails, return the empty list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Integration'),
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {//allows you to handle various states of asynchronous data and build your UI accordingly.
                if (!snapshot.hasData) {
                  return Text('loading');
                } else {
                  return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Title:\n' +
                                    postList[index].title.toString()),
                                Text('Description:\n' +
                                    postList[index].body.toString()),
                              ],
                            ),
                          ),
                        );
                      });
                }
              }),
        )
      ]),
    );
  }
}
