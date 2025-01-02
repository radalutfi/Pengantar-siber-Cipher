def hitung_gaji():
    jam_kerja = float(input("Masukkan jam kerja dalam seminggu: "))
    tarif_per_jam = float(input("Masukkan gaji per jam: "))

    if jam_kerja <= 40:
        gaji = jam_kerja * tarif_per_jam
    else:
        jam_lembur = jam_kerja - 40
        gaji_lembur = jam_lembur * tarif_per_jam * 1.5

        gaji = (40 * tarif_per_jam) + gaji_lembur

    print(f"Gaji karyawan: Rp {gaji:,.2f}")


hitung_gaji()
