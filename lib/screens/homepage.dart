import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:api_calling/screens/models/modellist.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<LeadModel> leads = [];
  bool isLoading = true; // Added a boolean to track loading state

  Future<List<LeadModel>> fetchData() async {
    final response = await http.post(
      Uri.parse('https://api.thenotary.app/lead/getLeads'),
      body: json.encode({"notaryId": "643074200605c500112e0902"}),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<LeadModel> leadData = List<LeadModel>.from(
          data['leads'].map((lead) => LeadModel.fromJson(lead)));
      setState(() {
        leads = leadData;
        isLoading = false; // Data loaded, set loading to false
      });
      return leadData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left), 
          iconSize: 35,
          onPressed: () {
            SystemNavigator.pop(); 
          },
        ),
        title: const Text('W E L C O M E ! !'),
        backgroundColor: Color.fromARGB(255, 78, 138, 163),
        shadowColor: Color.fromARGB(255, 56, 121, 175),
      ),
      backgroundColor: Colors.yellow[50],
      body:
      
       isLoading
          ?const  Center(
             
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Color.fromARGB(255, 86, 157, 207)),
              ),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 4, 
  shadowColor: Color.fromARGB(255, 76, 134, 145), 
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(14)),
                        
                    child: InkWell(

                      onTap: () {
                        print('wait');
                      },
                      child: Column(
                        
                        children: <Widget>[
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Name: ${leads[index].name}"),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Email: ${leads[index].email}"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                itemCount: leads.length,
              ),
            ),
    );
  }
}
