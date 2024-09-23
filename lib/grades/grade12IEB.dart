import 'package:flutter/material.dart';
import 'package:funding/pastPapers/grade12IEB/APAfrikaans/APAfrikaans.dart';
import 'package:funding/pastPapers/grade12IEB/Afrikaans/AfrikaansFAL.dart';
import 'package:funding/pastPapers/grade12IEB/AgriculturalSciences/AgriculturalScience.dart';
import 'package:funding/pastPapers/grade12IEB/APMath/APMath.dart';
import 'package:funding/pastPapers/grade12IEB/BusinessStudies/businessStudies.dart';
import 'package:funding/pastPapers/grade12IEB/EnglishFAL/EnglishFAL.dart';
import 'package:funding/pastPapers/grade12IEB/AgriculturalManagementPractices/AgriculturalManagementSciences.dart.dart';
import 'package:funding/pastPapers/grade12IEB/Equine%20studies/equineStudies.dart';
import 'package:funding/pastPapers/grade12IEB/ConsumerStudies/consumerStudies.dart';
import 'package:funding/pastPapers/grade12IEB/GreekSAL/greekSAL.dart';
import 'package:funding/pastPapers/grade12IEB/DramaticArts/dramaticArts.dart';
import 'package:funding/pastPapers/grade12IEB/Economics/economics.dart';
import 'package:funding/pastPapers/grade12IEB/frenchSAL/frenchSAL.dart';
import 'package:funding/pastPapers/grade12IEB/APEnglish/APEnglish.dart';
import 'package:funding/pastPapers/grade12IEB/History/history.dart';
import 'package:funding/pastPapers/grade12IEB/GermanSAL/germanSAL.dart';
import 'package:funding/pastPapers/grade12IEB/GujaratiFAL/gujaratiFAL.dart';
import 'package:funding/pastPapers/grade12IEB/HindiFAL/HindiFAL.dart';
import 'package:funding/pastPapers/grade12IEB/IsiXhosaFAL/isiXhosaFAL.dart';
import 'package:funding/pastPapers/grade12IEB/IsiZuluHL/isiZuluHL.dart';
import 'package:funding/pastPapers/grade12IEB/Latin/LifeOrientation.dart';
import 'package:funding/pastPapers/grade12IEB/LifeSciences/lifeSciences.dart';
import 'package:funding/pastPapers/grade12IEB/MarineSciences/marineSciences.dart';
import 'package:funding/pastPapers/grade12IEB/MathematicalLiteracy/mathsLit.dart';
import 'package:funding/pastPapers/grade12IEB/Mathematics/maths.dart';
import 'package:funding/pastPapers/grade12IEB/portuguese/portugueseSAL.dart';
import 'package:funding/pastPapers/grade12IEB/Music/music.dart';
import 'package:funding/pastPapers/grade12IEB/Mandarin/MandarinSAL.dart';
import 'package:funding/pastPapers/grade12IEB/HindiSAL/hindiSAL.dart';
import 'package:funding/pastPapers/grade12IEB/Sepedi/sepediHL.dart';
import 'package:funding/pastPapers/grade12IEB/SiswatiHL/siswatiHL.dart';
import 'package:funding/pastPapers/grade12IEB/SiswatiFAL/siswatiFAL.dart';
import 'package:funding/pastPapers/grade12IEB/Telegu/teluguSAL.dart';
import 'package:funding/pastPapers/grade12IEB/TechnicalSciences/technicalScience.dart';
import 'package:funding/pastPapers/grade12IEB/Tourism/tourism.dart';
import 'package:funding/pastPapers/grade12IEB/VisualCutureStudies/visualCutureStudies.dart';
import 'package:funding/pastPapers/grade12IEB/Urdu/Urdu.dart';
import 'package:funding/grades/grade12home.dart';

class Grade12IEBPage extends StatelessWidget {
  const Grade12IEBPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Grade12HomePage()),
            );
          },
        ),
        title: const Text("IEB SUBJECTS"),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'Advanced Programme Afrikaans',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const APAfrikaansGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'Advanced Programme English',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const APEnglishGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'Advanced Programme Mathematics',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const APMathGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'AFRIKAANS FAL',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AfrikaansFALGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'AGRICULTURAL MANAGEMENT PRACTICES',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AgriculturalManagementPractices()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'AGRICULTURAL SCIENCE',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AgriculturalScienceGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'BUSINESS STUDIES',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const BusinessStudiesGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'EQUINE STUDIES',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const EquineStudiesGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'ENGLISH FAL',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EnglishFALGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'CONSUMER STUDIES',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ConsumerStudiesGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'FRENCH SAL',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FrenchSALGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'DRAMATIC ARTS',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const DramaticArtsGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'ECONOMICS',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EconomicsGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'GERMAN SAL',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GermanSALGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'GREEK SAL',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GreekSALGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'GUJARATI FAL',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GujaratiFALGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'HINDI FAL',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HindiFALGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'HINDI SAL',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HindiSALGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'HISTORY',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoryGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'ISIXHOSA FAL',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IsiXhosaFALGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'ISIZULU HOME LANGUAGE',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IsiZuluHLGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'LATIN SAL',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LatinSALGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'MANDARIN SAL',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MandarinSALGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'PORTUGUESE SAL',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const PortugueseSALGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'LIFE SCIENCE',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const LifeSciencesGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'MARINE SCIENCE',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MarineSciencesGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'MATHEMATICAL LITERACY',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MathematicalLiteracyGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'MATHEMATICS',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MathsGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'TELEGU SAL',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TeleguSALGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'MUSIC',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MusicGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'URDU SAL',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UrduSALGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'SEPEDI HL',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SepediHLGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'SISWATI HL',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SiswatiHLGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'SISWATI FAL',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SiswatiFALGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'TECHNICAL SCIENCES',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const TechnicalScienceGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'TOURISM',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TourismGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'VISUAL CUTURE STUDIES',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const VisualCultureStudiesGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom Button Widget
  Widget _buildCustomButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 10,
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: FittedBox(
        // Wraps the content to adjust based on available space
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis, // Handles overflow gracefully
              ),
              maxLines: 1, // Ensures text stays on one line
            ),
          ],
        ),
      ),
    );
  }
}
