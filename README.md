# 📱 Gestión de Inventario

Aplicación Flutter para gestión de inventarios con sistema de login.

## 🚀 Características

- ✅ Sistema de autenticación
- ✅ CRUD de Productos
- ✅ CRUD de Categorías  
- ✅ Control de Movimientos (entrada/salida)
- ✅ Reportes y Estadísticas
- ✅ Interfaz Material Design 3
- ✅ Compatible Android/iOS/Web

## 🔐 Login

**Email:** `admin@gmail.com`  
**Contraseña:** `123456`

## 📱 Instalación

### Para desarrollo:
```bash
flutter run
```

### Para producción (APK):
```bash
flutter build apk --release
```
El APK se genera en: `build/app/outputs/flutter-apk/app-release.apk`

## 🛠️ Tecnologías

- **Flutter** - Framework
- **Material Design 3** - UI
- **Dart** - Lenguaje
- **SQLite** - Base de datos (simulada en memoria)

---
*Aplicación desarrollada para gestión de inventarios*
- ✅ Actualización en tiempo real

#### 🗄️ Base de Datos Robusta
- ✅ SQLite local (sin dependencia de servidor)
- ✅ Esquema relacional optimizado
- ✅ Índices para mejor rendimiento
- ✅ Validación de datos

#### 🎨 Interfaz Moderna
- ✅ Material Design 3
- ✅ Temas consistentes
- ✅ Navegación intuitiva
- ✅ Indicadores visuales
- ✅ Diálogos y alertas

---

## 📊 Diagrama de Base de Datos

```
┌─────────────────────────────────────────────────────────────┐
│                         CATEGORIAS                          │
├─────────────────────────────────────────────────────────────┤
│ • id (PK)                                                   │
│ • nombre (UNIQUE)                                           │
│ • descripcion                                               │
│ • fecha_creacion                                            │
└─────────────────────────────────────────────────────────────┘
                              ▲
                              │ 1:N
                              │
┌─────────────────────────────────────────────────────────────┐
│                        PRODUCTOS                            │
├─────────────────────────────────────────────────────────────┤
│ • id (PK)                                                   │
│ • nombre                                                    │
│ • descripcion                                               │
│ • precio                                                    │
│ • cantidad                                                  │
│ • categoria (FK)                                            │
│ • fecha_creacion                                            │
│ • fecha_actualizacion                                       │
└─────────────────────────────────────────────────────────────┘
                              ▲
                              │ 1:N
                              │
┌─────────────────────────────────────────────────────────────┐
│                       MOVIMIENTOS                           │
├─────────────────────────────────────────────────────────────┤
│ • id (PK)                                                   │
│ • producto_id (FK)                                          │
│ • tipo (entrada/salida)                                     │
│ • cantidad                                                  │
│ • motivo                                                    │
│ • fecha                                                     │
└─────────────────────────────────────────────────────────────┘
```

---

## 🛠️ Instalación Rápida

### Requisitos
- Flutter SDK >= 3.9.2
- Dart SDK
- Git

### Pasos

```bash
# 1. Clonar el repositorio
git clone [<repository-url>](https://github.com/Sgiane11a/Multiplataforma_Final.git)
cd flutter_application_1

# 2. Instalar dependencias
flutter pub get

# 3. Ejecutar en dispositivo/emulador
flutter run
```

### Para plataforma específica

```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# Web
flutter run -d chrome

# Windows/macOS/Linux
flutter run
```

---

## 📦 Dependencias

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0          # SQLite
  path_provider: ^2.1.1    # Acceso a directorios
  intl: ^0.19.0            # Formatos
  cupertino_icons: ^1.0.8  # Iconos
```

---

## 📱 Compatibilidad Multiplataforma

| Plataforma | Estado | Notas |
|-----------|--------|-------|
| 🤖 Android | ✅ Completo | SQLite nativo |
| 🍎 iOS | ✅ Completo | SQLite nativo |
| 🌐 Web | ✅ Completo | IndexedDB |
| 🪟 Windows | ✅ Completo | SQLite nativo |
| 🍎 macOS | ✅ Completo | SQLite nativo |
| 🐧 Linux | ✅ Completo | SQLite nativo |

---

## 🔧 Estructura del Proyecto

```
lib/
├── main.dart                    # Punto de entrada
├── database/
│   └── database_helper.dart     # Lógica de BD
├── models/
│   ├── producto.dart
│   ├── categoria.dart
│   └── movimiento.dart
├── screens/
│   ├── home_screen.dart
│   ├── productos_screen.dart
│   ├── categorias_screen.dart
│   ├── movimientos_screen.dart
│   ├── reportes_screen.dart
│   ├── producto_dialog.dart
│   └── movimiento_dialog.dart
│
├── DOCUMENTACION.md
├── GUIA_INSTALACION.md
├── API_DOCUMENTATION.md
├── EJEMPLOS_AVANZADOS.md
├── inventario_erd.vuerd
└── pubspec.yaml
```

---

## 🐛 Problemas Comunes y Soluciones

### Error: "Could not resolve all dependencies"
```bash
flutter clean
flutter pub get
```

### Base de datos corrupta
La app recreará automáticamente la BD en la siguiente ejecución.

### Problemas de compilación iOS
```bash
cd ios
pod install
cd ..
flutter run
```
---

<div align="center">

**Hecho con ❤️ de Gianella - usando Flutter y Dart**

[⬆ Volver al inicio](#-gestión-de-inventario---aplicación-flutter-completa)

</div>
