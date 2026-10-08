# Kamera tamu pernikahan

1. Buat project di supabase.com. Buka SQL Editor, jalankan `setup.sql`.
2. Authentication > Users > Add user: buat 1 akun admin (email + password).
3. Isi `config.js` dengan Project URL dan anon key (Settings > API).
4. Deploy folder ini ke hosting statis (Netlify, Vercel, atau Cloudflare Pages: drag and drop folder).
5. `index.html` = tautan untuk tamu (jadikan QR). `admin.html` = halamanmu.
6. Tes dulu dengan HP sendiri, lalu hapus foto tes lewat Supabase > Table Editor.

Catatan: kamera di browser hanya jalan lewat HTTPS (hosting di atas sudah HTTPS).
