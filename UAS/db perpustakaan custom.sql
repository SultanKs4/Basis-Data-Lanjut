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

INSERT INTO buku (kode,judul,jumlah_hal,pengarang,penerbit,tahun_terbit) VALUES 
(1,'Dasar pemrograman',150,'Didi Riyadi','Polinema Pers',2014)
,(2,'Basis data',100,'Mila Karmila','Polinema Pers',2014)
,(3,'Rekayasa perangkat lunak',130,'Dana Diana','Polinema Pers',2015)
,(4,'Ilmu komunikasi dan organisasi',120,'Rini Triani','Polinema Pers',2016)
,(5,'Interaksi manusia dan komputer',160,'Dedi Permana','Polinema Pers',2016)
,(6,'Jaringan komputer',100,'Tora Suwarno','Polinema Pers',2017)
,(7,'Pengantar teknologi informasi',150,'Purnama Sari ','Polinema Pers',2017)
,(8,'Kecerdasan buatan',100,'Sarah Dewi','Polinema Pers',2017)
,(9,'Pengolahan citra digital',100,'Suwarno','Polinema Pers',2018)
,(10,'Sistem operasi',120,'Bisma Lingga','Polinema Pers',2018)
,(11,'Android Java',380,'One','Elex Media',2016)
,(12,'Android Kotlin',500,'Eiichiro Oda','Elex Media',2013)
,(13,'Framework Laravel',200,'Masashi Kisimoto','Elex Media',2015)
,(14,'Berkenalan dengan React',300,'Natlus','Elex Media',2018)
,(15,'Machine Learning for Babies',400,'Cahya Ramdani','Elex Media',2016)
,(16,'Deep Learning for Babies',150,'Sugito','Elex Media',2014)
,(17,'TensorFlow Lite in Android or Mini PC',175,'Radit','Elex Media',2019)
,(18,'Pengenalan REST API',225,'Petrus','Elex Media',2018)
,(19,'RDBMS vs NoSQL',278,'Rika Turika','Elex Media',2015)
,(20,'GraphQL Expert',321,'Kimimoto Toriko','Elex Media',2017)
;
GO

INSERT INTO anggota (nomor,nama,alamat,tgl_lahir,tempat_lahir,nomor_telp) VALUES 
(1,'Salsabila','Jl. Jeruk No 13 Malang','2000-07-05','Malang','081333444555')
,(2,'Firmansyah','Jl. Mangga No 103 Malang','2001-06-10','Malang','081323664511')
,(3,'Maya Hirata','Jl. Srikaya No 56 Malang','2000-09-25','Malang','081993334225')
,(4,'Gita Yasa','Jl. Semangka No 7 Malang','2005-01-09','Malang','08188344599')
,(5,'Siska Silvia','Jl. Jambu No 36 Malang','2003-10-12','Malang','081322344222')
,(6,'Deffa Trianta','Jl. Durian No 45 Malang','2000-07-08','Malang','081355544577')
,(7,'Bimbi Bahtiar','Jl. Kelengkeng No 99 Malang','2003-10-15','Malang','081322346622')
,(8,'Tata Tiara','Jl. Salak No 84 Malang','2000-07-25','Malang','081355589007')
,(9,'Yusril','Jl. Pisang Kipas No 3 Malang','2000-01-16','Gresik','081222222001')
,(10,'Rizal','Jl. Hanoman 59 Jombang','1999-11-10','Jombang','089665412734')
,(11,'Arifin','Jl. Semanggi Barat no 2 Malang','2000-03-30','Pasuruan','088213141243')
,(12,'Fajar','Jl. Ahmad Yani no 20 Malang','1999-05-16','Sidoarjo','085623131412')
,(13,'Zaafril','Jl. Kauman no 69 Malang','2000-08-20','Malang','085123412315')
,(14,'Reza','Jl. Cemara no 46 Pasuruan','2000-05-25','Pasuruan','081235824412')
,(15,'Yayak','Jl. Campur Darat no 93 Tulungagung','1999-09-10','Tulungagung','083123141223')
,(16,'Bayu','Jl. Coklat no 30 Malang','1999-11-23','Jombang','081234123341')
,(17,'Nurus','Jl. Ikan Tombro no 40 Malang','1999-04-23','Malang','082213424123')
,(18,'Orochimaru','Jl. Python no 8 Surabaya','1999-02-20','Surabaya','081312341233')
;
GO

INSERT INTO petugas (id,nomor_ktp,nama,alamat,nomor_telp) VALUES 
(1,'199904021234123','Ali Adi','Jl. Mawar 37 Malang','0812355667723')
,(2,'199807236778993','Soraya ','Jl. Raflesia 83 Malang','0812323298999')
,(3,'199808121234524','Mira Diana','Jl. Kasturi 29 Malang','0814532232323')
,(4,'198711091234155','Herawati','Jl. Tabebuya 23 Malang','0812327776523')
,(5,'199510259765865','Maman tria','Jl. Sakura 29 Malang','0812323656546')
,(6,'199808121231234','Siswoko','Jl. Sedap malam 13 Malang','0819875345678')
,(7,'199702231245657','Sendy lesmaana','Jl. Anggrek 28 Malang','0819878976587')
,(8,'199603094671234','Mahendra','Jl. Melati 03 Malang','0812876689887')
,(9,'194928491894123','Sujito','Jl. Raflesia 31 Malang','0831244331234')
,(10,'199231293141412','Suhendra','Jl. Raflesia 89 Malang','0831244312312')
,(11,'194914921391231','Mahendra','Jl. Raflesia 51 Malang','0831243412352')
,(12,'193491843928551','Alan','Jl. Raflesia 91 Malang','0831288392839')
,(13,'192841923812352','Edi','Jl. Raflesia 21 Malang','0831294129315')
,(14,'193981238931234','Suwito','Jl. Raflesia III 361 Malang','0831231824812')
,(15,'193918923891382','Azmi','Jl. Raflesia III 313 Malang','0831238123814')
,(16,'199698391837421','Angga','Jl. Raflesia II 291 Malang','0831244712314')
,(17,'199603312313412','Rifal','Jl. Raflesia II 231 Malang','0831841317581')
,(18,'199603093713712','Dika','Jl. Raflesia 11 Malang','0831244124451')
;
GO

INSERT INTO peminjaman (kode,tgl_pinjam,tgl_harus_kembali,tgl_kembali,no_anggota,id_petugas) VALUES 
(1,'2019-09-23','2019-09-26','2019-09-26',1,2)
,(2,'2019-09-23','2019-09-25','2019-09-25',5,2)
,(3,'2019-09-24','2019-09-25','2019-09-26',6,3)
,(4,'2019-09-24','2019-09-26','2019-09-26',4,3)
,(5,'2019-09-24','2019-09-25','2019-09-26',3,3)
,(6,'2019-09-25','2019-09-27','2019-09-27',16,15)
,(7,'2019-09-25','2019-09-27','2019-09-28',14,8)
,(8,'2019-09-25','2019-09-26','2019-09-27',10,9)
,(9,'2019-09-25','2019-09-28','2019-09-28',5,11)
,(10,'2019-09-26','2019-09-27','2019-09-27',16,8)
,(11,'2019-09-26','2019-09-27','2019-09-28',17,16)
,(12,'2019-09-26','2019-09-27','2019-09-27',13,18)
,(13,'2019-09-26','2019-09-28','2019-09-28',18,15)
,(14,'2019-09-27','2019-09-28','2019-09-29',12,13)
,(15,'2019-09-27','2019-09-28','2019-09-28',14,12)
;
GO

INSERT INTO detail_peminjaman (kode_pinjam,kode_buku) VALUES 
(1,1)
,(1,2)
,(1,3)
,(2,4)
,(2,5)
,(3,10)
,(4,7)
,(4,8)
,(5,9)
,(6,12)
,(7,18)
,(8,11)
,(9,14)
,(10,10)
,(11,15)
,(12,12)
,(13,16)
,(14,19)
,(15,20)
;
GO

