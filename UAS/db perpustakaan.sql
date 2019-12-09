CREATE DATABASE perpustakaan;
GO
USE perpustakaan;

CREATE TABLE buku (
	kode smallint,
	judul varchar(50),
	jumlah_hal smallint,
	pengarang varchar(30),
	penerbit varchar(30),
	tahun_terbit smallint,
	
	CONSTRAINT buku_pk PRIMARY KEY  (kode)
);

CREATE TABLE anggota (
	nomor smallint,
	nama varchar(25),
	alamat varchar(35),
	tgl_lahir date,
	tempat_lahir varchar(25),
	nomor_telp varchar(15),

	CONSTRAINT anggota_pk PRIMARY KEY  (nomor)
);

CREATE TABLE petugas (
	id smallint,
	nomor_ktp varchar(15),
	nama varchar(25),
	alamat varchar(35),
	nomor_telp varchar(15),

	CONSTRAINT petugas_pk PRIMARY KEY  (id)
);

CREATE TABLE peminjaman(
	kode smallint,
	tgl_pinjam date,
	tgl_harus_kembali date,
	tgl_kembali date,
	no_anggota smallint,
	id_petugas smallint,

	CONSTRAINT peminjaman_pk PRIMARY KEY  (kode),
	CONSTRAINT peminjaman_fk1 FOREIGN KEY  (no_anggota) REFERENCES anggota(nomor),
	CONSTRAINT peminjaman_fk2 FOREIGN KEY  (id_petugas) REFERENCES petugas(id)
);

CREATE TABLE detail_peminjaman(
	kode_pinjam smallint,
	kode_buku smallint,

	CONSTRAINT detail_peminjaman_pk PRIMARY KEY  (kode_pinjam,kode_buku),
	CONSTRAINT detail_peminjaman_fk1 FOREIGN KEY  (kode_pinjam) REFERENCES peminjaman(kode),
	CONSTRAINT detail_peminjaman_fk2 FOREIGN KEY  (kode_buku) REFERENCES buku(kode)
);

INSERT INTO buku VALUES (1, 'Dasar pemrograman', 150, 'Didi Riyadi', 'Polinema Pers', 2014);
INSERT INTO buku VALUES (2, 'Basis data', 100, 'Mila Karmila', 'Polinema Pers', 2014);
INSERT INTO buku VALUES (3, 'Rekayasa perangkat lunak', 130, 'Dana Diana', 'Polinema Pers', 2015);
INSERT INTO buku VALUES (4, 'Ilmu komunikasi dan organisasi', 120, 'Rini Triani', 'Polinema Pers', 2016);
INSERT INTO buku VALUES (5, 'Interaksi manusia dan komputer', 160, 'Dedi Permana', 'Polinema Pers', 2016);
INSERT INTO buku VALUES (6, 'Jaringan komputer', 100, 'Tora Suwarno', 'Polinema Pers', 2017);
INSERT INTO buku VALUES (7, 'Pengantar teknologi informasi', 150, 'Purnama Sari ', 'Polinema Pers', 2017);
INSERT INTO buku VALUES (8, 'Kecerdasan buatan', 100, 'Sarah Dewi', 'Polinema Pers', 2017);
INSERT INTO buku VALUES (9, 'Pengolahan citra digital', 100, 'Suwarno', 'Polinema Pers', 2018);
INSERT INTO buku VALUES (10, 'Sistem operasi', 120, 'Bisma Lingga', 'Polinema Pers', 2018);
GO

INSERT INTO anggota VALUES (1, 'Salsabila', 'Jl. Jeruk No 13 Malang', '07/05/2000', 'Malang','081333444555');
INSERT INTO anggota VALUES (2, 'Firmansyah', 'Jl. Mangga No 103 Malang', '06/10/2001', 'Malang','081323664511');
INSERT INTO anggota VALUES (3, 'Maya Hirata', 'Jl. Srikaya No 56 Malang', '09/25/2000', 'Malang','081993334225');
INSERT INTO anggota VALUES (4, 'Gita Yasa', 'Jl. Semangka No 7 Malang', '01/09/2005', 'Malang','08188344599');
INSERT INTO anggota VALUES (5, 'Siska Silvia', 'Jl. Jambu No 36 Malang', '10/12/2003', 'Malang','081322344222');
INSERT INTO anggota VALUES (6, 'Deffa Trianta', 'Jl. Durian No 45 Malang', '07/08/2000', 'Malang','081355544577');
INSERT INTO anggota VALUES (7, 'Bimbi Bahtiar', 'Jl. Kelengkeng No 99 Malang', '10/15/2003', 'Malang','081322346622');
INSERT INTO anggota VALUES (8, 'Tata Tiara', 'Jl. Salak No 84 Malang', '07/25/2000', 'Malang','081355589007');
GO

INSERT INTO petugas VALUES (1, '199904021234123', 'Ali Adi', 'Jl. Mawar 37 Malang', '0812355667723');
INSERT INTO petugas VALUES (2, '199807236778993', 'Soraya ', 'Jl. Raflesia 83 Malang', '0812323298999');
INSERT INTO petugas VALUES (3, '199808121234524', 'Mira Diana', 'Jl. Kasturi 29 Malang', '0814532232323');
INSERT INTO petugas VALUES (4, '198711091234155', 'Herawati', 'Jl. Tabebuya 23 Malang', '0812327776523');
INSERT INTO petugas VALUES (5, '199510259765865', 'Maman tria', 'Jl. Sakura 29 Malang', '0812323656546');
INSERT INTO petugas VALUES (6, '199808121231234', 'Siswoko', 'Jl. Sedap malam 13 Malang', '0819875345678');
INSERT INTO petugas VALUES (7, '199702231245657', 'Sendy lesmaana', 'Jl. Anggrek 28 Malang', '0819878976587');
INSERT INTO petugas VALUES (8, '199603094671234', 'Mahendra', 'Jl. Melati 03 Malang', '0812876689887');
GO

INSERT INTO peminjaman VALUES (1,'09/23/2019','09/26/2019','09/26/2019', 1, 2);
INSERT INTO peminjaman VALUES (2,'09/23/2019','09/25/2019','09/25/2019', 5, 2);
INSERT INTO peminjaman VALUES (3,'09/24/2019','09/25/2019','09/26/2019', 6, 3);
INSERT INTO peminjaman VALUES (4,'09/24/2019','09/26/2019','09/26/2019', 4, 3);
INSERT INTO peminjaman VALUES (5,'09/24/2019','09/25/2019','09/26/2019', 3, 3);
GO

INSERT INTO detail_peminjaman VALUES (1,2);
INSERT INTO detail_peminjaman VALUES (1,3);
INSERT INTO detail_peminjaman VALUES (1,1);
INSERT INTO detail_peminjaman VALUES (2,4);
INSERT INTO detail_peminjaman VALUES (2,5);
INSERT INTO detail_peminjaman VALUES (3,10);
INSERT INTO detail_peminjaman VALUES (4,8);
INSERT INTO detail_peminjaman VALUES (4,7);
INSERT INTO detail_peminjaman VALUES (5,9);
GO

