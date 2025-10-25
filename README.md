# TiketMusik - Aplikasi Pencarian Tiket Konser

TiketMusik adalah sebuah aplikasi mobile sederhana yang dibuat menggunakan Flutter. Aplikasi ini berfungsi sebagai platform untuk menemukan dan "membeli" tiket acara-acara musik. Proyek ini didesain dengan UI/UX yang modern, responsif, dan menggunakan tema gelap yang elegan.

## 📸 Tangkapan Layar (Screenshots)

| Halaman Utama (Home) | Halaman Detail Acara | Halaman Tiket Saya |
| :---: | :---: | :---: |
| ![Home Page](https://via.placeholder.com/250x500.png?text=Home+Page) | ![Event Detail](https://via.placeholder.com/250x500.png?text=Event+Detail) | ![My Ticket](https://via.placeholder.com/250x500.png?text=My+Ticket) |
| **Halaman Login** | **Halaman Bookmark** | **Halaman Discovery** |
| ![Login Page](https://via.placeholder.com/250x500.png?text=Login+Page) | ![Bookmark Page](https://via.placeholder.com/250x500.png?text=Bookmark+Page) | ![Discovery Page](https://via.placeholder.com/250x500.png?text=Discovery+Page) |

*(Catatan: Ganti URL placeholder di atas dengan path ke tangkapan layar aplikasi Anda setelah Anda membuatnya)*

## ✨ Fitur-fitur

- **Splash Screen**: Tampilan pembuka yang menarik saat aplikasi pertama kali dijalankan.
- **Sistem Login & Registrasi**: Simulasi autentikasi pengguna (data disimpan sementara di memori).
- **Navigasi Intuitif**: Menggunakan `BottomNavigationBar` untuk berpindah antar halaman utama.
- **Halaman Utama (Home)**: Menampilkan acara utama dan daftar acara yang akan datang dalam format grid.
- **Halaman Temukan (Discovery)**: Fitur untuk eksplorasi acara berdasarkan kategori dan daftar acara unggulan.
- **Fungsi Pencarian**: Memungkinkan pengguna mencari acara berdasarkan nama atau lokasi.
- **Fitur Bookmark**: Pengguna dapat menyimpan acara yang mereka sukai dan melihatnya di halaman Bookmark.
- **Halaman Detail Acara**: Menampilkan informasi lengkap tentang acara, termasuk deskripsi, tanggal, lokasi, dan harga.
- **Simulasi Pembelian Tiket**: Proses "pembelian" tiket dengan animasi loading dan notifikasi sukses.
- **Halaman Tiket Saya**: Menampilkan daftar semua tiket yang telah berhasil "dibeli" oleh pengguna.

## 🚀 Memulai (Getting Started)

Untuk menjalankan proyek ini di lingkungan lokal Anda, ikuti langkah-langkah berikut.

### Prasyarat

Pastikan Anda telah menginstal Flutter SDK di komputer Anda. Untuk panduan instalasi, silakan kunjungi dokumentasi resmi Flutter.

### Instalasi

1.  **Clone repositori ini:**
    ```sh
    git clone https://github.com/username/tiketmusik.git
    cd tiketmusik
    ```

2.  **Instal dependensi:**
    Jalankan perintah berikut di terminal untuk mengunduh semua package yang dibutuhkan.
    ```sh
    flutter pub get
    ```

3.  **Jalankan aplikasi:**
    Hubungkan perangkat atau jalankan emulator, lalu eksekusi perintah berikut.
    ```sh
    flutter run
    ```

## 📂 Struktur Proyek

Struktur file utama dalam direktori `lib/` diatur sebagai berikut untuk keterbacaan dan skalabilitas:

```
lib/
├── main.dart                   # Titik masuk utama aplikasi dan SplashScreen
├── login_page.dart             # Halaman untuk login pengguna
├── register_page.dart          # Halaman untuk registrasi pengguna baru
├── main_page.dart              # Widget utama yang mengatur BottomNavigationBar dan halaman-halaman
├── home_page.dart              # Konten untuk tab Home
├── discovery_page.dart         # Konten untuk tab Discovery/Temukan
├── bookmark_page.dart          # Konten untuk tab Bookmark
├── my_ticket_page.dart         # Konten untuk tab Tiket Saya
├── event_detail_page.dart      # Halaman untuk menampilkan detail sebuah acara
└── event_ticket_page.dart      # Halaman untuk menampilkan tiket yang sudah dibeli
```

## 📦 Dependensi Utama

- `flutter/material.dart`: Komponen inti dan widget dari Material Design.
- `google_fonts`: Untuk menggunakan berbagai macam font dari Google Fonts dengan mudah.

## 💡 Potensi Pengembangan

Beberapa ide untuk pengembangan lebih lanjut:
- Mengintegrasikan dengan backend sungguhan (seperti Firebase) untuk autentikasi dan database.
- Menambahkan fitur filter acara berdasarkan genre musik, rentang harga, atau tanggal.
- Implementasi sistem pembayaran tiket.
- Menambahkan profil pengguna.
