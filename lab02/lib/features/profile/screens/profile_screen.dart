import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade700],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 70,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'john.doe@example.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // Profile Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Account Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  _buildInfoCard(
                    icon: Icons.phone,
                    title: 'Phone',
                    subtitle: '+92 300 1234567',
                  ),
                  const SizedBox(height: 10),

                  _buildInfoCard(
                    icon: Icons.location_on,
                    title: 'Location',
                    subtitle: 'Karachi, Pakistan',
                  ),
                  const SizedBox(height: 10),

                  _buildInfoCard(
                    icon: Icons.calendar_today,
                    title: 'Member Since',
                    subtitle: 'January 2024',
                  ),
                  const SizedBox(height: 30),

                  // Action Buttons
                  const Text(
                    'Actions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  _buildActionButton(
                    context,
                    icon: Icons.edit,
                    title: 'Edit Profile',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Edit Profile feature coming soon!'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  _buildActionButton(
                    context,
                    icon: Icons.lock_reset,
                    title: 'Change Password',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Change Password feature coming soon!'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  _buildActionButton(
                    context,
                    icon: Icons.delete_outline,
                    title: 'Delete Account',
                    color: Colors.red,
                    onTap: () {
                      _showDeleteDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(icon, color: Colors.blue.shade700),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    Color? color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: color ?? Colors.blue.shade700),
        title: Text(
          title,
          style: TextStyle(
            color: color ?? Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account deletion feature coming soon!'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
