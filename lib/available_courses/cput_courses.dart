import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CPUTCoursesPage extends StatefulWidget {
  final int aps; // Add this parameter to receive the APS score

  const CPUTCoursesPage({super.key, required this.aps}); // Update constructor

  @override
  _CPUTCoursesPageState createState() => _CPUTCoursesPageState();
}

class _CPUTCoursesPageState extends State<CPUTCoursesPage> {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  bool isLoading = true;
  List<Map<String, dynamic>> availableCourses = [];

  @override
  void initState() {
    super.initState();
    _fetchAvailableCourses(widget.aps); // Use the passed APS score
  }

  Future<void> _fetchAvailableCourses(int aps) async {
    try {
      // Fetch user's marks, levels, and language types from the user_marks table
      final userMarksResponse = await _supabaseClient
          .from('user_marks')
          .select(
              'math_mark, math_level, math_type, home_language_mark, home_language_level, first_additional_language_mark, first_additional_language_level, second_additional_language_mark, second_additional_language_level, subject1, subject1_mark, subject1_level, subject2, subject2_mark, subject2_level, subject3, subject3_mark, subject3_level, subject4, subject4_mark, subject4_level, life_orientation_mark, life_orientation_level, home_language, first_additional_language, second_additional_language')
          .eq('user_id', _supabaseClient.auth.currentUser!.id)
          .single();

      final userMarks = userMarksResponse;

      // Query the universities table and check if user's marks and levels match university requirements
      final response = await _supabaseClient
          .from('universities')
          .select(
              'university_name, qualification, aps, english_hl, english_fal, maths, technical_math, physical_sciences, life_orientation')
          .lte('aps', aps); // Filter by APS score

      final List<Map<String, dynamic>> qualifiedCourses = [];

      for (var university in response) {
        bool meetsRequirements = true;

        // Compare based on math_type
        if (userMarks['math_type'] == 'Mathematics') {
          if ((userMarks['math_level'] ?? 0) < (university['maths'] ?? 0)) {
            meetsRequirements = false;
          }
        } else if (userMarks['math_type'] == 'Mathematical Literacy') {
          if ((userMarks['math_level'] ?? 0) < (university['maths_lit'] ?? 0)) {
            meetsRequirements = false;
          }
        } else if (userMarks['math_type'] == 'Technical Mathematics') {
          if ((userMarks['math_level'] ?? 0) <
              (university['technical_math'] ?? 0)) {
            meetsRequirements = false;
          }
        }

        // Check English requirements
        bool hasEnglishHL = userMarks['home_language']
                ?.toString()
                .toLowerCase()
                .contains('english') ??
            false;
        bool hasEnglishFAL = userMarks['first_additional_language']
                ?.toString()
                .toLowerCase()
                .contains('english') ??
            false;

        if (hasEnglishHL) {
          if ((userMarks['home_language_level'] ?? 0) <
              (university['english_hl'] ?? 0)) {
            meetsRequirements = false;
          }
        } else {
          meetsRequirements = false;
        }

        if (hasEnglishFAL) {
          if ((userMarks['first_additional_language_level'] ?? 0) <
              (university['english_fal'] ?? 0)) {
            meetsRequirements = false;
          }
        } else {
          meetsRequirements = false;
        }
        // Continue checking other subjects and marks
        if (meetsRequirements &&
            (userMarks['subject1_mark'] ?? 0) >=
                (university[userMarks['subject1']] ?? 0) &&
            (userMarks['subject1_level'] ?? 0) >=
                (university['subject1_level'] ?? 0) &&
            (userMarks['subject2_mark'] ?? 0) >=
                (university[userMarks['subject2']] ?? 0) &&
            (userMarks['subject2_level'] ?? 0) >=
                (university['subject2_level'] ?? 0) &&
            (userMarks['subject3_mark'] ?? 0) >=
                (university[userMarks['subject3']] ?? 0) &&
            (userMarks['subject3_level'] ?? 0) >=
                (university['subject3_level'] ?? 0) &&
            (userMarks['subject4_mark'] ?? 0) >=
                (university[userMarks['subject4']] ?? 0) &&
            (userMarks['subject4_level'] ?? 0) >=
                (university['subject4_level'] ?? 0) &&
            (userMarks['life_orientation_mark'] ?? 0) >=
                (university['life_orientation'] ?? 0) &&
            (userMarks['life_orientation_level'] ?? 0) >=
                (university['life_orientation_level'] ?? 0)) {
          // If all subject marks and levels meet university requirements, add to the list
          qualifiedCourses.add(university);
        }
      }

      setState(() {
        availableCourses = qualifiedCourses;
        isLoading = false;
      });

      if (availableCourses.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('No courses match your subjects, marks, and levels')),
        );
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching available courses: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses you qualify for"),
        backgroundColor: Colors.teal,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : availableCourses.isEmpty
              ? const Center(child: Text('No courses available for your APS'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: availableCourses.length,
                  itemBuilder: (context, index) {
                    final course = availableCourses[index];
                    return Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course['qualification'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'University: ${course['university_name']}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'APS Required: ${course['aps']}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
