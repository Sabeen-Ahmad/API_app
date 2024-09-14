import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:api_app/Model/products_model.dart';

class ScreenFive extends StatefulWidget {
  const ScreenFive({super.key});

  @override
  State<ScreenFive> createState() => _ScreenFiveState();
}

class _ScreenFiveState extends State<ScreenFive> {
  Future<ProductsModel> getProductApi() async {//he getProductApi function sends an HTTP GET request to a specified API.
    final response = await http.get(
        Uri.parse('https://webhook.site/41117ba2-e76f-4e41-8c4f-c05698effa6e'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);//If the response is successful (status code 200), it parses the JSON response and maps it to a ProductsModel object. Otherwise, it throws an error.
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Course'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductsModel>(
              future: getProductApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .3,
                            width: MediaQuery.of(context).size.width * .3,
                            child: ListView.builder(
                              itemCount: snapshot.data!.data[index].images.length,
                              itemBuilder: (context, position) {
                                return Container(
                                  height: MediaQuery.of(context).size.height * .25,
                                  width: MediaQuery.of(context).size.width * .25,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        snapshot.data!.data[index].images[position].url.toString(),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        ],
      ),
    );
  }
}