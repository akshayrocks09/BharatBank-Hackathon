# BharatBank-Hackathon
 Project Title
BharatBank – Empowering Financial Inclusion Through Secure Digital Banking

🔍 Problem Statement
Bridging the Financial Divide in India
Despite advancements in the Indian financial sector, a large portion of the population, especially in rural and semi-urban areas, still faces significant challenges when accessing basic financial services.

Challenges Identified:

✅ Limited Banking Access:
Lack of physical bank branches and ATMs in remote areas.
Inconvenience in accessing banking services leads to financial exclusion.

✅ Complex Banking Interfaces:
Most banking apps are designed for tech-savvy urban users.
Difficult navigation and limited language support make them inaccessible to rural users.

✅ Trust and Security Concerns:
Users hesitate to adopt digital banking due to fear of fraud and complex KYC processes.
Lack of secure and familiar authentication methods.

✅ Financial Literacy Gap:
Low understanding of banking terms and processes.
Lack of support and education in existing banking platforms.

✅ Unstable Internet Connectivity:
Most existing banking platforms require stable internet connectivity.
Offline financial transactions are not supported by most apps.

💡 Solution Overview
BharatBank is designed to eliminate these barriers by offering a simplified, secure, and accessible digital banking experience. The app is built to cater specifically to the needs of rural and semi-urban users with features that enhance financial accessibility and trust.

✅ Key Features:

🔹 Aadhaar-Based OTP Authentication:
Familiar and secure login using Aadhaar-linked OTP verification.

🔹 Multilingual Support:
Supports major Indian languages to increase accessibility.

🔹 Offline UPI Payments:
Perform key transactions even with limited or no internet connectivity.

🔹 Instant Money Transfers:
Real-time money transfers using UPI.

🔹 Quick Loans:
Instant approval for small loans without complex KYC processes.

🔹 Transparent Transaction History:
Detailed logs of all transactions for user confidence and security.

🔹 Secure and Compliant:
End-to-end encryption and adherence to banking regulations.

Setup & Installation
Follow these steps to set up and run BharatBank on your local machine.

✅ Prerequisites
Make sure you have the following installed:

Flutter SDK – Version 3.0 or higher (latest stable recommended)
Dart – Comes bundled with Flutter (2.18+)
Android Studio – For emulator and development environment (optional)
Git – For cloning the repository
Android Device/Emulator – Running Android API 21 (Lollipop) or higher
ADB – For installing APK on a physical device (optional)

📥 Step-by-Step Instructions

1. Install Flutter SDK
Download Flutter from flutter.dev.

Extract the ZIP file to a directory (e.g., C:\flutter).

Add Flutter to your system PATH:

Windows: Open "Environment Variables" → Add C:\flutter\bin to "Path".
Verify installation:

bash
flutter --version
✅ Expected output: Flutter 3.x.x, Dart 2.x.x

2. Set Up Android Environment
Install the Android SDK using Android Studio.

Set up an emulator or connect a physical Android device:

Enable Developer Options and USB Debugging on your device.
Verify device detection:

bash
adb devices
✅ Output should list your connected device (e.g., "A063").

3. Clone the Repository
Open a terminal or command prompt.
Clone the GitHub repository:
bash
git clone https://github.com/yourusername/bharatbank-hackathon-2025.git
cd bharatbank-hackathon-2025
4. Install Dependencies
Navigate to the project directory:

bash
cd bharatbank-hackathon-2025

Install Flutter packages:
bash
flutter pub get

5. Build and Run the App
Option 1: Run on Emulator/Device (Recommended)
Connect your device or start an emulator, then run:

bash
flutter run

Option 2: Build APK and Install Manually
Build a debug APK:

bash
flutter build apk --debug
Install the APK on your device:

bash
adb install build/app/outputs/flutter-apk/app-debug.apk
✅ Open BharatBank on your device and start using the app!

🔍 Verify Installation
App Launch – Splash Screen → Onboarding → Dashboard
Login Flow – Enter 12-digit Aadhaar → Send OTP → Enter OTP → Dashboard
Money Transfer – Dashboard → Transfer → Fill Details → Confirm → Success ✅

## API Documentation

Not applicable at this stage. The BharatBank prototype uses simulated data for demonstration purposes:
- Login OTP verification is mocked (accepts any input).
- Dashboard balance (₹25,000) and transactions (e.g., Grocery, Salary) are hardcoded.
- Transfer functionality simulates success without a real backend.

Future iterations will integrate APIs for Aadhaar OTP validation, account data, and transaction processing (e.g., via UPI or bank gateways).

   


