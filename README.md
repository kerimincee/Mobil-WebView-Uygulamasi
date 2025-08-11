# 🚀 Patron Ekran - Flutter WebView Uygulaması

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.8.1+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-blue?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

*Modern ve kullanıcı dostu WebView tabanlı Flutter uygulaması*

</div>

---

## 📋 İçindekiler

- [Özellikler](#-özellikler)
- [Ekran Görüntüleri](#-ekran-görüntüleri)
- [Kurulum](#-kurulum)
- [Kullanım](#-kullanım)
- [Teknik Detaylar](#-teknik-detaylar)
- [Katkıda Bulunma](#-katkıda-bulunma)
- [Lisans](#-lisans)

---

## ✨ Özellikler

### 🔧 Temel Özellikler
- **🌐 WebView Entegrasyonu**: Herhangi bir web sitesini uygulama içinde görüntüleme
- **💾 URL Kaydetme**: Girilen URL'leri yerel olarak saklama ve otomatik bağlanma
- **🎨 Modern UI**: Material Design 3 ile modern ve kullanıcı dostu arayüz
- **📱 Çoklu Platform**: Android, iOS, Web ve Desktop desteği

### 🚀 Gelişmiş Özellikler
- **🔗 URL Doğrulama**: Geçerli HTTP/HTTPS URL kontrolü
- **⚡ Hızlı Başlangıç**: Kayıtlı URL ile anında bağlantı
- **🔄 Demo Sistemi**: Kolay demo başvuru formu
- **🚪 Güvenli Çıkış**: Tek tıkla güvenli çıkış yapma
- **📊 Yükleme Göstergesi**: Sayfa yüklenirken görsel geri bildirim

---

## 📱 Ekran Görüntüleri

<div align="center">

| Ana Sayfa | WebView | Demo Form |
|-----------|---------|-----------|
| ![Ana Sayfa](https://via.placeholder.com/300x600/4A90E2/FFFFFF?text=Ana+Sayfa) | ![WebView](https://via.placeholder.com/300x600/50C878/FFFFFF?text=WebView) | ![Demo Form](https://via.placeholder.com/300x600/FF6B6B/FFFFFF?text=Demo+Form) |

</div>

---

## 🛠️ Kurulum

### Gereksinimler
- Flutter SDK 3.8.1 veya üzeri
- Dart 3.0 veya üzeri
- Android Studio / VS Code
- Git

### Adım Adım Kurulum

1. **Projeyi Klonlayın**
   ```bash
   git clone https://github.com/kerimincee/Mobil-WebView-Uygulamasi
   cd patron_ekran
   ```

2. **Bağımlılıkları Yükleyin**
   ```bash
   flutter pub get
   ```

3. **Uygulamayı Çalıştırın**
   ```bash
   # Android için
   flutter run
   
   # iOS için
   flutter run -d ios
   
   # Web için
   flutter run -d chrome
   ```

---

## 📖 Kullanım

### 🎯 İlk Kullanım
1. Uygulamayı açın
2. Bağlanmak istediğiniz URL'yi girin (örn: `http://111.111.111.111:1111`)
3. "Bağlan" butonuna tıklayın
4. Web sitesi uygulama içinde açılacaktır

### 🔄 Kayıtlı URL ile Kullanım
- Daha önce girilen URL otomatik olarak kaydedilir
- Uygulama tekrar açıldığında otomatik olarak bağlanır

### 🆓 Demo Sürümü
1. Ana sayfada "Demo Sürümünü Al" butonuna tıklayın
2. Demo başvuru formunu doldurun
3. Form gönderildikten sonra demo URL'sine otomatik bağlanır

### 🚪 Çıkış Yapma
- WebView sayfasında sağ üst köşedeki çıkış ikonuna tıklayın
- Kayıtlı URL silinir ve ana sayfaya dönersiniz

---

## 🔧 Teknik Detaylar

### 📦 Kullanılan Paketler
```yaml
dependencies:
  flutter:
    sdk: flutter
  webview_flutter: ^4.4.1    # WebView işlevselliği
  shared_preferences: ^2.1.1 # Yerel veri saklama
  http: ^1.4.0              # HTTP istekleri
```

### 🏗️ Proje Yapısı
```
lib/
├── main.dart              # Ana uygulama dosyası
├── splash_decider.dart    # Başlangıç kontrolü
├── url_input_page.dart    # URL giriş sayfası
├── webview_app.dart       # WebView uygulaması
└── demo_form.dart         # Demo başvuru formu
```

### 🔄 Ana Bileşenler

#### SplashDecider
- Uygulama başlangıcında kayıtlı URL kontrolü
- Otomatik yönlendirme mantığı

#### UrlInputPage
- Modern ve kullanıcı dostu URL giriş arayüzü
- URL doğrulama sistemi
- Demo başvuru entegrasyonu

#### WebViewApp
- Tam özellikli WebView implementasyonu
- JavaScript desteği
- Yükleme göstergesi
- Güvenli çıkış fonksiyonu

---

## 🤝 Katkıda Bulunma

Bu projeye katkıda bulunmak istiyorsanız:

1. Projeyi fork edin
2. Yeni bir feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Değişikliklerinizi commit edin (`git commit -m 'Add amazing feature'`)
4. Branch'inizi push edin (`git push origin feature/amazing-feature`)
5. Pull Request oluşturun

### 🐛 Hata Bildirimi
Hata bildirmek için [Issues](https://github.com/kullaniciadi/patron_ekran/issues) sayfasını kullanın.

---

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.

---

## 📞 İletişim

- **Geliştirici**: [Kerim Ince]
- **Email**: [incekerim49@gmail.com]
- **LinkedIn**: [https://www.linkedin.com/in/kerim-ince/]
- **GitHub**: [https://github.com/kerimincee]

---

<div align="center">

**⭐ Bu projeyi beğendiyseniz yıldız vermeyi unutmayın!**

</div>
