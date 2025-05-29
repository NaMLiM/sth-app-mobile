import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, this.username = 'User'});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // 1. Add SingleTickerProviderStateMixin
  bool _isLoading = true;
  List<Map<String, dynamic>> _rabItems = [];

  final List<Map<String, dynamic>> _sourceRabItems = const [
    // ... your RAB items data
    {
      'id': '1',
      'title': 'Nama Proyek RAB Alpha',
      'icon': Icons.description_outlined,
      'status': 'Pending',
    },
    {
      'id': '2',
      'title': 'Renovasi Gedung Utama',
      'icon': Icons.folder_copy_outlined,
      'status': 'Approved',
    },
    {
      'id': '3',
      'title': 'Instalasi Jaringan Baru',
      'icon': Icons.lan_outlined,
      'status': 'In Progress',
    },
    {
      'id': '4',
      'title': 'Desain Interior Kantor Cabang',
      'icon': Icons.design_services_outlined,
      'status': 'Completed',
    },
    {
      'id': '5',
      'title': 'Proyek Pembangunan Jalan Tol',
      'icon': Icons.add_road,
      'status': 'Pending',
    },
    {
      'id': '6',
      'title': 'Maintenance Server Pusat Data',
      'icon': Icons.dns_outlined,
      'status': 'Approved',
    },
    {
      'id': '7',
      'title': 'Pengembangan Aplikasi Mobile V2',
      'icon': Icons.smartphone,
      'status': 'In Progress',
    },
    {
      'id': '8',
      'title': 'Pemasangan Panel Surya Rooftop',
      'icon': Icons.solar_power_outlined,
      'status': 'Completed',
    },
    {
      'id': '9',
      'title': 'Audit Sistem Keamanan Jaringan',
      'icon': Icons.security_outlined,
      'status': 'Pending',
    },
    {
      'id': '10',
      'title': 'Upgrade Infrastruktur IT Sekolah',
      'icon': Icons.network_check_outlined,
      'status': 'Approved',
    },
  ];

  // 2. AnimationController for more complex or continuous animations (optional, TweenAnimationBuilder is simpler for this)
  // late AnimationController _animationController;
  // late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _fetchRabData();

    // Example using AnimationController (more complex setup)
    /*
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true); // Loop back and forth

    _colorAnimation = ColorTween(
      begin: Colors.blue[300],
      end: Colors.purple[300],
    ).animate(_animationController);
    */
  }

  Future<void> _fetchRabData() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() {
        _rabItems = List.from(_sourceRabItems);
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // _animationController.dispose(); // 3. Dispose controller if using AnimationController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: TweenAnimationBuilder<Color?>(
                tween: ColorTween(
                  begin: Colors.orange[400],
                  end: Colors.orange[700],
                ),
                duration: const Duration(seconds: 4),
                builder: (BuildContext context, Color? color, Widget? child) {
                  return Container(
                    color: color,
                  );
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 4. Wrap the welcome section with TweenAnimationBuilder
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(32.0, 96.0, 32.0, 64.0),
                  child: Text(
                    // This child is passed to the builder and doesn't rebuild
                    'Selamat datang, ${widget.username}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color:
                          Colors
                              .white, // Make text white for better contrast on colored background
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    // ... rest of your white container and its content
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      top: 0,
                    ), // Adjusted margin since background container handles spacing
                    padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildSquareButton(
                              context: context,
                              icon: Icons.list_alt,
                              label: 'Item List',
                              onPressed: () {},
                            ),
                            _buildSquareButton(
                              context: context,
                              icon: Icons.create_new_folder_outlined,
                              label: 'Create RAB',
                              onPressed: () {},
                            ),
                            _buildSquareButton(
                              context: context,
                              icon: Icons.map_outlined,
                              label: 'ODP Map',
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          'RAB List',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child:
                              _isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : _rabItems.isEmpty
                                  ? Center(child: Text('Tidak ada data RAB.'))
                                  : ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: _rabItems.length,
                                    itemBuilder: (context, index) {
                                      final item = _rabItems[index];
                                      return Card(
                                        elevation: 2,
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 6.0,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                        ),
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                                vertical: 10.0,
                                              ),
                                          leading: Icon(
                                            item['icon'] as IconData? ??
                                                Icons.error_outline,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).primaryColorDark,
                                            size: 30.0,
                                          ),
                                          title: Text(
                                            item['title'] as String? ??
                                                'No Title',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            item['status'] as String? ??
                                                'No Status',
                                          ),
                                          trailing: IconButton(
                                            icon: Icon(
                                              Icons.visibility_outlined,
                                            ),
                                            onPressed: () {
                                              print(
                                                'View ${item['title']} pressed',
                                              );
                                            },
                                            tooltip: 'View Details',
                                          ),
                                          onTap: () {
                                            print('Tapped on ${item['title']}');
                                          },
                                        ),
                                      );
                                    },
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    double size = 80.0,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: size * 0.4),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: size * 0.15),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
