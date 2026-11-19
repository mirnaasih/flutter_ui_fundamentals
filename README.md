Flutter UI Fundamentals - Course Data Manager
Aplikasi manajemen data mata kuliah (Course Data Manager) yang dikembangkan menggunakan Flutter dan terintegrasi dengan Supabase sebagai backend. Proyek ini menerapkan arsitektur Repository Pattern dan manajemen state berbasis Provider.

👤 Identitas Mahasiswa
Nama: Ni Komang Mirna Asih

NIM: 2415051018

Kelas: PTI 4B

Institusi: Universitas Pendidikan Ganesha (Undiksha)

Fitur Utama
Manajemen CRUD: Menambah (Create), melihat (Read), memperbarui (Update), dan menghapus (Delete) data mata kuliah.

State Management: Menggunakan package provider untuk pemisahan logika aplikasi dan UI secara bersih.

Repository Pattern: Memisahkan lapisan komunikasi data (Data Source & Repository) dari provider dan halaman tampilan (screen).

Penanganan Error: Mekanisme error handling yang tangguh untuk mengatasi gangguan koneksi atau kesalahan pemetaan data tanpa memicu crash.

🏗️ Arsitektur Singkat
Struktur direktori proyek disusun berdasarkan pemisahan tugas (separation of concerns):

lib/models/: Definisi model data objek Course.

lib/repositories/ & lib/services/: Lapisan akses data yang menghubungkan aplikasi dengan Supabase.

lib/providers/: Pengelolaan status dan alur logika data menggunakan ChangeNotifier.

lib/screens/: Antarmuka pengguna (User Interface) meliputi Dashboard, Add Course, Edit Course, dan Course Detail.

🗄️ Backend
Supabase: Menggunakan layanan basis data relasional PostgreSQL dari Supabase (vhkmszgznybztfxkckug) yang dilengkapi dengan lapisan keamanan Row Level Security (RLS).

⚙️ Cara Menjalankan Aplikasi
Clone repository ini ke komputer lokal Anda:git clone [https://github.com/mirnaasih/flutter_ui_fundamentals.git](https://github.com/mirnaasih/flutter_ui_fundamentals.git)

Masuk ke direktori proyek:cd flutter_ui_fundamentals

Unduh seluruh dependensi yang diperlukan:flutter pub get

Jalankan aplikasi di emulator, perangkat fisik, atau browser Chrome:flutter run
Atau jalankan secara khusus di Google Chrome:flutter run -d chrome