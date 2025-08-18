import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Directory"),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: users.isEmpty
          ? const Center(
        child: Text(
          "No data yet. Tap fetch button!",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final fullName =
                "${user["name"]["title"]} ${user["name"]["first"]} ${user["name"]["last"]}";
            final email = user["email"];
            final phone = user["phone"];
            final city = user["location"]["city"];
            final country = user["location"]["country"];
            final age = user["dob"]["age"];
            final imageUrl = user["picture"]["large"];

            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                title: Text(
                  fullName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("📍 $city, $country"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailPage(user: user),
                    ),
                  );
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: fetchUsers,
        backgroundColor: Colors.deepOrange,
        icon: const Icon(Icons.access_time_rounded),
        label: const Text("Refresh"),
      ),
    );
  }

  void fetchUsers() async {
    const url = "https://randomuser.me/api/?results=20";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        users = json['results'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Failed to fetch users")),
      );
    }
  }
}

class UserDetailPage extends StatelessWidget {
  final dynamic user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final fullName =
        "${user["name"]["title"]} ${user["name"]["first"]} ${user["name"]["last"]}";
    final email = user["email"];
    final phone = user["phone"];
    final cell = user["cell"];
    final city = user["location"]["city"];
    final state = user["location"]["state"];
    final country = user["location"]["country"];
    final age = user["dob"]["age"];
    final imageUrl = user["picture"]["large"];
    final username = user["login"]["username"];

    return Scaffold(
      appBar: AppBar(
        title: Text(fullName),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(imageUrl),
            ),
            const SizedBox(height: 20),
            Text(
              fullName,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "@$username",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Divider(height: 40, thickness: 1),
            infoRow(Icons.email, "Email", email),
            infoRow(Icons.phone, "Phone", phone),
            infoRow(Icons.phone_android, "Cell", cell),
            infoRow(Icons.cake, "Age", "$age"),
            infoRow(Icons.location_on, "Location", "$city, $state, $country"),
          ],
        ),
      ),
    );
  }

  Widget infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepOrange),
          const SizedBox(width: 10),
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
