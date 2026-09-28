import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biodata Form',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BioDataPage(),
    );
  }
}

class BioDataPage extends StatefulWidget {
  const BioDataPage({super.key});

  @override
  State<BioDataPage> createState() => _BioDataPageState();
}

class _BioDataPageState extends State<BioDataPage> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> _values = {};

  final List<Map<String, String>> _fields = [
    {'label': 'Position Desired', 'key': 'position'},
    {'label': 'Date', 'key': 'date'},
    {'label': 'Name', 'key': 'name'},
    {'label': 'Gender', 'key': 'gender'},
    {'label': 'City Address', 'key': 'cityAddress'},
    {'label': 'Provincial Address', 'key': 'provAddress'},
    {'label': 'Telephone', 'key': 'telephone'},
    {'label': 'Cellphone', 'key': 'cellphone'},
    {'label': 'E-mail Address', 'key': 'email'},
    {'label': 'Date of Birth', 'key': 'dob'},
    {'label': 'Birth Place', 'key': 'birthPlace'},
    {'label': 'Civil Status', 'key': 'civilStatus'},
    {'label': 'Citizenship', 'key': 'citizenship'},
    {'label': 'Height', 'key': 'height'},
    {'label': 'Weight', 'key': 'weight'},
    {'label': 'Religion', 'key': 'religion'},
    {'label': 'Spouse', 'key': 'spouse'},
    {'label': 'Occupation', 'key': 'occupation'},
    {'label': 'Name of Children', 'key': 'children'},
    {'label': "Father's Name", 'key': 'father'},
    {'label': "Mother's Name", 'key': 'mother'},
  ];

  @override
  void initState() {
    super.initState();
    for (var f in _fields) {
      _values[f['key']!] = '';
    }
  }

  void _saveForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      _showPreview();
    }
  }

  void _showPreview() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Biodata Preview'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: _fields.map((f) {
                final key = f['key']!;
                return ListTile(
                  dense: true,
                  title: Text(f['label']!),
                  subtitle: Text(_values[key]!.isEmpty ? '-' : _values[key]!),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionTitle(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BIO-DATA')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Personal Data'),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: _fields.map((f) {
                        final key = f['key']!;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(f['label']!),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 7,
                                child: TextFormField(
                                  initialValue: _values[key],
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                  ),
                                  onSaved: (val) => _values[key] = val?.trim() ?? '',
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _buildSectionTitle('Family Details'),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        // Add a couple of larger multi-line fields
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Permanent Address',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 2,
                          onSaved: (v) => _values['permanentAddress'] = v?.trim() ?? '',
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Educational Background',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                          onSaved: (v) => _values['education'] = v?.trim() ?? '',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _saveForm,
                      icon: const Icon(Icons.save),
                      label: const Text('Preview / Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
