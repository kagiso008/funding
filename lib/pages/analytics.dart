import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:funding/pages/landing_page.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  final SupabaseClient _client = Supabase.instance.client;

  // State variables to hold the data
  List<Map<String, dynamic>> _dataTable1 = [];
  List<Map<String, dynamic>> _dataTable2 = [];
  List<Map<String, dynamic>> _dataTable3 = [];
  bool _isLoading = true;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _message = 'Fetching data...';
    });

    try {
      final responseTable1 = await _client
          .from('daily_entry_counts') // Replace with your actual table name
          .select();

      final responseTable2 = await _client
          .from('most_frequent_average') // Replace with your actual table name
          .select();

      final responseTable3 = await _client
          .from('subject_counts') // Replace with your actual table name
          .select();

      setState(() {
        _dataTable1 = List<Map<String, dynamic>>.from(responseTable1);
        _dataTable2 = List<Map<String, dynamic>>.from(responseTable2);
        _dataTable3 = List<Map<String, dynamic>>.from(responseTable3);
        _message = '';
      });
    } catch (e) {
      setState(() {
        _message = 'Error: $e';
        _dataTable1 = [];
        _dataTable2 = [];
        _dataTable3 = [];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Function to build data tables
  Widget _buildTable(
      String title, List<Map<String, dynamic>> data, List<String> columns) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            Table(
              border: TableBorder.all(
                  color: Colors.grey, style: BorderStyle.solid, width: 1),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                  ),
                  children: columns
                      .map(
                        (column) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            column,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                      .toList(),
                ),
                ...data.map(
                  (row) => TableRow(
                    children: columns
                        .map(
                          (column) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(row[column].toString()),
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LandingPage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_message.isNotEmpty)
              Center(
                  child: Text(
                _message,
                style: const TextStyle(color: Colors.red),
              ))
            else ...[
              Expanded(
                child: ListView(
                  children: [
                    _buildTable('Daily Entry Counts', _dataTable1,
                        ['day', 'entry_count']),
                    _buildTable(
                        'Most Frequent Average', _dataTable2, ['average']),
                    _buildTable('Subject Counts', _dataTable3, [
                      'mathematics_count',
                      'english_count',
                      'accounting_count',
                      'physics_count'
                    ]),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _fetchData,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Colors.teal,
                  textStyle: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                child: const Text('Refresh Data'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
