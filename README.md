# Proyek-Akhir-PSD-Kelompok-B6

Smart Air Sterilizer and Purifier

Proyek VHDL dalam bentuk air purifier sekaligus sterilizer yang bekerjanya bergantung pada jumlah minimal orang yang berada di dalam ruangan, dengan penerapan Finite State Machine.

Pengimplementasian rangkaian sekuensial ini terbagi menjadi 3 rangkaian utama, yaitu : rangkaian yang berfungsi sebagai timer dalam mesin (timer), lalu terdapat rangkaian yang berfungsi untuk menyimpan state-state yang akan menentukan arah dan mode kerja mesin (machine), dan rangkaian utama untuk eksekusi dalam menyemprotkan cairan pada system air sterilizer maupun fitur  air purifier (top level). Ketiga rangkaian tersebut merupakan rangkaian yang saling bergantung antara satu sama lain, dengan syarat jika terdapat minimal 3 orang yang terdeteksi berada di dalam suatu ruangan yang telah terpasang alat ini, maka sistem timer akan dinyalakan (signal bernilai 1) secara otomatis untuk memulai penyemprotan setiap 15 detik.

Setelah POWER aktif, maka purifier dan sterilizer akan mulai bekerja secara bergantian, purifier akan menyemprotkan cairan pensteril dan sterilizer akan menyaring udara. Setiap kali cairan steril disemprotkan, jumlah cairan tersebut akan berkurang sampai habis. Di saat mesin mendeteksi bahwa cairan sudah habis, maka cairan tersebut akan direfill sampai penuh agar dapat menyemprotkan cairan pensteril kembali. Sementara air purifier akan menyaring udara dengan 3 buah mode yang berbeda yang dapat dipilih oleh user, yakni  NORMAL (default), BOOST, dan POWERSAVE.

Selain 3 rangkaian utama, terdapat pula file testbench yang berfungsi untuk memberikan input kepada entity lain dan menguji output yang dikeluarkan oleh entity tersebut.
