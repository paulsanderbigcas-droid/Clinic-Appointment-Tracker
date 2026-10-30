import 'dart:io';

// ==========================================
// 1. MIXIN FOR CODE REUSE
// ==========================================
mixin LoggerMixin {
  void logAction(String action) {
    String timestamp = DateTime.now().toString().substring(11, 19);
    print('[$timestamp] [LOG]: $action');
  }
}

// ==========================================
// 2. ABSTRACT CLASS / INTERFACE
// ==========================================
abstract class Reportable {
  void generateSummaryReport();
}

// ==========================================
// 3. BASE CLASS (INHERITANCE PARENT)
// ==========================================
class User with LoggerMixin {
  String name;
  int age;

  // Constructor
  User({required this.name, required this.age});

  void displayInfo() {
    print('Name: $name | Age: $age');
  }
}

// ==========================================
// 4. DERIVED SUBCLASS (INHERITANCE CHILD)
// ==========================================
class Patient extends User implements Reportable {
  String patientId;
  String ailment;
  String assignedDoctor;
  bool isPaid;

  // Constructor using super for parent properties
  Patient({
    required String name,
    required int age,
    required this.patientId,
    required this.ailment,
    required this.assignedDoctor,
    this.isPaid = false,
  }) : super(name: name, age: age);

  // Method override / polymorphism
  @override
  void displayInfo() {
    print('----------------------------------------');
    print('Patient ID   : $patientId');
    print('Full Name    : $name');
    print('Age          : $age');
    print('Ailment      : $ailment');
    print('Doctor       : $assignedDoctor');
    print('Fee Status   : ${isPaid ? "Paid (Verified)" : "Unpaid (Pending)"}');
    print('----------------------------------------');
  }

  @override
  void generateSummaryReport() {
    print('--- Official Clinic Consultation Report ---');
    print('Patient: $name (ID: $patientId)');
    print('Diagnosis: $ailment');
    print('Attending Physician: $assignedDoctor');
    print('Status: Consultation Completed & Recorded.');
    print('-------------------------------------------');
    logAction('Generated summary report for patient $patientId.');
  }
}

// ==========================================
// 5. ASYNCHRONOUS SIMULATION FUNCTIONS
// ==========================================
Future<void> simulateServerConnection() async {
  print('\n[System]: Connecting to MediCore Hospital Database...');
  try {
    // Simulating network delay
    await Future.delayed(Duration(seconds: 2));
    print('[System]: Connection established successfully.');
  } catch (e) {
    print('[Error]: Failed to connect to server - $e');
  }
}

Future<void> simulateProcessing(String taskName) async {
  print('[Processing]: $taskName...');
  try {
    await Future.delayed(Duration(seconds: 1, milliseconds: 500));
    print('[Success]: $taskName completed.');
  } catch (e) {
    print('[Error]: Error during processing -> $e');
  }
}

// ==========================================
// 6. MAIN APPLICATION ENTRY POINT
// ==========================================
void main() async {
  // Make main async to support await operations
  print('========================================');
  print('   Clinic Appointment Tracker    ');
  print('========================================');

  // Run initial asynchronous server handshake
  await simulateServerConnection();

  // In-memory database of registered patients
  List<Patient> patientRecords = [
    Patient(
      name: 'Juan Dela Cruz',
      age: 35,
      patientId: 'P-1001',
      ailment: 'Acute Bronchitis',
      assignedDoctor: 'Dr. Santos',
      isPaid: true,
    ),
    Patient(
      name: 'Maria Clara Santos',
      age: 28,
      patientId: 'P-1002',
      ailment: 'Migraine / Vertigo',
      assignedDoctor: 'Dr. Reyes',
      isPaid: false,
    ),
  ];

  bool running = true;

  while (running) {
    print('\n--- CLINIC MAIN MENU ---');
    print('[1] View All Patient Records');
    print('[2] Register New Patient Appointment');
    print('[3] Process Patient Payment & Consultation Report');
    print('[4] Exit Application');
    stdout.write('Enter your choice (1-4): ');

    // Safe input handling with null safety and try-catch[cite: 3]
    String? input = stdin.readLineSync();

    try {
      int choice = int.parse(input ?? '0');

      switch (choice) {
        case 1:
          await simulateProcessing('Fetching patient records');
          if (patientRecords.isEmpty) {
            print('No patient records found.');
          } else {
            for (var p in patientRecords) {
              p.displayInfo();
            }
          }
          break;

        case 2:
          print('\n--- NEW PATIENT REGISTRATION ---');
          stdout.write('Enter Patient Full Name: ');
          String pName = stdin.readLineSync() ?? 'Unknown Patient';

          stdout.write('Enter Age: ');
          int pAge = int.parse(stdin.readLineSync() ?? '0');

          stdout.write('Enter Patient ID (e.g., P-1003): ');
          String pId = stdin.readLineSync() ?? 'P-9999';

          stdout.write('Enter Chief Complaint / Ailment: ');
          String pAilment = stdin.readLineSync() ?? 'General Checkup';

          stdout.write('Enter Assigned Doctor: ');
          String pDoc = stdin.readLineSync() ?? 'Dr. House';

          // Create and add patient
          Patient newPatient = Patient(
            name: pName,
            age: pAge,
            patientId: pId,
            ailment: pAilment,
            assignedDoctor: pDoc,
            isPaid: false,
          );

          await simulateProcessing('Saving patient data to server');
          patientRecords.add(newPatient);
          newPatient.logAction('Registered new patient ID $pId');
          print('Patient successfully registered and queued!');
          break;

        case 3:
          print('\n--- PROCESS PAYMENT & REPORT ---');
          stdout.write('Enter Patient ID to process: ');
          String targetId = stdin.readLineSync() ?? '';

          Patient? foundPatient;
          for (var p in patientRecords) {
            if (p.patientId.toLowerCase() == targetId.toLowerCase()) {
              foundPatient = p;
              break;
            }
          }

          if (foundPatient != null) {
            await simulateProcessing('Processing billing gateway transaction');
            foundPatient.isPaid = true;
            print('Payment verified for ${foundPatient.name}!');

            // Call interface method
            foundPatient.generateSummaryReport();
          } else {
            print('[Error]: Patient ID "$targetId" not found in records.');
          }
          break;

        case 4:
          print('\n[System]: Shutting down clinic simulator. Goodbye!');
          running = false;
          break;

        default:
          print(
            '[Error]: Invalid option. Please enter a number between 1 and 4.',
          );
      }
    } catch (e) {
      print(
        '[Runtime Error]: Invalid input format detected. Please enter valid numbers where requested. ($e)',
      );
    }
  }
}
