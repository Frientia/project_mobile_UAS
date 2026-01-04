import 'package:flutter/material.dart';
import 'package:mobile_uas/pages/produkdetail_page.dart';
import 'package:mobile_uas/widgets/main_bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// ===============================================================
/// MODEL PRODUCT
/// ===============================================================
class Product {
  final String id;
  final String name;
  final String description;
  final int priceRegular;
  final int priceVip;
  final int stockRegular;
  final int stockVip;
  final String imageUrl;
  final String eventDate;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.priceRegular,
    required this.priceVip,
    required this.stockRegular,
    required this.stockVip,
    required this.imageUrl,
    required this.eventDate,
    required this.category,
  });

  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      priceRegular: json['price_regular'],
      priceVip: json['price_vip'],
      stockRegular: json['stock_regular'],
      stockVip: json['stock_vip'],
      imageUrl: json['image_url'] ?? '',
      eventDate: json['event_date'] ?? '-',
      category: json['category'] ?? 'Other',
    );
  }
}

/// ===============================================================
/// HOME PAGE
/// ===============================================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  String _name = "User";

  bool isLoading = true;
  bool _animate = false;
  bool _isGridView = false;

  String _selectedCategory = 'All';

  List<Product> products = [];

  List<String> categories = [];

    @override
    void initState() {
      super.initState();
      _loadSession();
      _loadProducts();

      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) setState(() => _animate = true);
      });
    }

  /// ===============================================================
  /// LOAD SESSION
  /// ===============================================================
  Future<void> _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? "User";
    });
  }

  /// ===============================================================
  /// FETCH PRODUCTS FROM SUPABASE (FIX ERROR)
  /// ===============================================================
    Future<void> _loadProducts() async {
    try {
      final response =
          await Supabase.instance.client.from('products').select();

      products =
          response.map<Product>((e) => Product.fromMap(e)).toList();

      final uniqueCategories = products
          .map((e) => e.category)
          .toSet()
          .toList();

      categories = ['All', ...uniqueCategories];
    } catch (_) {
      products = [];
      categories = ['All'];
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  /// ===============================================================
  /// UI
  /// ===============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3eaff),
      appBar: _buildAppBar(),
      body: _buildHomeUI(),
      bottomNavigationBar: MainBottomNav(
        currentIndex: 0,
        context: context,
      ),
    );
  }

   PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xfff3eaff),
      foregroundColor: Colors.black,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi, $_name",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            "Find events that match your vibe",
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  /// ===============================================================
  /// HOME CONTENT
  /// ===============================================================
  Widget _buildHomeUI() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHero(),
          const SizedBox(height: 20),
          _buildCategories(),
          const SizedBox(height: 24),
          _buildSectionHeader(),
          const SizedBox(height: 12),
          _buildEventContent(),
        ],
      ),
    );
  }

  /// ===============================================================
  /// HERO
  /// ===============================================================
  Widget _buildHero() {
    return AnimatedOpacity(
      opacity: _animate ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            image: AssetImage("assets/images/example.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  /// ===============================================================
  /// CATEGORIES (DINAMIS)
  /// ===============================================================
  Widget _buildCategories() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isActive = category == _selectedCategory;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isActive ? Color.fromARGB(255, 113, 50, 202) : Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isActive ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// ===============================================================
  /// SECTION HEADER
  /// ===============================================================
  Widget _buildSectionHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Popular Events",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
            child: Text(
              _isGridView ? "Collapse" : "See all",
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 113, 50, 202),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ===============================================================
  /// EVENT CONTENT
  /// ===============================================================
  Widget _buildEventContent() {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final filteredProducts = _selectedCategory == 'All'
        ? products
        : products
            .where((p) => p.category == _selectedCategory)
            .toList();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      child: _isGridView
          ? _buildGrid(filteredProducts)
          : _buildHorizontalList(filteredProducts),
    );
  }

  

  Widget _buildHorizontalList(List<Product> data) {
    return SizedBox(
      key: const ValueKey('list'),
      height: 330,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 14),
            child: SizedBox(
              width: 220,
              child: _eventCard(data[index]),
            ),
          );
        },
      ),
    );
  }

  /// ===============================================================
  /// EVENT CARD
  /// ===============================================================
  /// ===============================================================
  /// EVENT CARD
  /// ===============================================================
  Widget _eventVerticalCard({required Product product}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE + STATUS
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                  child: product.imageUrl.isNotEmpty
                      ? Image.network(
                          product.imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/images/02.jpeg",
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),

                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      "Tiket Tersedia",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 13,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    product.eventDate, // 🔥 DARI SUPABASE
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            /// PRICE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _priceRow(
                    label: "Reguler",
                    price: product.priceRegular,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(height: 4),
                  _priceRow(
                    label: "VIP",
                    price: product.priceVip,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MyProduk(
                          productId: product.id, 
                          firebaseUid: '',
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Lihat Detail",
                    style: TextStyle(
                      fontSize: 13, 
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                      ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ===============================================================
  /// PRICE ROW
  /// ===============================================================
  Widget _priceRow({
    required String label,
    required int price,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          "Rp $price",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _dummy() {
    return const Center(child: Text("Halaman lain masih dummy"));
  }
}
