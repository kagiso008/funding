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
      final userMarksResponse = await _supabaseClient
          .from('user_marks')
          .select(
              'math_mark, math_level, math_type, home_language_mark, home_language_level, first_additional_language_mark, first_additional_language_level, second_additional_language_mark, second_additional_language_level, subject1, subject1_level, subject2, subject2_level, subject3, subject3_level, subject4, subject4_level, life_orientation_mark, life_orientation_level, home_language, first_additional_language, second_additional_language')
          .eq('user_id', _supabaseClient.auth.currentUser!.id)
          .single();

      final userMarks = userMarksResponse;

      final response = await _supabaseClient
          .from('universities')
          .select(
              'university_name, qualification, aps, english_hl, english_fal, maths, technical_math, maths_lit, physical_sciences, life_orientation, accounting, business_studies, economics, history, geography, tourism, civil_technology, egd, cat, it, electrical_technology, mechanical_technology')
          .lte('aps', aps);

      final List<Map<String, dynamic>> qualifiedCourses = [];

      // Mapping user subjects to university columns
      final subjectMapping = {
        'Physical Sciences': 'physical_sciences',
        'Accounting': 'accounting',
        'Business Studies': 'business_studies',
        'Economics': 'economics',
        'History': 'history',
        'Geography': 'geography',
        'Tourism': 'tourism',
        'Civil Technology': 'civil_technology',
        'Engineering Graphics and Design': 'egd',
        'Computer Applications Technology': 'cat',
        'Information Technology': 'it',
        'Electrical Technology': 'electrical_technology',
        'Mechanical Technology': 'mechanical_technology',
      };

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
        }

        if (hasEnglishFAL) {
          if ((userMarks['first_additional_language_level'] ?? 0) <
              (university['english_fal'] ?? 0)) {
            meetsRequirements = false;
          }
        }

        // Compare other subjects (subject1, subject2, etc.)
        for (int i = 1; i <= 4; i++) {
          final subject = userMarks['subject$i'];
          final subjectLevel = userMarks['subject${i}_level'];

          if (subject != null && subjectMapping.containsKey(subject)) {
            final universitySubject = university[subjectMapping[subject]];
            if ((subjectLevel ?? 0) < (universitySubject ?? 0)) {
              meetsRequirements = false;
              break;
            }
          }
        }

        // If requirements are met, add to the list
        if (meetsRequirements) {
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
              content: Text('No courses match your subjects and levels')),
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
