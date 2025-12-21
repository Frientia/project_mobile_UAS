import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// ===============================================================
/// MODEL PRODUCT
/// ===============================================================
class Product {
  final String id;
  final String name;
  final int priceRegular;
  final int priceVip;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.priceRegular,
    required this.priceVip,
    required this.imageUrl,
  });

  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      priceRegular: json['price_regular'],
      priceVip: json['price_vip'],
      imageUrl: json['image_url'] ?? '',
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
  bool isLoading = true;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  /// ===============================================================
  /// FETCH PRODUCTS FROM SUPABASE
  /// ===============================================================
  Future<void> _loadProducts() async {
    final response = await Supabase.instance.client.from('products').select();

    products = (response as List)
        .map<Product>((e) => Product.fromMap(e))
        .toList();

    setState(() => isLoading = false);
  }

  /// ===============================================================
  /// UI
  /// ===============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3eaff),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xfff3eaff),
        foregroundColor: Colors.black,
        title: const Text(
          "Events",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildHomeUI(),
    );
  }

  /// ===============================================================
  /// HOME CONTENT
  /// ===============================================================
  Widget _buildHomeUI() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          /// HERO BANNER
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage("assets/images/example.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// TITLE
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Events of The Month",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 12),

          /// HORIZONTAL EVENT LIST
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SizedBox(
                    width: 220,
                    child: _eventVerticalCard(product: p),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  /// ===============================================================
  /// EVENT CARD (COMMIT 5)
  /// ===============================================================
  Widget _eventVerticalCard({required Product product}) {
    return Container(
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
          /// IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
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

          const SizedBox(height: 8),

          /// TITLE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 8),

          /// PRICE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reguler Rp ${product.priceRegular}",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "VIP Rp ${product.priceVip}",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
