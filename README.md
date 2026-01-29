# 🧮 V-Calculator – Voice Enabled Calculator (Flutter)

V-Calculator is a modern **voice-enabled calculator application** built using **Flutter**.  
It allows users to perform mathematical calculations using **both manual input and voice commands**, making calculations faster, smarter, and more accessible.

---

## 🚀 Features

- 🎙️ Voice-based mathematical calculations
- 🧮 Manual calculator input (buttons)
- 🔊 Text-to-Speech (speaks the result)
- ⌫ Backspace & Clear functionality
- 🎨 Clean, modern, professional UI
- 🌙 Dark mode design
- 📱 Cross-platform (Android, iOS, Web)

---

## 🛠️ Technologies Used

- **Flutter (Dart)** – UI & app logic
- **speech_to_text** – Voice recognition
- **flutter_tts** – Text-to-speech output
- **math_expressions** – Expression parsing & evaluation
- **Material UI** – Responsive and modern design
- **Git & GitHub** – Version control

---

## ⚙️ How It Works

### 1️⃣ Input Methods

#### 🔹 Manual Input
- User presses calculator buttons (`0–9`, `+`, `-`, `*`, `/`)
- Expression is built dynamically
- Backspace removes one character
- Clear resets the calculator

#### 🔹 Voice Input
- User taps the microphone icon
- App listens for voice input
- Spoken words are converted:
  - “plus” → `+`
  - “minus” → `-`
  - “into” → `*`
  - “divided by” → `/`
- Expression is cleared before every new voice input
- Converted expression is evaluated automatically

---

### 2️⃣ Expression Evaluation
- Expression is parsed using `math_expressions`
- Result is calculated safely
- Invalid inputs are handled with error messages

---

### 3️⃣ Result Output
- Result is displayed on screen
- Result is spoken aloud using Text-to-Speech

---

## 🎨 UI Design Highlights

- Professional dark theme
- Rounded buttons with elevation
- Responsive layout
- High contrast for readability
- Interactive microphone icon

---

## 📱 Screenshots

<img width="1888" height="1026" alt="image" src="https://github.com/user-attachments/assets/2f56aad8-faa0-4470-b01a-ee5938b848a7" />


