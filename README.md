# 🥦 SağlamQal

> Barkod skan edərək qida məlumatlarını öyrən, gündəlik su istehlakını izlə.

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Status](https://img.shields.io/badge/status-beta-green)
![License](https://img.shields.io/badge/license-MIT-orange)
![API](https://img.shields.io/badge/API-Open%20Food%20Facts-brightgreen)

---

## 📌 Layihə haqqında

**SağlamQal** — istifadəçilərə gündəlik istehlak etdikləri qida məhsullarının tərkibini asan öyrənməyə və su balansını qorumağa kömək edən Flutter tətbiqidir.

Məhsulun barkodunu skan etmək kifayətdir — tətbiq kalori, enerji, yağ, zülal və karbohidrat kimi əsas qida göstəricilərini **Open Food Facts** bazasından avtomatik olaraq gətirir. Bundan əlavə, istifadəçi gün ərzində içdiyi suyu qeyd edə və fərdi su tövsiyəsini izləyə bilər.

---

## ✨ Mövcud xüsusiyyətlər

- [x] Ana ekran (Home Screen)
- [x] Barkod skan ekranı (kamera inteqrasiyası)
- [x] Open Food Facts API inteqrasiyası — kalori, enerji, yağ, zülal, karbohidrat
- [x] Su takibi — gündəlik tövsiyə və içilən su miqdarının qeydiyyatı

---

## 🔄 Planlaşdırılır

- [ ] Tarixçə ekranı — skan edilmiş məhsulların siyahısı
- [ ] Gündəlik kalori məqsədi və proqres
- [ ] Profil ekranı — yaş, çəki, boy əsasında fərdi tövsiyələr
- [ ] Offline dəstək — skan tarixçəsinin lokal saxlanması
- [ ] Azərbaycanca / Rusca / İngiliscə dil dəstəyi
- [ ] Widget — ana ekranda su və kalori xülasəsi

---

## 🛠 Tech Stack

| Texnologiya         | İstifadə məqsədi            |
| ------------------- | --------------------------- |
| Flutter             | Cross-platform mobil tətbiq |
| Dart                | Proqramlaşdırma dili        |
| mobile_scanner      | Barkod skan paketi          |
| Open Food Facts API | Qida məlumatları bazası     |
| dio                 | API sorğuları               |

---

## 📸 Skrinşotlar

| Ana ekran  | Barkod skan | Qida məlumatı | Su takibi  |
| ---------- | ----------- | ------------- | ---------- |
| _tezliklə_ | _tezliklə_  | _tezliklə_    | _tezliklə_ |

---

## 🚀 Quraşdırma

```bash
# Layihəni klonla
git clone https://github.com/istifadeciadı/saglam-qal.git

# Qovluğa keç
cd saglam-qal

# Asılılıqları yüklə
flutter pub get

# Tətbiqi işə sal
flutter run
```

---

## 📁 Layihə strukturu

Bu layihə **Clean Architecture** + **Feature-based** struktur üzərində qurulub.

```
lib/
├── core/                        # Ümumi, layihə miqyasında istifadə olunan kod
│   ├── constants/               # Sabit dəyərlər (rənglər, ölçülər, mətnlər)
│   ├── di/                      # Dependency Injection
│   ├── enums/                   # Enum tipləri
│   ├── network/                 # HTTP client, interceptor-lar
│   ├── router/                  # Tətbiq naviqasiyası (route-lar)
│   ├── storage/                 # Lokal saxlama (shared prefs, hive və s.)
│   └── utils/                   # Köməkçi funksiyalar
│
├── features/                    # Hər bir funksionallıq ayrı qovluqda
│   ├── auth/                    # Autentifikasiya
│   │   ├── data/                # API çağırışları, model-lər
│   │   ├── domain/              # Use case-lər, entity-lər
│   │   ├── presentation/        # Ekranlar, widget-lər, state
│   │   └── auth_di.dart         # Auth üçün DI konfiqurasiyası
│   ├── home/                    # Ana ekran
│   ├── scan/                    # Barkod skan + qida məlumatları
│   ├── favorites/               # Sevimlilər
│   ├── profile/                 # İstifadəçi profili
│   └── splash/                  # Açılış ekranı
│
└── shared/
    └── widgets/                 # Bütün feature-larda istifadə olunan widget-lər
        ├── custom_appbar.dart
        ├── custom_card.dart
        ├── custom_elevated_button.dart
        ├── custom_outlined_button.dart
        ├── custom_text_button.dart
        ├── custom_dropdown_field.dart
        └── custom_snackbar.dart
```
    
---

## 🌐 API

Bu tətbiq [Open Food Facts](https://world.openfoodfacts.org/) açıq məlumat bazasından istifadə edir.  
Heç bir API açarı tələb olunmur — tamamilə pulsuzdur.

---

## 🗺 Roadmap

- **v0.1** — Home Screen ✅
- **v0.2** — Barkod skan + Open Food Facts inteqrasiyası ✅
- **v0.3** — Su takibi ✅
- **v0.4** — Tarixçə + Gündəlik kalori izləmə
- **v1.0** — Tam buraxılış

---

## 📄 Lisenziya

Bu layihə [MIT](LICENSE) lisenziyası ilə paylaşılır.

---

> 💡 _Sağlam qalmaq üçün nə yediyini və nə qədər su içdiyini bil._
