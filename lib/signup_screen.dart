import 'package:flutter/material.dart';
import 'volunteer_home.dart';

class SignUpScreen extends StatefulWidget {
  final String role;

  const SignUpScreen({super.key, required this.role});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  bool allowLocation = false;
  bool agreeTerms = false;

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    ageController.dispose();
    emailController.dispose();
    passwordController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void _onSignUp() {
    if (!agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You must agree to terms and conditions."),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const VolunteerHome()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Sign Up"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Role: ${widget.role}"),
            const SizedBox(height: 16),

            _buildField("Name", nameController),
            const SizedBox(height: 12),
            _buildField("Username", usernameController),
            const SizedBox(height: 12),
            _buildField(
              "Age",
              ageController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            _buildField(
              "Email",
              emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            _buildField("Password", passwordController, obscure: true),
            const SizedBox(height: 20),

            const Text(
              "Input location details:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Location",
              ),
            ),
            const SizedBox(height: 8),

            CheckboxListTile(
              value: allowLocation,
              onChanged: (v) => setState(() => allowLocation = v ?? false),
              title: const Text("Allow us access and location"),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: agreeTerms,
              onChanged: (v) => setState(() => agreeTerms = v ?? false),
              title: const Text("Agree to terms and conditions"),
              controlAffinity: ListTileControlAffinity.leading,
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: _onSignUp,
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label:"),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
      ],
    );
  }
}
