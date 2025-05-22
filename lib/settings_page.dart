// settings_page.dart
import 'package:flutter/material.dart';
import 'login.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _showBillingHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text("Billing History")),
          body: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16),
            children: [
              _buildBillingItem(
                date: "May 15, 2023",
                amount: "\$9.99",
                status: "Paid",
                isSuccessful: true,
              ),
              Divider(),
              _buildBillingItem(
                date: "April 15, 2023",
                amount: "\$9.99",
                status: "Paid",
                isSuccessful: true,
              ),
              Divider(),
              _buildBillingItem(
                date: "March 15, 2023",
                amount: "\$9.99",
                status: "Failed",
                isSuccessful: false,
              ),
              Divider(),
              _buildBillingItem(
                date: "February 15, 2023",
                amount: "\$9.99",
                status: "Paid",
                isSuccessful: true,
              ),
              Divider(),
              _buildBillingItem(
                date: "January 15, 2023",
                amount: "\$9.99",
                status: "Refunded",
                isSuccessful: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBillingItem({
    required String date,
    required String amount,
    required String status,
    required bool isSuccessful,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isSuccessful
              ? Colors.green.shade50
              : Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isSuccessful ? Icons.check : Icons.error_outline,
          color: isSuccessful ? Colors.green : Colors.grey,
        ),
      ),
      title: Text(date),
      subtitle: Text(status),
      trailing: Text(
        amount,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold, // Makes the text bold
          ),
        ),
        centerTitle: true, // Centers the title
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).padding.bottom + 16,
          ),
          child: Column(
            children: [
              // Account Settings Section
              _buildSettingsSection(
                context,
                title: "Account",
                children: [
                  _buildSettingsItem(
                    context,
                    icon: Icons.person_outline,
                    title: "Profile Information",
                    onTap: () => _showProfileSettings(context),
                  ),
                  Divider(height: 1, indent: 20),
                  _buildSettingsItem(
                    context,
                    icon: Icons.lock_outline,
                    title: "Change Password",
                    onTap: () => _showChangePasswordDialog(context),
                  ),
                  Divider(height: 1, indent: 20),
                  _buildSettingsItem(
                    context,
                    icon: Icons.email_outlined,
                    title: "Email Preferences",
                    onTap: () => _showEmailPreferences(context),
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Payment & Subscription Section
              _buildSettingsSection(
                context,
                title: "Payments",
                children: [
                  _buildSettingsItem(
                    context,
                    icon: Icons.payment_outlined,
                    title: "Payment Methods",
                    onTap: () => _showPaymentMethods(context),
                  ),
                  Divider(height: 1, indent: 20),
                  _buildSettingsItem(
                    context,
                    icon: Icons.receipt_outlined,
                    title: "Billing History",
                    onTap: () => _showBillingHistory(context),
                  ),
                  Divider(height: 1, indent: 20),
                  _buildSettingsItem(
                    context,
                    icon: Icons.credit_card_outlined,
                    title: "Subscription",
                    onTap: () => _showSubscriptionSettings(context),
                  ),
                ],
              ),

              SizedBox(height: 16),

              // App Settings Section
              _buildSettingsSection(
                context,
                title: "Preferences",
                children: [
                  _buildSettingsItem(
                    context,
                    icon: Icons.notifications_outlined,
                    title: "Notifications",
                    onTap: () => _showNotificationSettings(context),
                  ),
                  Divider(height: 1, indent: 20),
                  _buildSettingsItem(
                    context,
                    icon: Icons.security_outlined,
                    title: "Privacy & Security",
                    onTap: () => _showPrivacySettings(context),
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Support Section
              _buildSettingsSection(
                context,
                title: "Support",
                children: [
                  _buildSettingsItem(
                    context,
                    icon: Icons.feedback_outlined,
                    title: "Send Feedback",
                    onTap: () => _showFeedbackForm(context),
                  ),
                  Divider(height: 1, indent: 20),
                  _buildSettingsItem(
                    context,
                    icon: Icons.info_outline,
                    title: "About App",
                    onTap: () => _showAboutApp(context),
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Logout Card
              Card(
                elevation: 0,
                margin: EdgeInsets.only(bottom: 20),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                  ),
                  title: Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () => _confirmLogout(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsSection(
      BuildContext context, {
        required String title,
        required List<Widget> children,
      }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 16, bottom: 8),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        Color? titleColor,
        required VoidCallback onTap,
      }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFF38E54D).withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: titleColor ?? Color(0xFF38E54D),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  void _showProfileSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildProfileSettingsSheet(context),
    );
  }

  Widget _buildProfileSettingsSheet(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Profile Information",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: "Bio",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF38E54D),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text("Save Changes"),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Change Password", style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Current Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "New Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Confirm New Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Password changed successfully"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF38E54D),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              minimumSize: const Size(100, 44),
            ),
            child: const Text("Update", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showPaymentMethods(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text("Payment Methods")),
          body: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16),
            children: [
              _buildPaymentMethodCard(
                icon: Icons.credit_card,
                title: "Visa •••• 4242",
                subtitle: "Expires 05/25",
                isDefault: true,
              ),
              Divider(),
              _buildPaymentMethodCard(
                icon: Icons.paypal,
                title: "PayPal",
                subtitle: "user@example.com",
              ),
              Divider(),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF38E54D).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    color: Color(0xFF38E54D),
                  ),
                ),
                title: Text(
                  "Add Payment Method",
                  style: TextStyle(
                    color: Color(0xFF38E54D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => _showAddPaymentMethod(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard({
    required IconData icon,
    required String title,
    required String subtitle,
    bool isDefault = false,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFF38E54D).withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Color(0xFF38E54D)),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: isDefault
          ? Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.shade100),
        ),
        child: Text(
          "Default",
          style: TextStyle(
            color: Colors.green.shade800,
            fontSize: 12,
          ),
        ),
      )
          : null,
    );
  }

  void _showAddPaymentMethod(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Add Payment Method",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: "Card Number",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Expiry Date",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "CVV",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  labelText: "Cardholder Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Payment method added successfully"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF38E54D),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Add Card"),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  void _showSubscriptionSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text("Subscription")),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Color(0xFF38E54D),
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Color(0xFF38E54D)),
                            SizedBox(width: 10),
                            Text(
                              "Premium Plan",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "\$9.99/month",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Billed monthly, cancel anytime",
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade200,
                            foregroundColor: Colors.red,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text("Cancel Subscription"),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Subscription History",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text("Payment received - \$9.99"),
                  subtitle: Text("May 15, 2023"),
                  trailing: Text("Active"),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text("Payment received - \$9.99"),
                  subtitle: Text("April 15, 2023"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEmailPreferences(BuildContext context) {
    Map<String, bool> preferences = {
      "Product updates": false,
      "Newsletter": false,
      "Special offers": false,
      "Account notifications": false,
    };

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Email Preferences",
            style: TextStyle(
              color: Color(0xFF38E54D),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: preferences.keys.map((key) {
                  return SwitchListTile(
                    title: Text(key),
                    value: preferences[key]!,
                    activeColor: Color(0xFF38E54D),
                    onChanged: (value) {
                      setState(() {
                        preferences[key] = value;
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Close",
                style: TextStyle(color: Color(0xFF38E54D)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showNotificationSettings(BuildContext context) {
    Map<String, bool> settings = {
      "Push notifications": true,
      "Email notifications": false,
      "Sound": true,
      "Vibration": false,
    };

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Notification Settings",
            style: TextStyle(
              color: Color(0xFF38E54D),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: settings.keys.map((key) {
                  return SwitchListTile(
                    title: Text(key),
                    value: settings[key]!,
                    activeColor: Color(0xFF38E54D),
                    onChanged: (value) {
                      setState(() {
                        settings[key] = value;
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Close",
                style: TextStyle(color: Color(0xFF38E54D)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacySettings(BuildContext context) {
    Map<String, bool> settings = {
      "Private account": false,
      "Data sharing": true,
      "Location services": true,
      "Cookies": false,
    };

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Privacy & Security",
            style: TextStyle(
              color: Color(0xFF38E54D),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: settings.keys.map((key) {
                  return SwitchListTile(
                    title: Text(key),
                    value: settings[key]!,
                    activeColor: Color(0xFF38E54D),
                    onChanged: (value) {
                      setState(() {
                        settings[key] = value;
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Close",
                style: TextStyle(color: Color(0xFF38E54D)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showFeedbackForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Send Feedback",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: "Subject",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  labelText: "Your Feedback",
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Thank you for your feedback!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF38E54D),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Submit"),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  void _showAboutApp(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: "Your App Name",
      applicationVersion: "Version 1.0.0",
      applicationLegalese: "© 2023 Your Company",
      children: [
        SizedBox(height: 20),
        Text("A beautiful app for managing your projects and tools"),
      ],
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Log Out"),
        content: Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
              );
            },
            child: Text(
              "Log Out",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}