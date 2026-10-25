Course Explorer v2

Aplikasi eksplorasi mata kuliah berbasis Flutter yang menerapkan prinsip Clean Architecture dan Separation of Concerns menggunakan Provider State Management.

Identitas 

- Nama: Ni Komang Mirna Asih  
- NIM: 2415051018  
- Program Studi: Pendidikan Teknik Informatika (PTI)  
- Universitas: Universitas Pendidikan Ganesha (Undiksha)  

Arsitektur dan Alur Data (Dependency Direction)
Aplikasi ini dirancang dengan alur dependensi satu arah yang terstruktur:
Screen / Widget -> Provider -> Repository -> Service

Setiap lapisan memiliki tanggung jawab spesifik yang terisolasi dengan jelas guna memastikan kode mudah diuji, dirawat, dan dikembangkan.

Struktur Direktori dan Tanggung Jawab Layer (lib/)

models/
Menyimpan definisi kelas entitas data (seperti objek Course) beserta fungsi serialisasi atau parsing format JSON.

services/
Bertanggung jawab penuh dalam mengambil data mentah dari sumber eksternal atau lokal menggunakan rootBundle.

repositories/
Berperan sebagai jembatan atau abstraksi data antara Provider dan Service, menyaring data agar siap dikonsumsi.

providers/
Mengelola Application State dan Async State (seperti status loading, error, daftar courses, dan manajemen favorites) serta memicu pembaruan UI via notifyListeners().

screens/
Berisi halaman-halaman utama antarmuka pengguna aplikasi (Home, Courses, Favorites, Profile/Feedback, dan Detail).

widgets/
Menyimpan komponen UI modular yang dapat digunakan kembali lintas halaman (misalnya StudentHeader).

Fitur Utama
1. Async State Management: Menangani kondisi Loading, Success, dan Error secara dinamis saat memuat data.
2. Shared Favorites: Manajemen state terpusat untuk menyinkronkan status mata kuliah favorit lintas layar secara real-time.
3. Responsive Layout: Mendukung tampilan adaptif menggunakan NavigationRail untuk layar lebar dan NavigationBar untuk layar seluler.
4. Student Identity Integration: Menampilkan identitas dan profil mahasiswa secara konsisten di berbagai modul aplikasi.

Informasi REST Endpoint Course API
- URL Endpoint: https://course-api-pearl.vercel.app/courses
- HTTP Method: GET
- Status Code: 200 OK
- Field JSON: id, code, title, credits, status