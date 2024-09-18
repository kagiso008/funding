import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CalculateApsWitsPage extends StatefulWidget {
  const CalculateApsWitsPage({super.key});

  @override
  _CalculateApsWitsPageState createState() => _CalculateApsWitsPageState();
}

class _CalculateApsWitsPageState extends State<CalculateApsWitsPage> {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  bool isLoading = true;
  Map<String, int?> userMarks = {};
  Map<String, String?> userSubjects = {};
  int? aps;
  String? mathType;

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
              'math_mark, subject1_mark, subject2_mark, subject3_mark, subject4_mark, home_language_mark, first_additional_language_mark, second_additional_language_mark, life_orientation_mark, math_type, subject1, subject2, subject3, subject4, home_language, first_additional_language, second_additional_language')
          .eq('user_id', _supabaseClient.auth.currentUser!.id)
          .single();

      final homeLanguageMark = response['home_language_mark'];
      final firstAdditionalLanguageMark =
          response['first_additional_language_mark'];
      final secondAdditionalLanguageMark =
          response['second_additional_language_mark'];

      setState(() {
        userMarks = {
          'math_mark': response['math_mark'],
          'subject1_mark': response['subject1_mark'],
          'subject2_mark': response['subject2_mark'],
          'subject3_mark': response['subject3_mark'],
          'subject4_mark': response['subject4_mark'],
          'home_language_mark': homeLanguageMark,
          'first_additional_language_mark': firstAdditionalLanguageMark,
          'second_additional_language_mark': secondAdditionalLanguageMark,
          'life_orientation_mark': response['life_orientation_mark'],
        };

        // Detect subjects
        userSubjects = {
          'subject1': response['subject1'],
          'subject2': response['subject2'],
          'subject3': response['subject3'],
          'subject4': response['subject4'],
          'home_language': response['home_language'],
          'first_additional_language': response['first_additional_language'],
          'second_additional_language': response['second_additional_language'],
        };

        mathType = response['math_type'];

        // Get the best two marks from the language subjects
        final languageMarks = [
          homeLanguageMark,
          firstAdditionalLanguageMark,
          secondAdditionalLanguageMark
        ].where((mark) => mark != null).toList();

        languageMarks
            .sort((a, b) => b!.compareTo(a!)); // Sort in descending order
        final topTwoLanguageMarks = languageMarks.take(2).toList();

        // Update userMarks with the top two language marks
        userMarks['best_language_mark1'] =
            topTwoLanguageMarks.isNotEmpty ? topTwoLanguageMarks[0] : null;
        userMarks['best_language_mark2'] =
            topTwoLanguageMarks.length > 1 ? topTwoLanguageMarks[1] : null;

        // Get the best three marks from subject1 to subject4
        final subjectMarks = [
          response['subject1_mark'],
          response['subject2_mark'],
          response['subject3_mark'],
          response['subject4_mark'],
        ].where((mark) => mark != null).toList();

        subjectMarks
            .sort((a, b) => b!.compareTo(a!)); // Sort in descending order
        final topThreeSubjectMarks = subjectMarks.take(3).toList();

        // Update userMarks with the top three subject marks
        userMarks['best_subject_mark1'] =
            topThreeSubjectMarks.isNotEmpty ? topThreeSubjectMarks[0] : null;
        userMarks['best_subject_mark2'] =
            topThreeSubjectMarks.length > 1 ? topThreeSubjectMarks[1] : null;
        userMarks['best_subject_mark3'] =
            topThreeSubjectMarks.length > 2 ? topThreeSubjectMarks[2] : null;

        aps = _calculateApsWits(userMarks, mathType);
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

  int _calculateApsWits(Map<String, int?> marks, String? mathType) {
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

    // Collect all relevant marks
    final allMarks = [
      marks['math_mark'],
      marks['best_subject_mark1'],
      marks['best_subject_mark2'],
      marks['best_subject_mark3'],
      marks['best_language_mark1'],
      marks['best_language_mark2'],
    ];

    // Remove null values and calculate APS points
    final validMarks = allMarks
        .where((mark) => mark != null)
        .map((mark) => getApsPoints(mark!))
        .toList();

    // Sort marks in descending order and take the best six
    validMarks.sort((a, b) => b.compareTo(a));
    final bestSixMarks = validMarks.take(6).toList();
    apsScore = bestSixMarks.reduce((a, b) => a + b);

    final mathMark = marks['math_mark'];

    // Apply math type bonus if applicable
    if (mathMark != null && mathType == 'Mathematics' && mathMark >= 60) {
      apsScore += 2;
    }

    // Handle Life Orientation mark
    final lifeOrientationMark = marks['life_orientation_mark'];
    if (lifeOrientationMark != null) {
      if (lifeOrientationMark >= 90) {
        apsScore += 4;
      } else if (lifeOrientationMark >= 80) {
        apsScore += 3;
      } else if (lifeOrientationMark >= 70) {
        apsScore += 2;
      } else if (lifeOrientationMark >= 60) {
        apsScore += 1;
      }
    }

    // Helper function to detect English subject
    int? getEnglishMark() {
      // Check if any of the subjects are "English"
      if (userSubjects['home_language']?.contains('English') == true) {
        return userMarks['home_language_mark'];
      } else if (userSubjects['first_additional_language']
              ?.contains('English') ==
          true) {
        return userMarks['first_additional_language_mark'];
      }
      return null; // If no subject is English
    }

    // Detect if English is a home or first additional language and apply bonus
    final englishMark = getEnglishMark();
    if (englishMark != null && englishMark >= 60) {
      apsScore += 2;
    }

    return apsScore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("YOUR APS AT WITS"),
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
                                'UNIVERSITY OF WITWATERSRAND',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.teal,
                                ),
                              ),
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
