# MyConcert App - Flutter Application

<div align="center">
<url>
  <img width="300" height="301" alt="Institut Teknologi dan Bisnis Bina Sarana Global" src="https://github.com/user-attachments/assets/1e84f66a-135b-4cf2-b07a-b2a9098ce119" width="200"/>
  </div>
<div align="center">
Institut Teknologi dan Bisnis Bina Sarana Global <br>
FAKULTAS TEKNOLOGI INFORMASI & KOMUNIKASI 
<br>
https://global.ac.id/
  </div>

  ##  Project UAS
  - Mata Kuliah : Aplikasi Mobile
  - Kelas : TI-SE 23 M 
  - Semester : GANJIL 
  - Tahun Akademik: 2025 - 2026 
  
  

## About The Project

MyConcert adalah aplikasi mobile modern yang dikembangkan menggunakan Flutter, dirancang untuk membantu para pencinta musik dalam melakukan pembelian tiket konser secara mudah, aman, dan terstruktur. Aplikasi ini bertujuan untuk meningkatkan efisiensi penjualan tiket sekaligus meminimalkan praktik percaloan dengan sistem pemesanan yang terkontrol dan transparan.

MyConcert menyediakan antarmuka pengguna yang intuitif dan responsif, sehingga pengguna dapat dengan mudah menelusuri konser yang tersedia, melihat detail acara, serta melakukan pemesanan tiket secara real-time. Untuk mendukung keamanan dan kenyamanan pengguna, aplikasi ini mengintegrasikan Firebase Authentication sebagai sistem autentikasi, memungkinkan proses login dan manajemen akun yang aman.

Sebagai backend database, MyConcert menggunakan Supabase, yang berperan dalam pengelolaan data konser, tiket, transaksi, dan riwayat pemesanan secara terpusat dan sinkron. Dengan dukungan sinkronisasi cloud, data pengguna dapat diakses secara konsisten di berbagai perangkat.

Dengan kombinasi teknologi modern, arsitektur yang terstruktur, dan fokus pada pengalaman pengguna, MyConcert diharapkan dapat menjadi solusi digital yang efektif bagi penyelenggara acara maupun penonton dalam ekosistem industri musik.

### Key Features

* **Modern UI/UX Design** – Antarmuka yang clean, responsif, dan user-friendly untuk meningkatkan pengalaman pengguna
* **Concert Discovery** – Menjelajahi daftar konser berdasarkan Kategori
* **Secure Ticket Booking** – Pemesanan tiket yang aman dan terstruktur untuk meminimalkan praktik percaloan
* **Digital Ticket Management** – Penyimpanan dan pengelolaan tiket digital secara terpusat
* **Cloud Sync** – Sinkronisasi data otomatis menggunakan Firebase dan Supabase
* **Authentication System** – Login dan manajemen akun pengguna dengan Firebase Authentication
* **Transaction History** – Riwayat pemesanan dan pembayaran yang terdokumentasi dengan baik

## Screenshots

<div align="center">
  <img src="screenshots/splash_screen.png" alt="Splash Screen" width="200"/>
  <img src="screenshots/login_screen.png" alt="Login" width="200"/>
  <img src="screenshots/home_screen.png" alt="Home" width="200"/>
  <img src="screenshots/profile_screen.png" alt="Profile" width="200"/>
</div>

<div align="center">
  <img src="screenshots/note_detail.png" alt="Note Detail" width="200"/>
  <img src="screenshots/search.png" alt="Search" width="200"/>
  <img src="screenshots/category.png" alt="Category" width="200"/>
  <img src="screenshots/settings.png" alt="Settings" width="200"/>
</div>

## Demo Video

Lihat video demo aplikasi kami untuk melihat semua fitur dalam aksi!

**[Watch Full Demo on YouTube]()**

Alternative link: **[Google Drive Demo]()**

## Download APK

Download versi terbaru aplikasi Notes App:

### Latest Release v1.0.0
- [**Download APK (15.2 MB)**]()


**Minimum Requirements:**
- Android 6.0 (API level 23) or higher
- ~20MB free storage space

## Built With

- **[Flutter](https://flutter.dev/)** - UI Framework
- **[Dart](https://dart.dev/)** - Programming Language
- **[Firebase](https://firebase.google.com/)** - Backend & Authentication
- **[Supabase](https://supabase.com/)** - Backend Database
- **[Provider](https://pub.dev/packages/provider)** - State Management


## Getting Started

### Prerequisites

Pastikan Anda sudah menginstall:
- Flutter SDK (3.16.0 or higher)
- Dart SDK (3.2.0 or higher)
- Android Studio / VS Code
- Git

### Installation

1. Clone repository
```bash
git clone https://github.com/Frientia/project_mobile_UAS.git
cd mobile_uas
```

2. Install dependencies
```bash
flutter pub get
```

3. Setup Firebase
```bash
# Download google-services.json dari Firebase Console
# Place in android/app/
cp path/to/google-services.json android/app/
```
4. Setup supabase
```bash
# Copy .env.example secara manual, atau
cp .env.example .env
# pada terminal
# setelah itu ambil SUPABASE_URL dan SUPABASE_ANON_KEY di supabase
```

5. Run aplikasi
```bash
flutter run
```

### Build APK

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# Split APK by ABI
flutter build apk --split-per-abi
```

## 📁 Project Structure

```
lib/
├── main.dart                     # Entry point aplikasi
├── firebase_options.dart         # Konfigurasi Firebase
│
├── pages/                        # Halaman utama aplikasi
│   ├── about_page.dart           # Halaman informasi aplikasi (About)
│   ├── detail_pesanan_page.dart  # Detail pesanan tiket
│   ├── developer_page.dart       # Halaman profil untuk cek list developer
│   ├── home_page.dart            # Halaman utama (Home)
│   ├── login_page.dart           # Halaman login pengguna
│   ├── menu_page.dart            # Halaman menu utama / navigasi
│   ├── payment_page.dart         # Halaman pembayaran tiket
│   ├── produkdetail_page.dart    # Detail produk / konser
│   ├── profile_page.dart         # Profil pengguna
│   ├── register_page.dart        # Halaman registrasi
│   └── riwayat_pesanan.dart      # Riwayat pemesanan tiket
│
├── profil_dev/                   # Profil tim developer
│   ├── profil_agra.dart
│   ├── profil_aji.dart
│   └── profil_yajid.dart
│
├── screens/                      # Splash & feedback screen
│   ├── lottie_success.dart       # Animasi pembayaran sukses (Lottie)
│   ├── splash_launch_screen.dart # Splash awal aplikasi
│   ├── splash_lottie.dart        # Lottie untuk transisi antara Splash 3 dan Login
│   ├── splash_screen1.dart       # Splash screen 1
│   ├── splash_screen2.dart       # Splash screen 2
│   └── splash_screen3.dart       # Splash screen 3
│
├── widgets/                      # Widget reusable
│   └── main_bottom_nav.dart      # Bottom navigation bar utama

```

## Authentication Flow

```
1. Splash Screen (Auto-login check)
   ↓
2. Login Screen / Register Screen
   ↓
3. Home Screen (Dashboard)
   ↓
4. Profile & Settings
```

## 🗄️ Database Schema

### Notes Table
```sql

-- WARNING: This schema is for context only and is not meant to be run.
-- Table order and constraints may not be valid for execution.

CREATE TABLE public.order_items (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  order_id uuid NOT NULL,
  product_id uuid NOT NULL,
  ticket_type text NOT NULL,
  quantity integer NOT NULL,
  price_each integer NOT NULL,
  subtotal integer NOT NULL,
  day text,
  CONSTRAINT order_items_pkey PRIMARY KEY (id),
  CONSTRAINT fk_items_order FOREIGN KEY (order_id) REFERENCES public.orders(id),
  CONSTRAINT fk_items_product FOREIGN KEY (product_id) REFERENCES public.products(id)
);
CREATE TABLE public.orders (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  firebase_uid text NOT NULL,
  total_price integer NOT NULL,
  status text NOT NULL DEFAULT 'pending'::text,
  created_at timestamp with time zone DEFAULT now(),
  payment_method text,
  CONSTRAINT orders_pkey PRIMARY KEY (id),
  CONSTRAINT fk_order_user FOREIGN KEY (firebase_uid) REFERENCES public.users(firebase_uid)
);
CREATE TABLE public.products (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  price_regular integer NOT NULL,
  price_vip integer NOT NULL,
  stock_regular integer NOT NULL DEFAULT 0,
  stock_vip integer NOT NULL DEFAULT 0,
  image_url text,
  created_at timestamp with time zone DEFAULT now(),
  available_days ARRAY,
  location text,
  event_date text,
  event_time text,
  category text,
  CONSTRAINT products_pkey PRIMARY KEY (id)
);
CREATE TABLE public.users (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  firebase_uid text NOT NULL UNIQUE,
  name text,
  email text UNIQUE,
  phone text,
  created_at timestamp with time zone DEFAULT now(),
  avatar_url text,
  CONSTRAINT users_pkey PRIMARY KEY (id)
);

```


## 📝 API Documentation

### Authentication Endpoints
- `POST /api/auth/register` - Register user baru
- `POST /api/auth/login` - Login user
- `POST /api/auth/logout` - Logout user
- `GET /api/auth/verify` - Verify token

Berikut **versi Development Workflow yang sudah ditambahkan penjelasan peran Admin / Project Lead**, rapi, konsisten, dan siap langsung Anda tempel ke README atau laporan proyek.

---

## Development Workflow

### Member Flow

```
git clone
  ↓
git checkout integration
  ↓
git pull origin integration
  ↓
git checkout -b Feature/NamaFitur
  ↓
git add .
  ↓
git commit -m "feat: deskripsi fitur"
  ↓
git push -u origin Feature/NamaFitur
  ↓
Pull Request di GitHub
```

**Tanggung Jawab Member:**

* Mengembangkan fitur sesuai scope
* Menjaga commit tetap jelas dan spesifik
* Tidak melakukan merge ke `integration`
* Memastikan fitur dapat dijalankan sebelum membuat Pull Request

---

### 🛠️ Project Lead / Admin Flow

```
git clone
  ↓
git checkout integration
  ↓
git pull origin integration
  ↓
git fetch origin Feature/NamaFitur
  ↓
Review kode (local & Pull Request)
  ↓
Resolve conflict (jika ada)
  ↓
Approve / Comment pada Pull Request
  ↓
Rebase atau merge ke integration
  ↓
Atau: Reject / Close Pull Request
```

**Tanggung Jawab Project Lead / Admin:**

* Menjaga stabilitas branch `integration`
* Melakukan code review terhadap setiap Pull Request
* Menyelesaikan konflik dependency dan source code
* Menentukan strategi integrasi (rebase atau merge)
* Menolak Pull Request yang tidak sesuai standar proyek

## Team Members & Contributions

### Development Team

| Name | Role | Contributions |
|------|------|---------------|
| **Muhaad Yajid Rizky** | Project Lead & Fullstack Developer | - Authentication system<br>- Firebase integration<br>- API development<br>- Database design<br>- Github Manajement<br>-Supabase integration<br>- Profile screen |
| **Aditya Aji Pramono** | Full Stack Developer | - Splash Screen<br>- Home screen implementation<br>- Profile screen<br>- Riwayat Pemesanan - Detail Pemesanan |
| **Agra Alfian Hafiz** | Full Stack Developer | - Splash screen<br>- Register screen<br>- Profile User <br>- Lotie <br>- Menu<br>- Developer Profile List<br>- Profile screen  |


## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.



## Acknowledgments

- [Flutter Community](https://flutter.dev/community) - For amazing packages
- [Firebase](https://firebase.google.com/) - For backend services
- [Flaticon](https://www.flaticon.com/) - For app icons
- [Unsplash](https://unsplash.com/) - For placeholder images



---

<div align="center">
  <p>Made with by Mafia Sawit Team</p>
  <p>© 2026 Notes App. All rights reserved.</p>
</div>
