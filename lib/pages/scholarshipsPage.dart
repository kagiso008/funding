import 'package:flutter/material.dart';
import 'package:funding/pages/landing_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> notes = [];
  int _loadedItemsCount = 5;
  static const int _itemsPerPage = 5;

  int? minAverageMark;
  int? minMathMark;
  int? minPhysicsMark;
  int? minAccountingMark;
  int? minEnglishMark;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchUserMarks(); // Fetch the user's marks when the page loads
  }

  void _fetchUserMarks() async {
    try {
      final response = await _supabaseClient
          .from(
              'user_marks') // Assuming you have a 'users' table where marks are stored
          .select(
              'average, math_mark, subject2_mark, subject3_mark, home_language_mark')
          .eq(
              'user_id',
              _supabaseClient
                  .auth.currentUser!.id) // Get the marks for the current user
          .single(); // Get a single user's data

      setState(() {
        minAverageMark = response['average'] ?? 0;
        minMathMark = response['math_mark'] ?? 0;
        minPhysicsMark = response['subject2_mark'] ?? 0;
        minAccountingMark = response['subject3_mark'] ?? 0;
        minEnglishMark = response['home_language_mark'] ?? 0;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user marks: $error')),
      );
    }
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

  Future<void> _addScholarship(String name, String url, int average,
      int mathematics, int physics, int accounting, int english) async {
    try {
      // Insert the scholarship into the 'scholarships' table
      final response = await _supabaseClient.from('scholarships').insert({
        'scholarships': name,
        'scholarship_url': url,
        'average': average,
        'mathematics': mathematics,
        'physics': physics,
        'accounting': accounting,
        'english': english,
      }); // Execute the query and get the response

      if (response.error == null) {
        // Success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Scholarship added successfully!')),
        );

        setState(() {
          // Optional: You can update the UI or fetch scholarships again here
        });
      } else {
        // Error from Supabase
        throw response.error!.message;
      }
    } catch (error) {
      // Handle any error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding scholarship: $error')),
      );
    }
  }

  Stream<List<Map<String, dynamic>>> _getFilteredNotes() {
    return _supabaseClient
        .from('scholarships')
        .select()
        .lte('average', minAverageMark ?? 0)
        .lte('mathematics', minMathMark ?? 0)
        .lte('physics', minPhysicsMark ?? 0)
        .lte('accounting', minAccountingMark ?? 0)
        .lte('english', minEnglishMark ?? 0)
        .asStream()
        .map((response) {
      return (response as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList();
    });
  }

  void _showAddScholarshipDialog() {
    String scholarshipName = '';
    String scholarshipURL = '';
    int average = 0;
    int mathematics = 0;
    int physics = 0;
    int accounting = 0;
    int english = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add New Scholarship"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Scholarship Name'),
                onChanged: (value) {
                  scholarshipName = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Scholarship URL'),
                onChanged: (value) {
                  scholarshipURL = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Average'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  average = int.tryParse(value) ?? 0;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mathematics'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  mathematics = int.tryParse(value) ?? 0;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Physics'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  physics = int.tryParse(value) ?? 0;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Accounting'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  accounting = int.tryParse(value) ?? 0;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'English'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  english = int.tryParse(value) ?? 0;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                if (scholarshipName.isNotEmpty && scholarshipURL.isNotEmpty) {
                  _addScholarship(scholarshipName, scholarshipURL, average,
                      mathematics, physics, accounting, english);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LandingPage()),
            );
          },
        ),
        title: const Text("Scholarships and Bursaries"),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddScholarshipDialog,
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
