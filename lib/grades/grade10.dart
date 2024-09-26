import 'package:flutter/material.dart';
import 'package:funding/grades/grade10home.dart';
import 'package:funding/pastPapers/grade10/Accounting/accounting.dart';
import 'package:funding/pastPapers/grade10/AgriculturalSciences/AgriculturalScience.dart';
import 'package:funding/pastPapers/grade10/BusinessStudies/businessStudies.dart';
import 'package:funding/pastPapers/grade10/Economics/economics.dart';
import 'package:funding/pastPapers/grade10/English/english.dart';
import 'package:funding/pastPapers/grade10/Geography/geography.dart';
import 'package:funding/pastPapers/grade10/History/history.dart';
import 'package:funding/pastPapers/grade10/LifeSciences/lifeSciences.dart';
import 'package:funding/pastPapers/grade10/MathematicalLiteracy/mathsLit.dart';
import 'package:funding/pastPapers/grade10/Mathematics/maths.dart';
import 'package:funding/pastPapers/grade10/PhysicalSciences/physicalSciences.dart';
import 'package:funding/pastPapers/grade10/Setswana/setswana.dart';
import 'package:funding/pastPapers/grade10/TechnicalMathematics/technicalMath.dart';
import 'package:funding/pastPapers/grade10/TechnicalSciences/technicalScience.dart';

class Grade10Page extends StatelessWidget {
  const Grade10Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Grade10HomePage()),
            );
          },
        ),
        title: const Text("NSC SUBJECTS"),
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
                  label: 'ACCOUNTING',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccountingGrade10Page()),
                    );
                  },
                ),
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'AFRIKAANS',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AfrikaansGrade10Page()),
                    );
                  },
                ),*/
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'AGRICULTURAL SCIENCE',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AgriculturalScienceGrade10Page()),
                    );
                  },
                ),
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'AGRICULTURAL MANAGEMENT PRACTICES',
                  
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
                  label: 'AGRICULTURAL TECHNOLOGY',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AgriculturalTechnologyGrade10Page()),
                    );
                  },
                ),*/
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'BUSINESS STUDIES',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const BusinessStudiesGrade10Page()),
                    );
                  },
                ),
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'CIVIL TECNOLOGY',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const CivilTechnologyGrade10Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'COMPUTER APPLICATIONS TECHNOLOGY',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CATGrade10Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'CONSUMER STUDIES',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ConsumerStudiesGrade10Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'DANCE STUDIES',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const DanceStudiesGrade10Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'DESIGN',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DesignGrade10Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'DRAMATIC ARTS',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const DramaticArtsGrade10Page()),
                    );
                  },
                ),*/
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'ECONOMICS',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EconomicsGrade10Page()),
                    );
                  },
                ),
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'ELECTRICAL TECHNOLOGY',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ElectricalTechnologyGrade10Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'ENGINEERING GRAPHICS AND DESIGN',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EGDGrade10Page()),
                    );
                  },
                ),
                */
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'ENGLISH',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EnglishGrade10Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'GEOGRAPHY',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GeographyGrade10Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'HISTORY',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoryGrade10Page()),
                    );
                  },
                ),
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'HOSPITALITY STUDIES',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const HospitalityStudiesGrade10Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'INFORMATION TECHNOLOGY',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ITGrade10Page()),
                    );
                  },
                ),
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'isiNDEBELE',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IsiNdebeleGrade10Page()),
                    );
                  },
                ),*/
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'isiXHOSA',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IsiXhosaGrade10Page()),
                    );
                  },
                ),
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'isiZULU',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IsiZuluGrade10Page()),
                    );
                  },
                ),*/
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'LIFE ORIENTATION',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const LifeOrientationGrade10Page()),
                    );
                  },
                ),*/
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'LIFE SCIENCE',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const LifeSciencesGrade10Page()),
                    );
                  },
                ),
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'MARINE SCIENCE',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MarineSciencesGrade10Page()),
                    );
                  },
                ),*/
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'MATHEMATICAL LITERACY',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MathematicalLiteracyGrade10Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'MATHEMATICS',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MathsGrade10Page()),
                    );
                  },
                ),
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'MECHANICAL TECHNOLOGY',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MechanicalTechnologyGrade10Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'MUSIC',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MusicGrade10Page()),
                    );
                  },
                ),*/
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'PHYSICAL SCIENCE',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const PhysicalSciencesGrade10Page()),
                    );
                  },
                ),
                /*
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'RELIGION STUDIES',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ReligionStudiesGrade10Page()),
                    );
                  },
                ),
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'SEPEDI',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SepediGrade10Page()),
                    );
                  },
                ),*/
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'SESOTHO',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SesothoGrade10Page()),
                    );
                  },
                ),
                
                /*
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'SISWATI',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SiswatiGrade10Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'SOUTH AFRICAN SIGN LANGUAGE',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SASLGrade10Page()),
                    );
                  },
                ),*/*/
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'SETSWANA',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SetswanaGrade10Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'TECHNICAL MATHEMATICS',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const TechnicalMathsGrade10Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'TECHNICAL SCIENCES',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const TechnicalScienceGrade10Page()),
                    );
                  },
                ),
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'TOURISM',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TourismGrade10Page()),
                    );
                  },
                ),*/
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'TSHIVENDA',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TshivendaGrade10Page()),
                    );
                  },
                ),*/
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'VISUAL ARTS',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VisualArtsGrade10Page()),
                    );
                  },
                ),*/
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'XITSONGA',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const XitsongaGrade10Page()),
                    );
                  },
                ),*/
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double
          .infinity, // Makes the button stretch across the width of the screen
      height: 60, // Ensures all buttons have the same height
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 10,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding:
              const EdgeInsets.symmetric(horizontal: 24), // Padding for content
        ),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  overflow:
                      TextOverflow.ellipsis, // Handles overflow gracefully
                ),
                maxLines: 1, // Ensures text stays on one line
              ),
            ],
          ),
        ),
      ),
    );
  }
}
