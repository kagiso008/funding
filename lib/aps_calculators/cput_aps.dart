import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:funding/available_courses/cput_courses.dart';

class CalculateApsCPUTPage extends StatefulWidget {
  const CalculateApsCPUTPage({super.key});

  @override
  _CalculateApsCPUTPageState createState() => _CalculateApsCPUTPageState();
}

class _CalculateApsCPUTPageState extends State<CalculateApsCPUTPage> {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  bool isLoading = true;
  Map<String, int?> userMarks = {};
  int? aps;

  @override
  void initState() {
    super.initState();
    _fetchUserMarks();
  }

  Future<void> _fetchUserMarks() async {
    try {
      final response = await _supabaseClient
          .from('user_marks')
          .select(
              'math_mark, subject1_mark, subject2_mark, subject3_mark, subject4_mark, home_language_mark, first_additional_language_mark, second_additional_language_mark,life_orientation_mark')
          .eq('user_id', _supabaseClient.auth.currentUser!.id)
          .single();

      setState(() {
        userMarks = {
          'math_mark': response['math_mark'],
          'subject1_mark': response['subject1_mark'],
          'subject2_mark': response['subject2_mark'],
          'subject3_mark': response['subject3_mark'],
          'subject4_mark': response['subject4_mark'],
          'home_language_mark': response['home_language_mark'],
          'first_additional_language_mark':
              response['first_additional_language_mark'],
          'second_additional_language_mark':
              response['second_additional_language_mark'],
          'life_orientation_mark': response['life_orientation_mark']
        };
        aps = _CalculateApsCPUT(userMarks);
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

  int _CalculateApsCPUT(Map<String, int?> marks) {
    int apsScore = 0;

    // Helper function to get APS points based on the mark
    int getApsPoints(int mark) {
      if (mark >= 90) return 8;
      if (mark >= 80) return 7;
      if (mark >= 70) return 6;
      if (mark >= 60) return 5;
      if (mark >= 50) return 4;
      if (mark >= 40) return 3;
      return 0; // Return 0 for marks below 40
    }

    // Add math_mark
    if (marks['math_mark'] != null) {
      apsScore += getApsPoints(marks['math_mark']!);
    }

    // For subjects (subject1_mark, subject2_mark, subject3_mark, subject4_mark), take the best three marks
    final subjectMarks = [
      marks['subject1_mark'],
      marks['subject2_mark'],
      marks['subject3_mark'],
      marks['subject4_mark'],
    ];

    // Sort subjects in descending order and take the best three
    subjectMarks.sort((a, b) => (b ?? 0).compareTo(a ?? 0));

    final bestThreeSubjects = subjectMarks.take(3);
    for (var mark in bestThreeSubjects) {
      if (mark != null) {
        apsScore += getApsPoints(mark);
      }
    }

    // For languages, take the best two marks between home_language_mark, first_additional_language_mark, and second_additional_language_mark
    final languageMarks = [
      marks['home_language_mark'],
      marks['first_additional_language_mark'],
      marks['second_additional_language_mark'],
    ];

    // Sort language marks in descending order and take the two highest
    languageMarks.sort((a, b) => (b ?? 0).compareTo(a ?? 0));

    final bestTwoLanguages = languageMarks.take(2);
    for (var mark in bestTwoLanguages) {
      if (mark != null) {
        apsScore += getApsPoints(mark);
      }
    }

    // Add life_orientation_mark if it exists
    if (marks['life_orientation_mark'] != null) {
      apsScore += getApsPoints(marks['life_orientation_mark']!);
    }

    return apsScore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("YOUR APS AT CPUT"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 242, 243, 243),
              Color.fromARGB(255, 241, 241, 241)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              const Text(
                                'Your APS Score',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                aps != null
                                    ? aps.toString()
                                    : 'Error calculating APS',
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'UNIVERSITY OF Cape Peninsula University of Technology',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.teal,
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    // Pass the APS score to CPUTCoursesPage
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CPUTCoursesPage(aps: aps!),
                                      ),
                                    );
                                  },
                                  child: const Text("available courses"))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.teal,
                          backgroundColor: Colors.tealAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 15.0,
                          ),
                        ),
                        child: const Text(
                          'Go Back',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
