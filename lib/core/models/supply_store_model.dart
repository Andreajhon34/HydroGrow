/// Model for nearby urban farming and hydroponics supply stores.
class SupplyStore {
  const SupplyStore({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.district,
    required this.distanceKm,
    required this.rating,
    required this.reviewCount,
    required this.openHours,
    required this.phoneNumber,
    required this.stockTags,
    required this.mapXPercent,
    required this.mapYPercent,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String category;
  final String address;
  final String district;
  final double distanceKm;
  final double rating;
  final int reviewCount;
  final String openHours;
  final String phoneNumber;
  final List<String> stockTags;
  final double mapXPercent; // 0.0 - 1.0 on local map
  final double mapYPercent; // 0.0 - 1.0 on local map
  final String imageUrl;

  String get formattedDistance => '${distanceKm.toStringAsFixed(1)} km';
}

abstract final class SampleSupplyStores {
  static const List<SupplyStore> stores = [
    SupplyStore(
      id: 'store_1',
      name: 'Hidroponik Kota Hijau',
      category: 'Toko Nutrisi & Media Tanam',
      address: 'Jl. Melati Raya No. 14, Kebayoran',
      district: 'Jakarta Selatan',
      distanceKm: 0.8,
      rating: 4.9,
      reviewCount: 184,
      openHours: '08:00 - 17:30 • Buka',
      phoneNumber: '+62 812-3456-7890',
      stockTags: [
        'AB Mix Sayur Daun 5L',
        'Rockwool Cultilene',
        'Netpot 5cm + Flanel',
        'Benih Pakcoy F1',
        'TDS Meter HM Digital',
      ],
      mapXPercent: 0.35,
      mapYPercent: 0.42,
      imageUrl:
          'https://images.unsplash.com/photo-1585320806297-9794b3e4eeae?auto=format&fit=crop&w=600&q=80',
    ),
    SupplyStore(
      id: 'store_2',
      name: 'Green Corner Urban Farm Supplies',
      category: 'Peralatan & Modul DIY',
      address: 'Komp. Ruko Niaga Blok C2, Sukajadi',
      district: 'Pusat Kota',
      distanceKm: 1.4,
      rating: 4.8,
      reviewCount: 142,
      openHours: '08:30 - 18:00 • Buka',
      phoneNumber: '+62 813-9876-5432',
      stockTags: [
        'Starter Kit Box Styrofoam',
        'Pompa Celup Aquarium 15W',
        'Pipa PVC Lubang Tanam',
        'Benih Selada & Kemangi',
        'pH Down Organik',
      ],
      mapXPercent: 0.65,
      mapYPercent: 0.28,
      imageUrl:
          'https://images.unsplash.com/photo-1530836369250-ef72a3f5cda8?auto=format&fit=crop&w=600&q=80',
    ),
    SupplyStore(
      id: 'store_3',
      name: 'Mitra Tani Perkotaan Makmur',
      category: 'Bibit Unggul & Pupuk',
      address: 'Jl. Anggrek No. 88, Menteng',
      district: 'Jakarta Pusat',
      distanceKm: 2.1,
      rating: 4.7,
      reviewCount: 96,
      openHours: '07:30 - 17:00 • Buka',
      phoneNumber: '+62 811-2233-4455',
      stockTags: [
        'Benih Panah Merah',
        'Pestisida Nabati Neem Oil',
        'Baki Semai 200 Lubang',
        'Nutrisi AB Mix Buah (Tomat)',
        'Hidroton Jerman',
      ],
      mapXPercent: 0.52,
      mapYPercent: 0.68,
      imageUrl:
          'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?auto=format&fit=crop&w=600&q=80',
    ),
    SupplyStore(
      id: 'store_4',
      name: 'Kratky & Hydro Store',
      category: 'Wadah & Botol Bekas Daur Ulang',
      address: 'Jl. Veteran No. 5B, Pasar Minggu',
      district: 'Jakarta Selatan',
      distanceKm: 3.2,
      rating: 4.8,
      reviewCount: 68,
      openHours: '09:00 - 19:00 • Buka',
      phoneNumber: '+62 819-0011-2233',
      stockTags: [
        'Botol Bekas Siap Pakai 1.5L',
        'Kain Flanel Meteran',
        'Gergaji Rockwool',
        'Spuit / Suntikan Takar Nutrisi',
      ],
      mapXPercent: 0.22,
      mapYPercent: 0.75,
      imageUrl:
          'https://images.unsplash.com/photo-1546793665-c74683f339c1?auto=format&fit=crop&w=600&q=80',
    ),
  ];
}
