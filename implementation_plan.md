# Rencana Pengembangan Lanjutan Aplikasi SIMPEL

Aplikasi SIMPEL (Sistem Pelaporan Monitoring Desa) saat ini sudah memiliki rancangan UI dan routing dasar menggunakan GetX. Untuk membuatnya berfungsi secara penuh dengan data yang *real-time* dan dinamis, kita perlu menghubungkannya dengan backend (database) dan layanan pihak ketiga (seperti peta dan penyimpanan file).

Berikut adalah rincian tugas yang perlu diselesaikan. Saya telah membaginya menjadi dua bagian: **Apa yang perlu Anda (USER) siapkan**, dan **Apa yang akan saya (AI) kerjakan**.

## ⚠️ TUGAS ANDA (USER): Yang Perlu Disiapkan

Karena aplikasi ini membutuhkan layanan pihak ketiga yang terkait dengan akun Google/Firebase Anda, berikut adalah hal-hal yang perlu Anda buat dan siapkan:

> [!IMPORTANT]
> **1. Buat Project Firebase**
> - Buka [Firebase Console](https://console.firebase.google.com/) dan buat project baru (misal: `simpel-desa`).
> - Daftarkan aplikasi Android di project tersebut dengan *package name* aplikasi Anda.
> - Unduh file **`google-services.json`** dan letakkan di dalam folder `android/app/`.

> [!IMPORTANT]
> **2. Aktifkan Layanan Firebase Berikut:**
> - **Authentication**: Aktifkan metode *Email/Password* dan *Google Sign-In*.
> - **Firestore Database**: Buat database baru (mulai dengan *Test Mode* terlebih dahulu agar kita bisa membaca/menulis data).
> - **Firebase Storage**: Aktifkan untuk menyimpan gambar (foto profil, foto laporan warga, foto pembangunan).

> [!IMPORTANT]
> **3. Siapkan Polygon / Batas Desa (Opsional tapi Disarankan)**
> - Karena kita menggunakan OpenStreetMap, siapkan koordinat batas desa (dalam format GeoJSON atau daftar Latitude/Longitude) jika Anda ingin menampilkan garis batas wilayah desa di peta.

---

## 🛠️ TUGAS SAYA (AI): Yang Akan Saya Kerjakan

Setelah Anda menyetujui rencana ini, saya akan mulai menulis kode untuk melengkapi aplikasi. Berikut adalah tahapannya:

### 1. Konfigurasi Awal & Dependensi
- Menambahkan library `cloud_firestore` dan `firebase_storage` ke `pubspec.yaml`.
- Memperbarui `main.dart` agar menjalankan `Firebase.initializeApp()` saat aplikasi pertama kali dibuka.

### 2. Pembuatan Model Data (Models)
Saya akan membuat struktur data (Model) untuk Firestore:
- `UserModel`: Menyimpan data pengguna (ID, nama, email, foto, NIK, role: 'warga'/'admin').
- `ReportModel` (Laporan): Menyimpan data keluhan/laporan warga (ID, judul, deskripsi, foto keluhan, titik koordinat peta, status: *pending/diproses/selesai*, timestamp).
- `PembangunanModel`: Menyimpan data proyek desa (nama proyek, anggaran, progres %, lokasi, foto).
- `PengumumanModel`: Menyimpan data berita/pengumuman dari desa (judul, isi, tanggal, pembuat).

### 3. Pembuatan Layanan Database (Services & Controllers)
- **`AuthController`**: Mengatur proses registrasi, login, logout, dan menyimpan sesi user.
- **`DashboardController`**: Menarik data ringkasan laporan, pengumuman terbaru, dan data profil secara *real-time* dari Firestore (menggantikan data *dummy* saat ini).
- **`CreateReportController`**: Menulis logika untuk mengambil foto dari kamera/galeri, mendapatkan lokasi GPS (*Geolocator*), mengunggah gambar ke Firebase Storage, dan menyimpan data laporan ke Firestore.
- **`PetaController`**: Menampilkan peta menggunakan **OpenStreetMap (`flutter_map`)** yang berisi *marker* (penanda) titik-titik lokasi pelaporan warga, lokasi proyek pembangunan desa, dan (opsional) polygon batas desa.

*Catatan Tambahan*: Karena untuk role Admin akan dibuat terpisah menggunakan *web service*, maka aplikasi mobile ini akan difokuskan secara penuh untuk *User (Warga)*.

## Persiapan Eksekusi

Saya akan mulai mengerjakan:
1. Pembuatan file **Model Data** (`UserModel`, `ReportModel`, `PembangunanModel`, `PengumumanModel`).
2. Implementasi antarmuka peta menggunakan **`flutter_map`**.
3. Penyiapan struktur integrasi Firebase.

*(Catatan: Pastikan Anda sudah membuat project Firebase dan memasukkan `google-services.json` ke dalam project ini agar aplikasi tidak error saat di-build).*
