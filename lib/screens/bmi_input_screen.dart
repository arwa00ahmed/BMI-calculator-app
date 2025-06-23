import 'package:flutter/material.dart';
import 'bmi_result_screen.dart';

class BMIInputScreen extends StatefulWidget {
  const BMIInputScreen({super.key});

  @override
  State<BMIInputScreen> createState() => _BMIInputScreenState();
}

class _BMIInputScreenState extends State<BMIInputScreen> {
  String name = '';
  String birthDate = '';
  String? selectedGender;
  int height = 170;
  int weight = 60;

  int _calculateAgeFromBirthDate(String birthDateStr) {
    try {
      final parts = birthDateStr.split('/');
      if (parts.length != 3) return 0;
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      final birthDate = DateTime(year, month, day);
      final today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        centerTitle: true,
        title: const Text(
          "BMI Calculator",
          style: TextStyle(
            color: Color(0xFF004225),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildTextField("Name", (value) => name = value),
            const SizedBox(height: 12),
            buildTextField("Birthday ", (value) => birthDate = value),
            const SizedBox(height: 20),

            // اختيار النوع
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Choose Gender",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                genderOption("Male", "assets/images/male.png"),
                genderOption("Female", "assets/images/female.png"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text("Male"), Text("Female")
              ],
            ),

            const SizedBox(height: 30),

            // الطول
            buildValueInput("height (cm)", height, (val) => height = val),
            const SizedBox(height: 20),

            // الوزن
            buildValueInput("weight (kg)", weight, (val) => weight = val),

            const SizedBox(height: 40),

            // زر احسب
            SizedBox(
              width: width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  double bmi = weight / ((height / 100) * (height / 100));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BMIResultScreen(
                        name: name.isEmpty ? "User" : name,
                        age: _calculateAgeFromBirthDate(birthDate),
                        gender: selectedGender ?? " Undefined ",
                        bmi: bmi,
                        height: height,
                        weight: weight,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF484783),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Calculate BMI",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, Function(String) onChanged) {
    return TextField(
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onChanged: onChanged,
    );
  }

  Widget genderOption(String gender, String imagePath) {
    bool isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () => setState(() => selectedGender = gender),
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDFE2F3) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF484783) : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget buildValueInput(String label, int value, Function(int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => setState(() => onChanged(value - 1)),
                icon: const Icon(Icons.remove),
              ),
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: value.toString()),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (text) {
                    final parsed = int.tryParse(text);
                    if (parsed != null) setState(() => onChanged(parsed));
                  },
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              IconButton(
                onPressed: () => setState(() => onChanged(value + 1)),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
