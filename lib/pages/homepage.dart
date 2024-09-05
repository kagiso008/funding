import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:csv/csv.dart';

class Homepage extends StatefulWidget {
  final int minAverageMark;
  final int minMathMark;
  final int minPhysicsMark;
  final int minAccountingMark;
  final int minEnglishMark;

  const Homepage({
    super.key,
    required this.minAverageMark,
    required this.minMathMark,
    required this.minPhysicsMark,
    required this.minAccountingMark,
    required this.minEnglishMark,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> notes = [];
  int _loadedItemsCount = 5;
  static const int _itemsPerPage = 5;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreItems();
    }
  }

  void _loadMoreItems() {
    setState(() {
      _loadedItemsCount += _itemsPerPage;
    });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Stream<List<Map<String, dynamic>>> _getFilteredNotes() {
    return _supabaseClient
        .from('scholarships')
        .select()
        .lte('average', widget.minAverageMark)
        .lte('mathematics', widget.minMathMark)
        .lte('physics', widget.minPhysicsMark)
        .lte('accounting', widget.minAccountingMark)
        .lte('english', widget.minEnglishMark)
        .asStream()
        .map((response) {
      return (response as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> _pickAndUploadCSV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      final csvString = await file.readAsString();
      List<List<dynamic>> csvTable =
          const CsvToListConverter().convert(csvString);

      for (var i = 1; i < csvTable.length; i++) {
        Map<String, dynamic> row = {
          'scholarships': csvTable[i][0],
          'scholarship_url': csvTable[i][1]
        };

        final existingEntry = await _supabaseClient
            .from('scholarships')
            .select()
            .eq('scholarships', row['scholarships'])
            .eq('scholarship_url', row['scholarship_url'])
            .maybeSingle();

        if (existingEntry == null) {
          await _supabaseClient.from('scholarships').insert(row);
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('CSV file processed successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File selection canceled.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scholarships and Bursaries"),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: _pickAndUploadCSV,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.grey[100],
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _getFilteredNotes(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            notes = snapshot.data!;
            final visibleNotes = notes.take(_loadedItemsCount).toList();
            if (visibleNotes.isEmpty) {
              return const Center(
                child: Text(
                  "You do not qualify for any scholarship or bursary at the moment.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: visibleNotes.length + 1,
              itemBuilder: (context, index) {
                if (index == visibleNotes.length) {
                  return Visibility(
                    visible: _loadedItemsCount < notes.length,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: _loadMoreItems,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 20.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: const Text(
                            "View More",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Stack(
                  children: [
                    Card(
                      elevation: 2.0,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        title: Text(
                          visibleNotes[index]['scholarships']!,
                          style: const TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      bottom: 20,
                      child: FloatingActionButton(
                        onPressed: () {
                          _launchURL(visibleNotes[index]['scholarship_url']!);
                        },
                        backgroundColor: Colors.teal,
                        child: const Text("APPLY"),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
