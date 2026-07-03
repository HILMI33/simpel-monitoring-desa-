import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class EditProfileView extends GetView<ProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Local controllers for the editable fields
    final TextEditingController nameController = TextEditingController(text: controller.userName.value);
    final TextEditingController phoneController = TextEditingController(text: controller.userPhone.value == '-' ? '' : controller.userPhone.value);
    final TextEditingController rtController = TextEditingController(text: controller.userRT.value == '-' ? '' : controller.userRT.value);
    final TextEditingController rwController = TextEditingController(text: controller.userRW.value == '-' ? '' : controller.userRW.value);
    
    // Derived username (mocked based on email for display purposes like in the screenshot)
    final String username = controller.userEmail.value.split('@').first;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Ubah Profil", style: TextStyle(color: Color(0xFF1A1A2E), fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {
              controller.saveProfileDetails(nameController.text, phoneController.text, rtController.text, rwController.text);
            },
            child: Text("Simpan", style: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section (Profile Photo with blue background tint)
            Container(
              width: double.infinity,
              color: Colors.blue.shade50.withOpacity(0.5),
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  Obx(() => CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: controller.userPhotoUrl.value.isNotEmpty
                        ? NetworkImage(controller.userPhotoUrl.value)
                        : null,
                    child: controller.userPhotoUrl.value.isEmpty
                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  )),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => controller.updateProfilePhoto(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit, color: Colors.blue.shade600, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          "Ubah Foto",
                          style: TextStyle(color: Colors.blue.shade600, fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Form Section
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Informasi Diri",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E)),
                  ),
                  const SizedBox(height: 24),
                  
                  _buildTextField("Nama Lengkap", controller: nameController, isEditable: true),
                  const SizedBox(height: 24),
                  
                  _buildTextField("Username", initialValue: username, isEditable: false, suffixIcon: Icons.lock),
                  const SizedBox(height: 24),
                  
                  _buildTextField("E-mail", initialValue: controller.userEmail.value, isEditable: false, suffixIcon: Icons.lock),
                  const SizedBox(height: 24),
                  
                  _buildTextField("No. Handphone", controller: phoneController, isEditable: true, suffixIcon: Icons.edit),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField("RT", controller: rtController, isEditable: true, suffixIcon: Icons.edit),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField("RW", controller: rwController, isEditable: true, suffixIcon: Icons.edit),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {TextEditingController? controller, String? initialValue, required bool isEditable, IconData? suffixIcon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
        ),
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          readOnly: !isEditable,
          style: TextStyle(fontSize: 16, color: isEditable ? const Color(0xFF1A1A2E) : Colors.grey.shade600),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            suffixIcon: suffixIcon != null ? Icon(suffixIcon, size: 18, color: Colors.grey.shade600) : null,
            suffixIconConstraints: const BoxConstraints(minWidth: 24, minHeight: 24),
            border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
      ],
    );
  }
}
