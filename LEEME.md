# Mi Barbería — guía de instalación

Esta carpeta contiene una aplicación web instalable (PWA). **No está publicada todavía** y el guardado en la nube no funcionará hasta completar la configuración de Supabase descrita abajo.

## Qué incluye
- Registro de cortes (importe inicial $12.000, editable).
- Registro de gastos por categoría.
- Totales mensuales de ingresos, gastos, balance y cantidad de cortes.
- Historial con filtros y eliminación.
- Exportación de todos los movimientos a JSON y CSV.
- Inicio de sesión con correo y contraseña; los registros se guardan en Supabase y se filtran por cuenta mediante Row Level Security.
- Archivos PWA para agregarla a la pantalla de inicio del iPhone.

## Paso 1 — crear el proyecto de base de datos
1. Entrá a https://supabase.com/ y creá una cuenta/proyecto.
2. Guardá la contraseña del proyecto en un lugar seguro.
3. En el panel del proyecto, abrí **SQL Editor** y ejecutá todo el contenido de `supabase.sql`.
4. Andá a **Project Settings → API** (o la sección equivalente de API Keys). Copiá el Project URL y la clave pública `anon`/publishable. **Nunca uses una `service_role` o secret key en esta app.**

## Paso 2 — conectar la aplicación
No hace falta editar código. Después de publicar y abrir la app, aparecerá una pantalla de configuración. Pegá ahí el **Project URL** y la clave pública **anon/publishable** de Supabase. La app los guarda en ese navegador. **Nunca uses una `service_role` o secret key.** La protección de los registros la hace Row Level Security (RLS).

## Paso 3 — publicar con HTTPS
Una manera sencilla es usar Netlify:
1. Entrá a https://app.netlify.com/drop desde una computadora.
2. Descomprimí el ZIP y arrastrá la carpeta que contiene `index.html`, `manifest.webmanifest`, `sw.js`, los íconos y `supabase.sql` (podés subir solo los archivos web; el SQL y esta guía no hacen falta para que la app corra).
3. Netlify te dará una URL HTTPS. Guardala.
4. En Supabase, revisá **Authentication → URL Configuration** y agregá la URL publicada como Site URL / Redirect URL si corresponde.

También podés publicarla en otro hosting estático HTTPS. No la abras desde `file://`: las funciones PWA necesitan un sitio HTTPS.

## Paso 4 — crear cuenta y probar
1. Abrí la URL publicada en Safari.
2. Elegí **Crear cuenta nueva** e ingresá un correo y contraseña de al menos 8 caracteres.
3. Si Supabase solicita confirmación por correo, confirmá y después iniciá sesión.
4. Registrá un corte de prueba de importe bajo, actualizá la página y comprobá que siga ahí. Luego eliminá el registro de prueba.
5. Registrá un gasto de prueba y repetí la comprobación.

## Paso 5 — agregarla al iPhone
1. Abrí la URL en **Safari** (no dentro de una vista previa de otra app).
2. Tocá **Compartir**.
3. Elegí **Agregar a pantalla de inicio**. Si aparece la opción, activá **Abrir como app web**.
4. Tocá **Agregar**. Vas a ver el ícono de Mi Barbería en la pantalla de inicio.

## Uso y copias de seguridad
- Para que los movimientos se sincronicen con la nube necesitás conexión a internet.
- Entrá a **Respaldo** y descargá periódicamente JSON (copia completa) o CSV (para Numbers/Excel). Guardá los archivos en Archivos/iCloud Drive.
- La app no incluye todavía importación/restauración automática desde JSON. Si necesitás restaurar datos, conservá el archivo y pedí ayuda para importar de forma segura.
- No compartas tu cuenta. Usá una contraseña única.
- Esta primera versión registra ingresos y gastos de la barbería; no mezcla el sueldo del hospital ni gastos personales.

## Si algo falla
- “Falta configurar”: todavía no reemplazaste los dos valores de Supabase o quedaron mal copiados.
- Error de base de datos / “relation movements does not exist”: ejecutá `supabase.sql` en el SQL Editor.
- No se guardan datos: revisá que estés conectado, que hayas iniciado sesión y que el script SQL se haya ejecutado completo.
- No instala como app: asegurate de usar la URL HTTPS publicada y abrirla desde Safari.
