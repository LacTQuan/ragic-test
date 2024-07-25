import 'package:flutter/material.dart';
import 'package:ragic/src/services/ragic.service.dart';

class InsertDataScreen extends StatefulWidget {
  @override
  _InsertDataScreenState createState() => _InsertDataScreenState();
}

class _InsertDataScreenState extends State<InsertDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _insertData() async {
    if (_formKey.currentState!.validate()) {
      Map<String, String> data = {
        '1000006': _nameController.text,
        '1000007': _emailController.text,
      };
      await RagicApi.createRecord(data);
      _nameController.clear();
      _emailController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Record inserted successfully')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Insert Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _insertData,
                child: Text('Insert Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
