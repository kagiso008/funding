import 'package:flutter/material.dart';
import 'package:funding/pastPapers/grade12/Accounting/accounting.dart';
import 'package:funding/pastPapers/grade12/Afrikaans/Afrikaans.dart';
import 'package:funding/pastPapers/grade12/AgriculturalSciences/AgriculturalScience.dart';
import 'package:funding/pastPapers/grade12/AgriculturalTechnology/AgriculturalTechnology.dart';
import 'package:funding/pastPapers/grade12/BusinessStudies/businessStudies.dart';
import 'package:funding/pastPapers/grade12/CivilTechnology/civilTechnology.dart';
import 'package:funding/pastPapers/grade12/AgriculturalManagementPractices/AgriculturalManagementSciences.dart.dart';
import 'package:funding/pastPapers/grade12/ComputerApplicationsTechnology/cat.dart';
import 'package:funding/pastPapers/grade12/ConsumerStudies/consumerStudies.dart';
import 'package:funding/pastPapers/grade12/DanceStudies/danceStudies.dart';
import 'package:funding/pastPapers/grade12/Design/design.dart';
import 'package:funding/pastPapers/grade12/DramaticArts/dramaticArts.dart';
import 'package:funding/pastPapers/grade12/Economics/economics.dart';
import 'package:funding/pastPapers/grade12/ElectricalTechnology/electricalTechnology.dart';
import 'package:funding/pastPapers/grade12/EngineeringGraphicsAndDesign/egd.dart';
import 'package:funding/pastPapers/grade12/English/english.dart';
import 'package:funding/pastPapers/grade12/Geography/geography.dart';
import 'package:funding/pastPapers/grade12/History/history.dart';
import 'package:funding/pastPapers/grade12/HospitalityStudies/hospitalityStudies.dart';
import 'package:funding/pastPapers/grade12/InformationTechnology/IT.dart';
import 'package:funding/pastPapers/grade12/IsiNdebele/isiNdebele.dart';
import 'package:funding/pastPapers/grade12/IsiXhosa/isiXhosa.dart';
import 'package:funding/pastPapers/grade12/IsiZulu/isiZulu.dart';
import 'package:funding/pastPapers/grade12/LifeOrientation/LifeOrientation.dart';
import 'package:funding/pastPapers/grade12/LifeSciences/lifeSciences.dart';
import 'package:funding/pastPapers/grade12/MarineSciences/marineSciences.dart';
import 'package:funding/pastPapers/grade12/MathematicalLiteracy/mathsLit.dart';
import 'package:funding/pastPapers/grade12/Mathematics/maths.dart';
import 'package:funding/pastPapers/grade12/MechanicalTechnology/mechinalTechnology.dart';
import 'package:funding/pastPapers/grade12/Music/music.dart';
import 'package:funding/pastPapers/grade12/PhysicalSciences/physicalSciences.dart';
import 'package:funding/pastPapers/grade12/ReligionStudies/religionStudies.dart';
import 'package:funding/pastPapers/grade12/Sepedi/sepedi.dart';
import 'package:funding/pastPapers/grade12/Sesotho/sesotho.dart';
import 'package:funding/pastPapers/grade12/Setswana/setswana.dart';
import 'package:funding/pastPapers/grade12/Siswati/siswati.dart';
import 'package:funding/pastPapers/grade12/SouthAfricanSignLanguage/sign.dart';
import 'package:funding/pastPapers/grade12/TechnicalMathematics/technicalMath.dart';
import 'package:funding/pastPapers/grade12/TechnicalSciences/technicalScience.dart';
import 'package:funding/pastPapers/grade12/Tourism/tourism.dart';
import 'package:funding/pastPapers/grade12/Tshivenda/tshivenda.dart';
import 'package:funding/pastPapers/grade12/VisualArts/visualArts.dart';
import 'package:funding/pastPapers/grade12/Xitsonga/xitsonga.dart';

class Grade12Page extends StatelessWidget {
  const Grade12Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header text
                const Text(
                  'SUBJECTS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),

                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'ACCOUNTING',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AccountingGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'AFRIKAANS',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AfrikaansGrade12Page()),
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
                              AgriculturalScienceGrade12Page()),
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
                              AgriculturalManagementPractices()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'AGRICULTURAL TECHNOLOGY',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AgriculturalTechnologyGrade12Page()),
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
                          builder: (context) => BusinessStudiesGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'CIVIL TECNOLOGY',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CivilTechnologyGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'COMPUTER APPLICATIONS TECHNOLOGY',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CATGrade12Page()),
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
                          builder: (context) => ConsumerStudiesGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'DANCE STUDIES',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DanceStudiesGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'DESIGN',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DesignGrade12Page()),
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
                          builder: (context) => DramaticArtsGrade12Page()),
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
                          builder: (context) => EconomicsGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'ELECTRICAL TECHNOLOGY',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ElectricalTechnologyGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'ENGINEERING GRAPHICS AND DESIGN',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => EGDGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'ENGLISH',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EnglishGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'GEOGRAPHY',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GeographyGrade12Page()),
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
                          builder: (context) => HistoryGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'HOSPITALITY STUDIES',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HospitalityStudiesGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'INFORMATION TECHNOLOGY',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ITGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'isiNDEBELE',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IsiNdebeleGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'isiXHOSA',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IsiXhosaGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'isiZULU',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IsiZuluGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'LIFE ORIENTATION',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LifeOrientationGrade12Page()),
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
                          builder: (context) => LifeSciencesGrade12Page()),
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
                          builder: (context) => MarineSciencesGrade12Page()),
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
                              MathematicalLiteracyGrade12Page()),
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
                          builder: (context) => MathsGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'MECHANICAL TECHNOLOGY',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MechanicalTechnologyGrade12Page()),
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
                          builder: (context) => MusicGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'PHYSICAL SCIENCE',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhysicalSciencesGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'RELIGION STUDIES',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReligionStudiesGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'SEPEDI',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SepediGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'SESOTHO',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SesothoGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'SETSWANA',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SetswanaGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'SISWATI',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SiswatiGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'SOUTH AFRICAN SIGN LANGUAGE',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SASLGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'TECHNICAL MATHEMATICS',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TechnicalMathsGrade12Page()),
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
                          builder: (context) => TechnicalScienceGrade12Page()),
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
                          builder: (context) => TourismGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'TSHIVENDA',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TshivendaGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'VISUAL ARTS',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VisualArtsGrade12Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'XITSONGA',
                  icon: Icons.book,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => XitsongaGrade12Page()),
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
