RESUMEN EJECUTIVO DEL PROYECTO
Nombre de la aplicación: StarMedica
Plataformas objetivo: Android, iOS, Web, Windows
Framework principal: Flutter con Dart
Backend: Firebase (Authentication + Cloud Firestore)
Gestión de estado: Provider
Arquitectura: Feature-first + Clean Architecture simplificada
Estilo visual: Moderno, profesional, limpio pero no sencillo
Paleta de colores oficial:
Azul Marino (#003366): Elementos primarios, headers, botones principales
Rojo (#D32F2F): Acentos, alertas, acciones críticas
Blanco (#FFFFFF): Fondos principales, limpieza visual
Gris muy claro (#F5F5F5): Superficies secundarias, tarjetas
Logo: https://raw.githubusercontent.com/hrzr0599/imagenes-para-fluter-6-I-11-Feb-26/refs/heads/main/logo.JPG
================================================================================
2. HERRAMIENTAS Y DEPENDENCIAS REQUERIDAS
================================================================================
2.1 HERRAMIENTAS DE DESARROLLO
Flutter SDK versión 3.16 o superior
Dart SDK versión 3.2 o superior
Android Studio o Visual Studio Code con extensiones Flutter/Dart
Firebase CLI instalado y configurado
Git para control de versiones
Cuenta de Google con acceso a Firebase Console
Emuladores/dispositivos físicos para testing multiplataforma
2.2 DEPENDENCIAS PARA PUBSPEC.YAML
dependencies:
flutter:
sdk: flutter
Firebase Core Services
firebase_core: ^2.24.2
firebase_auth: ^4.16.0
cloud_firestore: ^4.14.0
firebase_storage: ^11.6.0
Gestión de Estado
provider: ^6.1.1
Mejoras de UI/UX
google_fonts: ^6.1.0
flutter_svg: ^2.0.9
cached_network_image: ^3.3.0
fluttertoast: ^8.2.4
intl: ^0.19.0
Utilidades
uuid: ^4.3.3
form_field_validator: ^1.1.0
connectivity_plus: ^5.0.2
Navegación (opcional pero recomendado)
go_router: ^13.2.0
dev_dependencies:
flutter_test:
sdk: flutter
flutter_lints: ^3.0.1
build_runner: ^2.4.7
================================================================================
3. GUÍA DE ESTILO Y DISEÑO UI/UX
================================================================================
3.1 PALETA DE COLORES OFICIAL (lib/theme/app_colors.dart)
Color primario: Color(0xFF003366) // Azul Marino
Color de acento: Color(0xFFD32F2F) // Rojo
Fondo principal: Colors.white
Fondo secundario: Color(0xFFF5F5F5) // Gris muy claro
Texto primario: Color(0xFF212121)
Texto secundario: Color(0xFF757575)
Error/Alerta: Color(0xFFD32F2F)
Éxito: Color(0xFF388E3C)
3.2 COMPONENTES DE INTERFAZ ESTANDARIZADOS
AppBar Personalizado:
Fondo azul marino (#003366)
Bordes inferiores redondeados (radius: 20px)
Logo centrado con altura máxima 40px
Sombra suave (elevation: 4)
Texto de bienvenida dinámico según usuario
Banner de Bienvenida:
Gradiente sutil azul marino a azul medio
Texto blanco con sombra para legibilidad
Animación de entrada FadeTransition + SlideTransition
Mensaje personalizado: "Bienvenido, [Nombre]"
Tarjetas de Entidades (EntityCard):
Elevación: 4
Border radius: 12px
Icono representativo (48px) + Nombre de entidad
Efecto hover en web/desktop (cambio de elevación a 8)
Contador opcional de registros
Botones Estándar:
Primarios: Fondo #003366, texto blanco, padding 16x24
Secundarios: Borde #D32F2F, texto rojo, fondo transparente
Terciarios: Solo texto, color primario
Tamaño mínimo: 48px de altura (accesibilidad)
Animación de presión: ScaleTransition
Campos de Formulario:
Border radius: 8px
Borde: 1px sólido gris claro
Foco: Borde azul primario + sombra sutil
Validación en tiempo real con mensajes debajo del campo
Iconos de estado (éxito/error) al final del input
Footer de Derechos de Autor:
Texto centrado: "Hernandez Roman A. 2026 6°I"
Color de texto: gris oscuro (#424242)
Fondo: gris muy claro (#F5F5F5)
Altura fija: 40px
Posición fija en parte inferior de la pantalla
3.3 ESTRATEGIA RESPONSIVE
Dispositivos móviles (<600px de ancho):
Layout vertical de una columna
Navegación inferior (BottomNavigationBar)
Menú hamburguesa para acceso a entidades CRUD
Tarjetas en lista única con scroll vertical
Inputs a ancho completo
Tablets y Web (600px - 1200px):
Grid de 2x2 o 3x2 para botones de entidades
AppBar con navegación lateral colapsable
Tablas con scroll horizontal si es necesario
Formularios en dos columnas cuando sea apropiado
Escritorio (>1200px):
Navigation Rail lateral fijo con iconos y texto
Dashboard con vista previa de datos recientes
Soporte para hover effects y atajos de teclado
Ventanas modales centradas con fondo difuminado
================================================================================
4. ARQUITECTURA DE AUTENTICACIÓN Y SEGURIDAD
================================================================================
4.1 FLUJO DE AUTENTICACIÓN
SplashScreen (2 segundos):
Verifica si existe sesión activa en Firebase Auth
Si hay sesión válida -> Navega a AdminDashboard
Si no hay sesión -> Navega a LoginScreen
LoginScreen:
Banner superior azul con logo y bordes redondeados
Campos: Email, Password (con toggle de visibilidad)
Botones: "Iniciar Sesión", "Registrarse", "¿Olvidaste tu contraseña?"
Validaciones: formato de email, longitud mínima de password
Feedback visual de errores con fluttertoast
Integración con FirebaseAuth.signInWithEmailAndPassword
RegisterScreen:
Campos adicionales: Nombre completo, Teléfono, Rol (dropdown)
Validación de password confirmado
Creación de usuario en Firebase Auth
Almacenamiento de datos adicionales en colección "users" de Firestore
Redirección automática a Dashboard tras registro exitoso
4.2 GESTIÓN DE ESTADO DE AUTENTICACIÓN (AuthProvider)
Extiende ChangeNotifier para integración con Provider
Propiedades: currentUser (User?), isAuthenticated (bool), isLoading (bool)
Métodos: signIn(), signUp(), signOut(), resetPassword()
Persistencia automática mediante Firebase Auth state changes
Notificación a widgets suscritos mediante notifyListeners()
4.3 REGLAS DE SEGURIDAD PARA FIRESTORE (CONFIGURAR EN CONSOLA)
rules_version = '2';
service cloud.firestore {
match /databases/{database}/documents {
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
}
}
================================================================================
5. ESTRUCTURA DE CARPETAS DEL PROYECTO
================================================================================
lib/
├── main.dart // Punto de entrada, inicialización de Firebase y Provider
├── app/
│ ├── router.dart // Configuración de rutas con go_router
│ ├── theme.dart // Definición de ThemeData global, colores y tipografía
│ └── app.dart // Widget raíz de la aplicación
│
├── core/
│ ├── constants/
│ │ ├── app_constants.dart // URLs, IDs de proyecto, strings globales
│ │ ├── route_constants.dart // Nombres de rutas para navegación tipo-safe
│ │ └── collection_constants.dart // Nombres de colecciones Firestore
│ ├── utils/
│ │ ├── validators.dart // Funciones de validación reutilizables (email, CURP, etc.)
│ │ ├── helpers.dart // Funciones utilitarias (formateo de fechas, monedas)
│ │ └── exceptions.dart // Clases de excepciones personalizadas
│ └── widgets/
│ ├── custom_app_bar.dart // AppBar personalizado con logo y bordes redondeados
│ ├── custom_footer.dart // Footer con copyright "Hernandez Roman A. 2026 6°I"
│ ├── custom_button.dart // Botones reutilizables con estilos predefinidos
│ ├── custom_text_field.dart // Campos de texto con validación integrada
│ ├── loading_indicator.dart // Indicador de carga circular centrado
│ └── empty_state_widget.dart // Widget para vistas sin datos
│
├── features/
│ ├── auth/
│ │ ├── data/
│ │ │ ├── repositories/
│ │ │ │ └── auth_repository_impl.dart // Implementación de repositorio de autenticación
│ │ │ ├── datasources/
│ │ │ │ └── firebase_auth_datasource.dart
│ │ │ └── models/
│ │ │ └── user_model.dart // Modelo serializable para Firestore
│ │ ├── domain/
│ │ │ ├── repositories/
│ │ │ │ └── auth_repository.dart // Interfaz del repositorio
│ │ │ └── entities/
│ │ │ └── user_entity.dart // Entidad de dominio para usuario
│ │ └── presentation/
│ │ ├── screens/
│ │ │ ├── login_screen.dart
│ │ │ ├── register_screen.dart
│ │ │ └── forgot_password_screen.dart
│ │ ├── providers/
│ │ │ └── auth_provider.dart // ChangeNotifier para estado de auth
│ │ └── widgets/
│ │ ├── login_form.dart
│ │ ├── register_form.dart
│ │ └── auth_banner.dart
│ │
│ ├── dashboard/
│ │ ├── presentation/
│ │ │ ├── screens/
│ │ │ │ └── admin_dashboard.dart // Pantalla principal con acceso a CRUDs
│ │ │ ├── providers/
│ │ │ │ └── dashboard_provider.dart
│ │ │ └── widgets/
│ │ │ ├── entity_card.dart // Tarjeta clickable para cada entidad
│ │ │ ├── welcome_banner.dart // Banner de bienvenida con nombre de usuario
│ │ │ └── stats_summary.dart // (Opcional) Resumen estadístico rápido
│ │
│ └── crud/
│ ├── data/
│ │ ├── services/
│ │ │ └── firestore_crud_service.dart // Servicio genérico para operaciones CRUD
│ │ ├── repositories/
│ │ │ └── generic_repository_impl.dart
│ │ └── models/
│ │ ├── paciente_model.dart
│ │ ├── medico_model.dart
│ │ ├── consulta_model.dart
│ │ └── ... (un modelo por entidad)
│ ├── domain/
│ │ ├── repositories/
│ │ │ └── generic_repository.dart
│ │ └── entities/
│ │ ├── paciente_entity.dart
│ │ ├── medico_entity.dart
│ │ └── ... (una entidad por tabla)
│ └── presentation/
│ ├── screens/
│ │ ├── crud_list_screen.dart // Pantalla reutilizable para listar entidades
│ │ ├── crud_form_screen.dart // Formulario dinámico para crear/editar
│ │ └── crud_detail_screen.dart // Vista de detalle de un registro
│ ├── providers/
│ │ └── crud_provider.dart // Gestor de estado para operaciones CRUD
│ └── widgets/
│ ├── search_filter_bar.dart
│ ├── data_table_responsive.dart
│ ├── confirmation_dialog.dart
│ └── form_field_builder.dart
│
├── config/
│ ├── firebase_options.dart // Generado automáticamente por FlutterFire CLI
│ └── injection_container.dart // (Opcional) Configuración de inyección de dependencias
│
└── assets/
├── images/
│ └── logo.jpg // Logo descargado localmente para carga offline
├── fonts/
│ └── (fuentes personalizadas si se requieren)
└── icons/
└── (iconos SVG personalizados)
================================================================================
6. MAPEO DE ENTIDADES A FIRESTORE COLLECTIONS
================================================================================
Basado en el archivo starmedica_entidades_dominio.html:
6.1 MÓDULO: PACIENTE Y EXPEDIENTE
Colección: patients
Documento ID: uuid (generado automáticamente)
Campos:
- nombre: string
- apellidos: string
- fecha_nacimiento: timestamp
- curp: string (indexado, único)
- tipo_sangre: string
- telefono: string
- email: string
- fecha_registro: timestamp
- activo: boolean
Colección: medical_records (expedientes clínicos)
Documento ID: uuid
Campos:
- paciente_id: reference (a patients/{id})
- fecha_apertura: timestamp
- alergias: string (texto largo)
- antecedentes: string (texto largo)
- enf_cronicas: string (texto largo)
- ultima_actualizacion: timestamp
Colección: medical_insurance (seguros médicos)
Documento ID: uuid
Campos:
- paciente_id: reference (a patients/{id})
- aseguradora: string
- no_poliza: string
- vigencia_inicio: timestamp
- vigencia_fin: timestamp
- cobertura_maxima: number
6.2 MÓDULO: PERSONAL CLÍNICO
Colección: employees
Documento ID: uuid
Campos:
- nombre: string
- apellidos: string
- puesto: string
- departamento: string
- fecha_ingreso: timestamp
- telefono: string
- email: string (indexado, único)
- activo: boolean
Colección: doctors
Documento ID: uuid
Campos:
- empleado_id: reference (a employees/{id})
- especialidad_id: reference (a specialties/{id})
- cedula_profesional: string (único)
- turno: string ('matutino', 'vespertino', 'nocturno')
- disponible: boolean
Colección: nurses
Documento ID: uuid
Campos:
- empleado_id: reference (a employees/{id})
- nivel: string ('R1', 'R2', 'R3', 'Jefe')
- turno: string
- area_id: reference (a areas/{id})
Colección: specialties
Documento ID: uuid
Campos:
- nombre: string (único)
- descripcion: string
- activa: boolean
6.3 MÓDULO: ATENCIÓN CLÍNICA
Colección: appointments (consultas)
Documento ID: uuid
Campos:
- paciente_id: reference
- medico_id: reference
- fecha_hora: timestamp
- motivo: string
- diagnostico: string
- tratamiento: string
- estado: string ('programada', 'en_proceso', 'completada', 'cancelada')
- notas: string
Colección: hospitalizations
Documento ID: uuid
Campos:
- paciente_id: reference
- medico_id: reference
- cama_id: reference
- fecha_ingreso: timestamp
- fecha_egreso: timestamp (nullable)
- diagnostico_ingreso: string
- estado: string ('activa', 'egresada')
Colección: surgeries (cirugías)
Documento ID: uuid
Campos:
- paciente_id: reference
- medico_id: reference
- quirofano_id: reference
- tipo_cirugia: string
- fecha_programada: timestamp
- duracion_min: number
- estado: string ('programada', 'en_proceso', 'completada')
Colección: prescriptions (recetas)
Documento ID: uuid
Campos:
- consulta_id: reference
- medico_id: reference
- paciente_id: reference
- fecha_emision: timestamp
- instrucciones_generales: string
- activa: boolean
6.4 MÓDULO: FARMACIA Y LABORATORIO
Colección: medications
Documento ID: uuid
Campos:
- nombre_generico: string (indexado)
- nombre_comercial: string
- presentacion: string
- precio_unitario: number
- stock_actual: number
- stock_minimo: number
- activo: boolean
Colección: prescription_items (subcolección o colección independiente)
Documento ID: uuid
Campos:
- receta_id: reference
- medicamento_id: reference
- dosis: string
- frecuencia: string
- duracion_dias: number
- instrucciones: string
Colección: laboratories
Documento ID: uuid
Campos:
- nombre: string
- descripcion: string
- precio_base: number
- tiempo_entrega_horas: number
- activo: boolean
Colección: lab_results
Documento ID: uuid
Campos:
- paciente_id: reference
- laboratorio_id: reference
- solicitud_id: string (referencia externa si aplica)
- resultado: string (texto largo o JSON estructurado)
- fecha_toma: timestamp
- fecha_entrega: timestamp
- interpretacion: string
6.5 MÓDULO: INFRAESTRUCTURA
Colección: floors (pisos)
Documento ID: uuid
Campos:
- numero: number
- nombre: string
- descripcion: string
Colección: rooms (habitaciones)
Documento ID: uuid
Campos:
- numero: string
- tipo: string ('simple', 'doble', 'suite', 'uc')
- capacidad: number
- piso_id: reference
- disponible: boolean
- precio_noche: number
Colección: beds (camas)
Documento ID: uuid
Campos:
- habitacion_id: reference
- numero: string
- tipo: string ('estandar', 'asistida', 'uci')
- disponible: boolean
- en_mantenimiento: boolean
Colección: operating_rooms (quirófanos)
Documento ID: uuid
Campos:
- nombre: string
- estado: string ('disponible', 'en_uso', 'mantenimiento')
- piso_id: reference
- equipamiento: list<string>
Colección: offices (consultorios)
Documento ID: uuid
Campos:
- numero: string
- especialidad_id: reference
- disponible: boolean
- medico_asignado_id: reference (nullable)
6.6 MÓDULO: ADMINISTRACIÓN Y FINANZAS
Colección: invoices (facturas)
Documento ID: uuid
Campos:
- paciente_id: reference
- subtotal: number
- iva: number
- total: number
- metodo_pago: string ('efectivo', 'tarjeta', 'transferencia', 'seguro')
- estado: string ('pendiente', 'pagada', 'cancelada')
- fecha_emision: timestamp
- fecha_pago: timestamp (nullable)
- folio_fiscal: string (único)
Colección: inventory (inventario)
Documento ID: uuid
Campos:
- descripcion: string
- categoria: string
- cantidad_disponible: number
- cantidad_minima: number
- precio_unitario: number
- proveedor: string
- ultima_actualizacion: timestamp
Colección: scheduled_appointments (citas programadas - sugerida)
Documento ID: uuid
Campos:
- paciente_id: reference
- medico_id: reference
- fecha_hora: timestamp (indexado)
- motivo: string
- estado: string ('programada', 'confirmada', 'cancelada', 'completada')
- recordatorio_enviado: boolean
================================================================================
7. PLAN DE IMPLEMENTACIÓN PASO A PASO
================================================================================
FASE 1: CONFIGURACIÓN INICIAL (DÍAS 1-2)
[ ] Crear proyecto Flutter:
flutter create --org com.starmedica --project-name starmedica_app starmedica_app
[ ] Configurar soporte multiplataforma:
flutter config --enable-windows-desktop
flutter config --enable-web
flutter config --enable-android
flutter config --enable-ios (requiere macOS)
[ ] Crear proyecto en Firebase Console:
- Ir a https://console.firebase.google.com
- Crear nuevo proyecto: "starmedicacrud"
- Desactivar Google Analytics para MVP (opcional)
[ ] Registrar aplicaciones en Firebase:
- Android: package name = com.starmedica.starmedica_app
- Web: registrar y descargar firebase-config.js
- Windows: registrar como aplicación web (mismo config)
- iOS: bundle identifier = com.starmedica.starmedica_app
[ ] Instalar FlutterFire CLI y configurar:
dart pub global activate flutterfire_cli
flutterfire configure --project=starmedicacrud
(Seleccionar plataformas: android, web, windows)
[ ] Actualizar pubspec.yaml con dependencias listadas en sección 2.2
[ ] Ejecutar instalación de paquetes:
flutter pub get
[ ] Configurar archivos de plataforma:
- Android: actualizar minSdkVersion a 23 en android/app/build.gradle
- Web: verificar web/index.html incluye Firebase SDK
- Windows: verificar windows/CMakeLists.txt tiene configuración correcta
[ ] Crear estructura de carpetas según sección 5
[ ] Implementar lib/app/theme.dart con paleta de colores oficial
FASE 2: AUTENTICACIÓN Y NAVEGACIÓN BASE (DÍAS 3-5)
[ ] Verificar lib/config/firebase_options.dart generado correctamente
[ ] Implementar main.dart con inicialización:
- WidgetsFlutterBinding.ensureInitialized()
- await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
- Configuración de MultiProvider con AuthProvider
[ ] Crear AuthService (lib/features/auth/data/services/auth_service.dart):
- Métodos: signInWithEmailAndPassword(), createUserWithEmailAndPassword(), signOut(), getCurrentUser()
- Manejo de errores con FirebaseAuthException
- Retorno de resultados con Either pattern o try/catch controlado
[ ] Implementar AuthProvider (lib/features/auth/presentation/providers/auth_provider.dart):
- Extender ChangeNotifier
- Propiedades: User? currentUser, bool isAuthenticated, bool isLoading, String? errorMessage
- Métodos async que llaman a AuthService y notifican cambios
[ ] Diseñar LoginScreen:
- Scaffold con CustomAppBar (banner azul con logo)
- Formulario con TextFormField para email y password
- Botones de acción con CustomButton
- Enlaces a registro y recuperación de contraseña
- CustomFooter fijo en parte inferior
- Validaciones en tiempo real con form_field_validator
[ ] Diseñar RegisterScreen:
- Campos adicionales: nombre completo, teléfono, selección de rol
- Confirmación de password
- Checkbox de términos y condiciones
- Mismo estilo visual que LoginScreen
[ ] Configurar sistema de rutas con go_router:
- Rutas públicas: /login, /register, /forgot-password
- Rutas protegidas: /dashboard, /crud/*
- Redirect logic basado en estado de autenticación
[ ] Implementar SplashScreen:
- Duración: 2 segundos
- Verificación de sesión activa con authStateChanges()
- Navegación condicional a Login o Dashboard
[ ] Pruebas de flujo completo:
- Registro de nuevo usuario -> Login automático -> Dashboard
- Login con credenciales existentes -> Dashboard
- Logout -> Redirección a Login
- Intento de acceso directo a ruta protegida sin sesión
FASE 3: DASHBOARD ADMINISTRATIVO (DÍAS 6-7)
[ ] Crear AdminDashboard (lib/features/dashboard/presentation/screens/admin_dashboard.dart):
- Scaffold con CustomAppBar dinámico (mensaje "Bienvenido, [Nombre]")
- GridView.builder para tarjetas de entidades
- Responsive: 1 columna móvil, 2 tablet, 3-4 desktop
- CustomFooter con "Hernandez Roman A. 2026 6°I"
[ ] Desarrollar EntityCard widget reutilizable:
- Parámetros: IconData icon, String title, String route, int? itemCount
- Diseño: Card con InkWell, icono grande, título centrado, contador opcional
- Animación: Hero tag para transiciones suaves
- Accesibilidad: Semantics labels, contraste adecuado
[ ] Implementar WelcomeBanner widget:
- Gradiente lineal de #003366 a #004080
- Texto blanco con TextStyle personalizado (google_fonts)
- Animación de entrada: FadeTransition + SlideTransition
- Mensaje dinámico según hora del día (Buenos días/tardes/noches)
[ ] Configurar navegación desde dashboard:
- Cada EntityCard navega a /crud/[entity_name]
- Pasar parámetros: collectionName, entityFields, entityIcon
- Uso de GoRouter state para datos de navegación
[ ] Agregar mejoras de UX:
- Pull-to-refresh en dashboard (opcional)
- Indicador de carga mientras se obtienen contadores de entidades
- Manejo de errores de conexión con Snackbar informativo
- Animaciones de entrada escalonadas para tarjetas (StaggeredAnimation)
[ ] Pruebas de responsive:
- Emulador Android: Pixel 5 (móvil), Pixel Tablet (tablet)
- Navegador web: Chrome, Firefox (modos móvil/desktop)
- Windows: ventana redimensionable, verificar layout adaptativo
FASE 4: MOTOR CRUD GENÉRICO (DÍAS 8-12)
[ ] Crear FirestoreCrudService (lib/features/crud/data/services/firestore_crud_service.dart):
- Método genérico create<T>(String collection, T model, String? docId)
- Método genérico readAll<T>(String collection, {Map<String, dynamic>? filters, int? limit})
- Método genérico readById<T>(String collection, String docId)
- Método genérico update<T>(String collection, String docId, T model)
- Método genérico delete(String collection, String docId)
- Método de búsqueda: search(String collection, String field, String value)
- Manejo de offline persistence con enablePersistence()
[ ] Implementar GenericRepository:
- Interfaz con métodos CRUD abstractos
- Implementación que usa FirestoreCrudService
- Transformación de modelos Firestore a entidades de dominio
- Manejo centralizado de excepciones y errores de red
[ ] Desarrollar CrudProvider:
- Estado: List<T> items, bool isLoading, String? error, T? selectedItem
- Métodos: fetchItems(), createItem(), updateItem(), deleteItem(), searchItems()
- Notificación de cambios a UI mediante notifyListeners()
- Soporte para paginación con query cursors de Firestore
[ ] Crear CrudListScreen reutilizable:
- Parámetros: String collectionName, List<FormFieldConfig> fields, IconData icon
- AppBar dinámico con título de entidad y botón de agregar
- Vista de datos: DataTable en desktop, ListView.cards en móvil
- Funcionalidades: búsqueda en tiempo real, filtros por campo, ordenamiento
- Acciones por fila: editar (icono lápiz), eliminar (icono basura con confirmación)
- Estado vacío: EmptyStateWidget con mensaje e ilustración
- Indicador de carga: LoadingIndicator centrado
[ ] Crear CrudFormScreen dinámico:
- Generación de campos basada en configuración (FormFieldConfig)
- Tipos soportados: text, email, phone, date, time, dropdown, boolean, number
- Validaciones integradas: required, email, pattern (CURP), min/max length
- Manejo de relaciones: dropdowns cargados desde otras colecciones (ej: especialidades)
- Botones: Guardar (primario), Cancelar (secundario)
- Confirmación de cambios no guardados al salir
[ ] Implementar CrudDetailScreen:
- Vista de solo lectura con todos los campos formateados
- Botones de acción: Editar, Eliminar, Volver
- Diseño limpio con secciones agrupadas por categoría de datos
- Soporte para campos largos con expansión (ExpandableText)
[ ] Agregar gestión de errores y feedback:
- Diálogo de confirmación personalizado para eliminaciones
- FlutterToast para mensajes de éxito/error no intrusivos
- Manejo de errores de Firestore: permission-denied, not-found, unavailable
- Reintentos automáticos para errores de conexión transitorios
FASE 5: IMPLEMENTACIÓN DE ENTIDADES CRÍTICAS (DÍAS 13-18)
[ ] ENTIDAD: PACIENTE (patients)
- Configurar campos en FormFieldConfig: nombre, apellidos, curp, fecha_nacimiento, tipo_sangre, telefono, email
- Validación única de CURP mediante query a Firestore antes de guardar
- Formato de fecha con intl: dd/MM/yyyy
- Búsqueda por nombre, apellidos o CURP
- Vista de detalle con enlace rápido a expediente clínico
[ ] ENTIDAD: MÉDICO (doctors)
- Relación con employees y specialties mediante dropdowns cargados desde Firestore
- Validación de cédula profesional única
- Filtro por especialidad y turno en lista
- Indicador visual de disponibilidad (chip verde/rojo)
[ ] ENTIDAD: CONSULTA (appointments)
- Selección de paciente y médico con búsqueda en tiempo real
- Validación de horarios: no permitir citas superpuestas para mismo médico
- Campo de diagnóstico con editor de texto enriquecido (opcional)
- Cambio de estado con dropdown: programada -> en proceso -> completada
[ ] ENTIDAD: MEDICAMENTO (medications)
- Búsqueda por nombre genérico o comercial con debounce
- Validación de precio >= 0 y stock >= 0
- Alerta visual cuando stock_actual < stock_minimo
- Exportación básica a CSV (opcional para MVP)
[ ] ENTIDAD: RECETA (prescriptions) + ITEMS
- Formulario maestro-detalle: datos de receta + lista de medicamentos
- Subcolección prescription_items o colección independiente con referencia
- Cálculo automático de duración total basada en medicamentos
- Generación de vista imprimible (futuro: pdf)
[ ] ENTIDAD: HOSPITALIZACIÓN (hospitalizations)
- Validación de disponibilidad de cama al crear hospitalización
- Actualización automática de cama.disponible = false al ingresar paciente
- Cálculo de días hospitalizados al registrar fecha_egreso
- Historial de hospitalizaciones por paciente (vista relacionada)
[ ] Implementar filtros avanzados y utilidades:
- Filtro por rango de fechas para consultas y hospitalizaciones
- Filtro por estado (activo/inactivo) para entidades con campo boolean
- Ordenamiento por múltiples campos (fecha DESC, nombre ASC)
- Exportación básica a CSV para reportes simples
FASE 6: OPTIMIZACIÓN Y TESTING (DÍAS 19-21)
[ ] Implementar caching para datos estáticos:
- Especialidades, departamentos, tipos de sangre: cargar una vez y almacenar en SharedPreferences
- Invalidación de cache al detectar actualizaciones en backend
[ ] Configurar offline persistence en Firestore:
- FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true)
- Pruebas de funcionamiento sin conexión: crear registros, sincronización al reconectar
[ ] Optimizar queries con índices compuestos:
- Identificar queries con múltiples filtros/ordenamientos
- Crear índices en Firebase Console según advertencias de Firestore
- Documentar índices requeridos en README.md
[ ] Pruebas unitarias:
- AuthService: métodos de login, registro, logout con mocks de FirebaseAuth
- Validators: funciones de validación de CURP, email, teléfono
- FormFieldConfig: generación de widgets según tipo de campo
[ ] Pruebas de widget:
- CustomAppBar: renderizado con logo, mensaje de bienvenida
- EntityCard: navegación al presionar, estado hover en web
- CrudListScreen: carga de datos, manejo de estado vacío, búsqueda
[ ] Pruebas de integración:
- Flujo completo: registro -> login -> dashboard -> crear paciente -> listar pacientes -> editar -> eliminar
- Navegación entre módulos: pacientes -> expediente -> recetas
- Comportamiento offline: crear registro sin conexión, verificar sincronización
[ ] Pruebas de usabilidad en dispositivos reales:
- Android: probar en dispositivo físico con diferentes densidades de pantalla
- iOS: probar en simulador o dispositivo (requiere macOS)
- Web: probar en Chrome, Firefox, Edge; verificar carga inicial y navegación
- Windows: probar instalación desde MSIX, redimensionamiento de ventana
[ ] Ajustes de accesibilidad:
- Contrast Checker: verificar relación de contraste >= 4.5:1 para texto
- Semantics: agregar labels descriptivos a iconos y botones
- Tamaño de texto: permitir escalado sin romper layout
- Navegación con teclado: soporte para tab navigation en web/desktop
[ ] Generar builds de prueba:
Android: flutter build apk --release --split-per-abi
Web: flutter build web --release --web-renderer canvaskit
Windows: flutter build windows --release
FASE 7: DESPLIEGUE Y DOCUMENTACIÓN (DÍAS 22-23)
[ ] Configurar Firebase Hosting para versión web:
- firebase init hosting
- Configurar rewrite rules para SPA: "**" -> "/index.html"
- Deploy de prueba: firebase deploy --only hosting
- Verificar URL: https://starmedicacrud.web.app
[ ] Generar APK firmado para Android:
- Crear keystore: keytool -genkey -v -keystore ~/upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
- Configurar android/key.properties con rutas y contraseñas
- Actualizar android/app/build.gradle con signingConfigs
- Build final: flutter build appbundle --release (recomendado para Play Store)
[ ] Preparar instalador para Windows:
- Configurar windows/runner/Runner.rc con icono, versión, descripción
- Generar MSIX: flutter build windows --release
- Empaquetar con herramienta externa si se requiere tienda Microsoft
[ ] Documentación técnica:
- README.md con: descripción del proyecto, requisitos, instalación, estructura, comandos útiles
- ARCHITECTURE.md: explicación de patrones usados, flujo de datos, decisiones de diseño
- FIREBASE_SETUP.md: pasos para configurar nuevo entorno, variables de entorno, reglas de seguridad
[ ] Documentación de usuario:
- Guía rápida de inicio: cómo registrarse, navegar, crear registros básicos
- Glosario de términos médicos y técnicos usados en la app
- Contacto de soporte y reporte de errores
[ ] Configurar monitoreo y analítica:
- Firebase Crashlytics: inicializar en main.dart, probar con crash de prueba
- Firebase Performance Monitoring: habilitar para rastrear tiempos de carga
- (Opcional) Google Analytics para uso de características (respetando privacidad)
[ ] Plan de mantenimiento:
- Actualizaciones de dependencias: revisar cada 2 semanas con flutter pub outdated
- Backups de Firestore: configurar exportación automática diaria
- Revisión de reglas de seguridad: auditoría mensual de permisos
- Roadmap de características: lista priorizada de mejoras futuras
================================================================================
8. CONSIDERACIONES TÉCNICAS ADICIONALES
================================================================================
8.1 MANEJO DE FECHAS Y ZONAS HORARIAS
Usar paquete intl para formateo consistente: dd/MM/yyyy HH:mm
Almacenar timestamps en Firestore como Timestamp (no String)
Convertir a DateTime local para mostrar en UI: timestamp.toDate()
Considerar zona horaria del hospital para consultas y hospitalizaciones
Para reportes: permitir selección de zona horaria o usar UTC con conversión
8.2 VALIDACIÓN DE CURP MEXICANO
Implementar validador personalizado que verifique:
Longitud exacta de 18 caracteres
Formato alfanumérico correcto (4 letras + 6 números + 2 letras + 1 número + 1 letra + 2 caracteres alfanuméricos + 1 dígito verificador)
Fecha de nacimiento válida y coherente con los dígitos
Entidad federativa válida según catálogo oficial
Dígito verificador calculado correctamente
Fuente de referencia: algoritmo oficial RENAPO
Nota: Para MVP puede usarse validación de formato básico; validación completa como mejora futura
8.3 GESTIÓN DE PERMISOS Y ROLES
Campo role en colección users: 'admin', 'medico', 'enfermero', 'recepcion'
Reglas de Firestore que restringen escritura según rol:
admin: acceso total a todas las colecciones
medico: lectura/escritura en patients, appointments, medical_records (solo propios)
enfermero: lectura en patients, escritura limitada en appointments
recepcion: lectura en patients, escritura en scheduled_appointments
UI que oculta botones/acciones no permitidas según rol del usuario actual
8.4 ESTRATEGIA DE BÚSQUEDA Y FILTRADO
Para búsquedas simples: usar where(field, isEqualTo: value) con índices
Para búsquedas parciales (nombre, apellidos):
Opción MVP: cargar todos y filtrar en cliente (solo para colecciones pequeñas)
Opción escalable: integrar Algolia o Typesense para búsqueda full-text
Filtros combinados: usar where múltiple con índices compuestos predefinidos
Paginación: usar limit() + startAfterDocument() para carga progresiva
8.5 MANEJO DE IMÁGENES Y ARCHIVOS ADJUNTOS
Para fotos de pacientes, documentos escaneados, resultados de laboratorio:
Usar Firebase Storage con estructura: /starmedica/[collection]/[docId]/[filename]
Validar tipo y tamaño de archivo antes de subir (máx 5MB para MVP)
Almacenar solo la URL de descarga en el documento de Firestore
Usar cached_network_image para carga eficiente en UI
Considerar compresión de imágenes en cliente antes de subir
8.6 ESTRATEGIA DE RESPALDO Y RECUPERACIÓN
Firebase Firestore: habilitar exportación automática diaria a Google Cloud Storage
Configuración de retención: 30 días para backups automáticos
Procedimiento de recuperación: documentar pasos para restaurar colección específica
Para datos críticos (expedientes): considerar backup adicional externo semanal
================================================================================
9. CRONOGRAMA ESTIMADO Y ENTREGABLES
================================================================================
Semana 1 (Días 1-7):
Entregable: Aplicación funcional con login, registro y dashboard vacío
Criterios de aceptación:
- Usuario puede registrarse con email/password
- Usuario puede iniciar sesión y ver mensaje de bienvenida
- Dashboard muestra tarjetas de entidades (sin funcionalidad CRUD aún)
- Layout responsive en móvil, tablet y web
- Footer con copyright visible en todas las pantallas
Semana 2 (Días 8-14):
Entregable: Motor CRUD genérico funcional para 2 entidades de prueba
Criterios de aceptación:
- CRUD completo (crear, leer, actualizar, eliminar) para "patients" y "specialties"
- Validaciones de formulario operativas
- Búsqueda y filtrado básico funcionando
- Manejo de errores y estados de carga visibles
- Persistencia en Firestore verificada
Semana 3 (Días 15-21):
Entregable: Implementación de 5 entidades críticas + optimizaciones
Criterios de aceptación:
- CRUD funcional para: patients, doctors, appointments, medications, prescriptions
- Relaciones entre entidades operativas (dropdowns con datos relacionados)
- Validaciones de negocio implementadas (CURP único, horarios no superpuestos)
- Pruebas de integración aprobadas para flujos principales
- Builds de prueba generados para Android, Web y Windows
Semana 4 (Días 22-28):
Entregable: Versión lista para despliegue + documentación completa
Criterios de aceptación:
- Todas las 20+ entidades con CRUD básico implementado
- Reglas de seguridad de Firestore configuradas y probadas
- Documentación técnica y de usuario completada
- Builds finales firmados y listos para distribución
- Firebase Hosting configurado para versión web
- Crashlytics activo y monitoreando errores
================================================================================
10. RIESGOS Y MITIGACIONES
================================================================================
Riesgo 1: Complejidad de validación de CURP
Impacto: Alto (campo obligatorio y único en pacientes)
Mitigación:
- Fase 1: Validación de formato básico (longitud, caracteres)
- Fase 2: Implementar algoritmo completo de verificación RENAPO
- Fase 3: Integrar API de validación oficial si está disponible
Riesgo 2: Costos de Firebase con crecimiento de datos
Impacto: Medio (lecturas/escrituras en Firestore tienen costo)
Mitigación:
- Implementar paginación y carga progresiva en listas
- Usar caching para datos estáticos y de solo lectura
- Monitorear uso con Firebase Console y configurar alertas de presupuesto
- Optimizar queries para minimizar lecturas innecesarias
Riesgo 3: Compatibilidad multiplataforma de widgets personalizados
Impacto: Medio (diferencias en renderizado web vs móvil)
Mitigación:
- Probar cada widget nuevo en las 3 plataformas objetivo desde el inicio
- Usar LayoutBuilder y MediaQuery para adaptación responsive
- Evitar plugins con soporte limitado a una sola plataforma
- Mantener fallbacks visuales para características no soportadas en todas las plataformas
Riesgo 4: Curva de aprendizaje de Clean Architecture para el equipo
Impacto: Bajo-Medio (dependiendo de experiencia previa)
Mitigación:
- Documentar claramente la estructura de carpetas y flujo de datos
- Crear ejemplos base comentados para cada tipo de archivo (model, repository, provider)
- Realizar sesión de onboarding técnico al inicio del proyecto
- Mantener arquitectura simplificada: evitar sobre-ingeniería para MVP
================================================================================
11. PRÓXIMOS PASOS INMEDIATOS
================================================================================
Ejecutar comandos de inicialización del proyecto (Fase 1, día 1)
Confirmar en Firebase Console que el proyecto "starmedicacrud" está activo y tiene habilitados:
Authentication > Sign-in method > Email/Password: Habilitado
Firestore Database: Creada en modo producción (no reglas de prueba)
Storage: Habilitado (para futura gestión de archivos)
Validar que flutter pub get instala todas las dependencias sin conflictos
Implementar y probar SplashScreen + LoginScreen como primer entregable funcional
Establecer canal de comunicación para revisiones diarias de avance (Slack, Teams, o correo)
Crear repositorio Git privado y realizar commit inicial con estructura base
================================================================================
NOTAS FINALES
Este plan sigue el estándar de desarrollo profesional sin usar configuración de producción prematura, como solicitado.
No se incluye código fuente en este documento; el código se generará en fases posteriores tras aprobación del plan.
La arquitectura está diseñada para ser escalable: nuevas entidades pueden agregarse replicando el patrón CRUD genérico.
Todas las decisiones de diseño priorizan la usabilidad para personal médico: interfaces limpias, flujos cortos, feedback inmediato.
El footer con "Hernandez Roman A. 2026 6°I" estará presente en todas las pantallas como requisito de autoría.


