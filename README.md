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

## 🖥️ Capturas de Pantalla Conceptuales

### Pantalla de Productos
- Lista con chips de precio y stock
- Indicadores de bajo stock
- Filtrado por categoría
- Opciones de editar/eliminar

### Pantalla de Categorías
- Listado de categorías
- Gestión completa
- Interfaz limpia

### Pantalla de Movimientos
- Historial completo
- Diferenciación entrada/salida
- Información detallada

### Pantalla de Reportes
- Tarjetas estadísticas
- Valores totales
- Interfaz visual atractiva

---

## 🛠️ Instalación Rápida

### Requisitos
- Flutter SDK >= 3.9.2
- Dart SDK
- Git

### Pasos

```bash
# 1. Clonar el repositorio (si es desde Git)
git clone <repository-url>
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

## 📚 Documentación Completa

Este proyecto incluye documentación exhaustiva:

| Documento | Descripción |
|-----------|------------|
| **[GUIA_INSTALACION.md](./GUIA_INSTALACION.md)** | Guía completa de instalación para todas las plataformas |
| **[DOCUMENTACION.md](./DOCUMENTACION.md)** | Documentación detallada del proyecto |
| **[API_DOCUMENTATION.md](./API_DOCUMENTATION.md)** | Referencia completa de la API DatabaseHelper |
| **[EJEMPLOS_AVANZADOS.md](./EJEMPLOS_AVANZADOS.md)** | Ejemplos de código avanzado |
| **[inventario_erd.vuerd](./inventario_erd.vuerd)** | Diagrama ER (abrir con ERD Editor) |

---

## 🎯 Uso Básico

### 1. Crear una Categoría
```dart
final categoria = Categoria(
  nombre: 'Electrónica',
  descripcion: 'Productos electrónicos',
  fechaCreacion: DateTime.now(),
);
await DatabaseHelper().crearCategoria(categoria);
```

### 2. Crear un Producto
```dart
final producto = Producto(
  nombre: 'Laptop',
  descripcion: 'Laptop HP 15',
  precio: 799.99,
  cantidad: 10,
  categoria: 'Electrónica',
  fechaCreacion: DateTime.now(),
);
await DatabaseHelper().crearProducto(producto);
```

### 3. Registrar Movimiento
```dart
final movimiento = Movimiento(
  productoId: 1,
  tipo: 'entrada',
  cantidad: 5,
  motivo: 'Reabastecimiento',
  fecha: DateTime.now(),
);
await DatabaseHelper().crearMovimiento(movimiento);
```

### 4. Obtener Estadísticas
```dart
final stats = await DatabaseHelper().obtenerEstadisticas();
print('Valor inventario: \$${stats['valorInventario']}');
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

## 🚀 Funcionalidades Avanzadas

- 🔄 Hot Reload (desarrollo rápido)
- 💾 Persistencia offline
- 🎨 Temas Material Design 3
- 📊 Estadísticas en tiempo real
- 🔍 Búsqueda y filtrado
- ⚠️ Alertas de bajo stock
- 📱 Interfaz responsive
- ♿ Accesibilidad

---

## 🤝 Contribución

Las contribuciones son bienvenidas. Por favor:

1. Haz fork del proyecto
2. Crea una rama para tu feature
3. Commit tus cambios
4. Push a la rama
5. Abre un Pull Request

---

## 📝 Licencia

Este proyecto es de código abierto y está disponible bajo licencia MIT para uso educativo y comercial.

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

## 📞 Soporte

- 📖 Lee la [documentación completa](./DOCUMENTACION.md)
- 🔍 Consulta los [ejemplos de código](./EJEMPLOS_AVANZADOS.md)
- 📚 Revisa la [referencia de API](./API_DOCUMENTATION.md)
- 🔧 Sigue la [guía de instalación](./GUIA_INSTALACION.md)

---

## 🎓 Recursos Educativos

- [Documentación oficial de Flutter](https://flutter.dev)
- [SQLite con Flutter](https://flutter.dev/docs/development/data-and-backend/sqlite)
- [Material Design 3](https://m3.material.io/)
- [Dart Language](https://dart.dev)

---

## ⭐ Características Futuras Potenciales

- [ ] Sincronización en la nube
- [ ] Autenticación de usuarios
- [ ] Gráficos avanzados
- [ ] Predicción de demanda
- [ ] Integración con APIs externas
- [ ] Notificaciones push
- [ ] Exportación a múltiples formatos
- [ ] Modo offline con sincronización

---

<div align="center">

**Hecho con ❤️ usando Flutter y Dart**

[⬆ Volver al inicio](#-gestión-de-inventario---aplicación-flutter-completa)

</div>
