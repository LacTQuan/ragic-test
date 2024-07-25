import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:ragic/src/services/ragic.service.dart';

class GetDataScreen extends StatefulWidget {
  @override
  _GetDataScreenState createState() => _GetDataScreenState();
}

class _GetDataScreenState extends State<GetDataScreen> {
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response = await RagicApi.readRecords();
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<Map<String, dynamic>> records = data.values.map((record) {
        return {
          'Name': record['Name'],
          'Email': record['Email'],
          'Avatar': record['Avatar'],
        };
      }).toList();
      setState(() {
        _data = records;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Get Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _data.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  final record = _data[index];
                  return Card(
                    child: ListTile(
                      title: Text(record['Name'] ?? 'No Name'),
                      subtitle: Text(record['Email'] ?? 'No Email'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
