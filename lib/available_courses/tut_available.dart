import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TutCoursesPage extends StatefulWidget {
  const TutCoursesPage({super.key});

  @override
  _TutCoursesPageState createState() => _TutCoursesPageState();
}

class _TutCoursesPageState extends State<TutCoursesPage> {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  bool isLoading = true;
  int? userAps;
  List<Map<String, dynamic>> availableCourses = [];

  @override
  void initState() {
    super.initState();
    _fetchUserAps();
  }

  Future<void> _fetchUserAps() async {
    try {
      // Fetch user APS from user_marks table
      final response = await _supabaseClient
          .from('user_marks')
          .select('aps_mark')
          .eq('user_id', _supabaseClient.auth.currentUser!.id)
          .single();

      final aps = response['aps_mark'];

      setState(() {
        userAps = aps;
        if (userAps != null) {
          _fetchAvailableCourses(userAps!);
        } else {
          isLoading = false;
        }
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user APS: $error')),
      );
    }
  }

  Future<void> _fetchAvailableCourses(int aps) async {
    try {
      // Query the tut_courses table for courses where APS required is less than or equal to user's APS
      final response = await _supabaseClient
          .from('courses')
          .select('university_name, course, aps_required, subjects,levels')
          .lte('aps_required', aps);

      if (response.isNotEmpty) {
        setState(() {
          availableCourses = List<Map<String, dynamic>>.from(response);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error fetching available courses: ')),
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
                              course['course'],
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
                              'APS Required: ${course['aps_required']}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Subjects : ${course['subjects']}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Levels : ${course['levels']}',
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
