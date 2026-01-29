import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:math_expressions/math_expressions.dart';
import '../widgets/calc_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String expression = "";
  String result = "";
  bool isListening = false;

  final SpeechToText speech = SpeechToText();
  final FlutterTts tts = FlutterTts();

  // ---------------- BUTTON HANDLER ----------------
  void onButtonPress(String value) {
    HapticFeedback.lightImpact();

    setState(() {
      if (value == "C") {
        clearAll();
      } else if (value == "=") {
        calculateResult();
      } else {
        expression += value;
      }
    });
  }

  void clearAll() {
    stopListening();
    expression = "";
    result = "";
  }

  void backspace() {
    HapticFeedback.selectionClick();
    if (expression.isNotEmpty) {
      setState(() {
        expression = expression.substring(0, expression.length - 1);
      });
    }
  }

  // ---------------- CALCULATION ----------------
  void calculateResult() {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel cm = ContextModel();

      double eval = exp.evaluate(EvaluationType.REAL, cm);
      result = eval.toString();

      stopListening();
      speak(result);
    } catch (e) {
      result = "Invalid Expression";
      stopListening();
    }
  }

  // ---------------- TEXT TO SPEECH ----------------
  Future<void> speak(String text) async {
    await tts.setSpeechRate(0.45);
    await tts.speak("The result is $text");
  }

  // ---------------- VOICE CONTROL ----------------
  Future<void> toggleListening() async {
    if (isListening) {
      stopListening();
    } else {
      startListening();
    }
  }

  Future<void> startListening() async {
    bool available = await speech.initialize();
    if (!available) return;

    setState(() {
      isListening = true;
      expression = ""; // 🔥 CLEAR BEFORE NEW VOICE INPUT
      result = "";
    });

    speech.listen(
      listenMode: ListenMode.confirmation,
      onResult: (res) {
        setState(() {
          expression = sanitizeVoiceInput(res.recognizedWords);
        });
      },
    );
  }

  void stopListening() {
    if (isListening) {
      speech.stop();
      setState(() => isListening = false);
    }
  }

  // ---------------- VOICE CLEANER ----------------
  String sanitizeVoiceInput(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[^0-9+\-*/.%]'), ' ')
        .replaceAll("plus", "+")
        .replaceAll("minus", "-")
        .replaceAll("multiply", "*")
        .replaceAll("times", "*")
        .replaceAll("divided by", "/")
        .replaceAll(" ", "");
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double calcWidth = screenWidth > 420 ? 420 : screenWidth * 0.95;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("V-Calculator"),
        centerTitle: true,
        elevation: 0,
      ),

      // 🎤 MANUAL MIC TOGGLE
      floatingActionButton: FloatingActionButton(
        backgroundColor: isListening ? Colors.redAccent : Colors.greenAccent,
        onPressed: toggleListening,
        child: Icon(
          isListening ? Icons.mic_off : Icons.mic,
          color: Colors.black,
        ),
      ),

      body: Center(
        child: Container(
          width: calcWidth,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              // -------- DISPLAY --------
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    expression,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    result,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Divider(color: Colors.white24),

              // -------- BUTTON GRID --------
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                physics: const NeverScrollableScrollPhysics(),
                children: [

                  CalcButton(text: "C", color: Colors.redAccent, onTap: onButtonPress),
                  CalcButton(icon: Icons.backspace_outlined, color: Colors.orangeAccent, onIconTap: backspace),
                  CalcButton(text: "%", onTap: onButtonPress),
                  CalcButton(text: "/", color: Colors.blueAccent, onTap: onButtonPress),

                  ...["7","8","9","*","4","5","6","-","1","2","3","+","0",".","="]
                      .map((e) => CalcButton(
                            text: e,
                            color: "+-*/=".contains(e) ? Colors.blueAccent : null,
                            onTap: onButtonPress,
                          )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
