import 'package:flutter/material.dart';

class EmployeeDetailScreen extends StatelessWidget {
  final Map<String, dynamic> employee;

  const EmployeeDetailScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee['name'] ?? 'Employee Details'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile picture and name
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    employee['profile_picture'] ?? '',
                  ),
                  backgroundColor: Colors.grey[300],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    employee['name'] ?? '',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement Edit functionality
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement Transfer functionality
                  },
                  icon: const Icon(Icons.swap_horiz),
                  label: const Text('Transfer'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement Medical History view
                  },
                  icon: const Icon(Icons.medical_services),
                  label: const Text('Medical'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Personal data
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text("HRPN"),
                    subtitle: Text(employee['hrpn'] ?? ''),
                  ),
                  ListTile(
                    title: const Text("DOB"),
                    subtitle: Text(employee['dob'] ?? ''),
                  ),
                  ListTile(
                    title: const Text("Branch"),
                    subtitle: Text(employee['branch'] ?? ''),
                  ),
                  ListTile(
                    title: const Text("Blood Group"),
                    subtitle: Text(employee['blood_group'] ?? ''),
                  ),
                  ListTile(
                    title: const Text("Height"),
                    subtitle: Text(employee['height']?.toString() ?? ''),
                  ),
                  ListTile(
                    title: const Text("Weight"),
                    subtitle: Text(employee['weight']?.toString() ?? ''),
                  ),
                  ListTile(
                    title: const Text("BMI"),
                    subtitle: Text(employee['bmi']?.toString() ?? ''),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*import 'package:flutter/material.dart';

class EmployeeDetailScreen extends StatelessWidget {
  final Map<String, dynamic> employee;

  const EmployeeDetailScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee['name']),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Info',
            onPressed: () {
              // Navigate to edit screen
            },
          ),
          IconButton(
            icon: const Icon(Icons.sync_alt),
            tooltip: 'Transfer',
            onPressed: () {
              // Transfer functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.local_hospital),
            tooltip: 'Medical History',
            onPressed: () {
              // Navigate to medical history screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(employee['profile_picture'] ?? ''),
              radius: 50,
            ),
            const SizedBox(height: 20),
            Text(
              'HRPN: ${employee['hrpn']}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Email: ${employee['email']}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Branch: ${employee['branch']}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Phone: ${employee['phone']}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'DOB: ${employee['dob']}',
              style: const TextStyle(fontSize: 18),
            ),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}
*/