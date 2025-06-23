import 'package:flutter/material.dart';
import 'bmi_input_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFDDE8F8),
      body: Stack(
        children: [

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 376,
              decoration: const BoxDecoration(
                color: Color(0xFF7876CD),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
              ),
            ),
          ),


          Positioned(
            top: screenHeight * 0.27,
            left: screenWidth * 0.07,
            child: Image.asset(
              'assets/images/scale.png',
              width: screenWidth * 0.85,
              height: screenHeight * 0.35,
              fit: BoxFit.contain,
            ),
          ),


          Positioned(
            bottom: screenHeight * 0.08,
            left: screenWidth * 0.075,
            right: screenWidth * 0.075,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Know Your Body Better,\nGet Your BMI Score in Less Than a Minute!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                    letterSpacing: 1.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "It takes just 30 seconds — and your health is worth it!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.375,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),


                const Divider(
                  color: Colors.white,
                  thickness: 1,
                  height: 24,
                ),


                const SizedBox(height: 16),


                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF484783),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BMIInputScreen()),
                        );
                      },

                    child: const Text(
                      "Get Start",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

