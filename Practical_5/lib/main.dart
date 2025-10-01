import 'package:flutter/material.dart';

void main() {
  runApp(ResumeMakerApp());
}

class ResumeMakerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume Maker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ResumeFormPage(),
    );
  }
}

class ResumeFormPage extends StatefulWidget {
  @override
  _ResumeFormPageState createState() => _ResumeFormPageState();
}

class _ResumeFormPageState extends State<ResumeFormPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final educationController = TextEditingController();
  final skillsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resume Maker"),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Full Name"),
                  validator:
                      (value) =>
                          value!.isEmpty ? "Please enter your name" : null,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Email"),
                  validator:
                      (value) =>
                          value!.isEmpty ? "Please enter your email" : null,
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: "Phone"),
                  validator:
                      (value) =>
                          value!.isEmpty
                              ? "Please enter your phone number"
                              : null,
                ),
                TextFormField(
                  controller: educationController,
                  decoration: InputDecoration(labelText: "Education"),
                ),
                TextFormField(
                  controller: skillsController,
                  decoration: InputDecoration(labelText: "Skills"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ResumePreviewPage(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                education: educationController.text,
                                skills: skillsController.text,
                              ),
                        ),
                      );
                    }
                  },
                  child: Text("Generate Resume"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Page 2: Preview of resume
class ResumePreviewPage extends StatelessWidget {
  final String name, email, phone, education, skills;

  ResumePreviewPage({
    required this.name,
    required this.email,
    required this.phone,
    required this.education,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resume Preview")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text("Email: $email"),
                Text("Phone: $phone"),
                SizedBox(height: 12),
                Text(
                  "Education",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(education),
                SizedBox(height: 12),
                Text(
                  "Skills",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(skills),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
