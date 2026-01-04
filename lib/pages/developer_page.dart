import 'package:flutter/material.dart';

class MyDeveloper extends StatefulWidget {
  const MyDeveloper({super.key});

  @override
  State<MyDeveloper> createState() => _MyDeveloperState();
}

class _MyDeveloperState extends State<MyDeveloper> {
  static const Color primaryColor = Color.fromARGB(255, 113, 50, 202);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3eaff),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Developer'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _DeveloperCard(
              name: 'Agra Hafiz',
              role: 'Flutter Developer',
              image: 'assets/images/developer/people.png',
              onTap: () {},
              isMain: true,
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _DeveloperCard(
                    name: 'Developer 2',
                    role: 'Backend',
                    image: 'assets/images/developer/people.png',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _DeveloperCard(
                    name: 'Developer 3',
                    role: 'UI/UX',
                    image: 'assets/images/developer/people.png',
                    onTap: () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _DeveloperCard extends StatefulWidget {
  final String name;
  final String role;
  final String image;
  final VoidCallback onTap;
  final bool isMain;

  const _DeveloperCard({
    required this.name,
    required this.role,
    required this.image,
    required this.onTap,
    this.isMain = false,
  });

  @override
  State<_DeveloperCard> createState() => _DeveloperCardState();
}

class _DeveloperCardState extends State<_DeveloperCard> {
  double _scale = 1;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 120), () {
      if (mounted) {
        setState(() => _visible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 120),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTapDown: (_) => setState(() => _scale = 0.97),
        onTapCancel: () => setState(() => _scale = 1),
        onTapUp: (_) {
          setState(() => _scale = 1);
          widget.onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: AnimatedOpacity(
                  opacity: _visible ? 1 : 0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                  child: AnimatedScale(
                    scale: _visible ? 1 : 0.85,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutBack,
                    child: Padding(
                      padding: EdgeInsets.all(widget.isMain ? 24 : 0),
                      child: AspectRatio(
                        aspectRatio: widget.isMain ? 1.2 : 1,
                        child: Image.asset(widget.image, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Center(
                child: Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              Center(
                child: Text(
                  widget.role,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),

              const SizedBox(height: 14),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 38,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _MyDeveloperState.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: widget.onTap,
                    child: const Text(
                      'Detail Developer',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
