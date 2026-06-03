import 'dart:io';

Future<void> main() async {
  print('\n==================================================');
  print('        AGENTE DE REPOSITORIO GITHUB (DART)       ');
  print('==================================================\n');

  // Verificar si git existe
  var gitCheck = await Process.run('git', ['--version']);
  if (gitCheck.exitCode != 0) {
    print('❌ Error: Git no está instalado o no se encuentra en las variables de entorno (PATH).');
    exit(1);
  }

  // 1. Validar si ya es un repositorio
  var statusResult = await Process.run('git', ['status']);
  if (statusResult.exitCode != 0) {
    print('📌 Inicializando repositorio Git local porque no existe...');
    await Process.run('git', ['init']);
  } else {
    print('✅ Repositorio local ya inicializado.');
  }

  // 2. Comprobar / Configurar el remoto origin
  var remoteResult = await Process.run('git', ['remote', '-v']);
  String outputRemote = remoteResult.stdout.toString();
  
  if (outputRemote.isEmpty) {
    stdout.write('🔗 Introduce el enlace (URL) de tu repositorio de GitHub: ');
    String? repoLink = stdin.readLineSync();
    if (repoLink == null || repoLink.trim().isEmpty) {
      print('❌ Error: El enlace no puede estar vacío.');
      exit(1);
    }
    print('Añadiendo remoto origin: ${repoLink.trim()} ...');
    var addRemote = await Process.run('git', ['remote', 'add', 'origin', repoLink.trim()]);
    if (addRemote.exitCode != 0) print(addRemote.stderr);
  } else {
    print('✅ Remoto configurado:\n$outputRemote');
  }

  // 3. Añadir archivos al stage
  print('📦 Preparando archivos (git add .) ...');
  await Process.run('git', ['add', '.']);

  // Mostrar el estado breve
  var shortStatus = await Process.run('git', ['status', '-s']);
  if (shortStatus.stdout.toString().trim().isEmpty) {
    print('⚠️ No hay cambios nuevos detectados para hacer commit.');
  }

  // 4. Pedir el mensaje para el commit
  stdout.write('💬 Introduce el mensaje para el commit: ');
  String? commitMsg = stdin.readLineSync();
  if (commitMsg == null || commitMsg.trim().isEmpty) {
    commitMsg = 'Actualización general de archivos';
    print('⚠️ Mensaje vacío. Utilizando mensaje por defecto: "$commitMsg"');
  }

  print('💾 Creando commit...');
  var commitResult = await Process.run('git', ['commit', '-m', commitMsg]);
  if (commitResult.exitCode == 0) {
    print('✅ Commit creado con éxito.');
  } else {
    String error = commitResult.stderr.toString();
    String out = commitResult.stdout.toString();
    if (out.contains('nothing to commit') || error.contains('nothing to commit')) {
      print('✅ No hubo nada nuevo para el commit (no hay cambios). Continuamos a la subida...');
    } else {
      print(out);
      print(error);
    }
  }

  // 5. Preguntar por la rama (default: main)
  stdout.write('🌿 ¿A qué rama deseas subir los cambios? (Deja en blanco y presiona Enter para usar "main"): ');
  String? rama = stdin.readLineSync();
  if (rama == null || rama.trim().isEmpty) {
    rama = 'main';
  }

  // Aseguramos que la rama actual se renombre al nombre seleccionado (muy útil para repositorios nuevos)
  await Process.run('git', ['branch', '-M', rama]);

  print('\n🚀 Subiendo los cambios a GitHub (origin/$rama)...');
  
  // 6. Subir los cambios a GitHub
  // Usamos Process.start con inheritStdio para que la terminal muestre el progreso, 
  // e interactúe en caso de pedir credenciales o tokens.
  var pushProcess = await Process.start('git', ['push', '-u', 'origin', rama], mode: ProcessStartMode.inheritStdio);
  int exitCode = await pushProcess.exitCode;

  print('\n==================================================');
  if (exitCode == 0) {
    print(' 🎉 ¡PROCESO COMPLETADO! Cambios subidos existosamente a "$rama".');
  } else {
    print(' ❌ Hubo un error al intentar subir los cambios a GitHub.');
    print(' Por favor, verifica tu conexión, permisos o si el repositorio es correcto.');
  }
  print('==================================================\n');
}