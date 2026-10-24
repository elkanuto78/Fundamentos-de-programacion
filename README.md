# Fundamentos-de-programacion

Prototipo de inventario digital de calzado por tallas, desarrollado para la Evaluación Final de **Fundamentos de Programación (CIIN1205P)** de la Universidad Privada del Norte (UPN).

## Descripción

Programa de consola para el control de inventario de **Calzados Paredes S.A.C.** (El Porvenir, Trujillo). Reemplaza el cuaderno de existencias por un registro digital que permite registrar, consultar y actualizar el stock de cada producto separado por talla (34 a 39), con alerta cuando el stock de una talla es menor a 5 unidades.

## Archivos

| Archivo | Descripción |
| --- | --- |
| `inventarioCalzadosParedes.py` | Versión final en Python |
| `InventarioCalzadosParedes.psc` | Diseño inicial en pseudocódigo (PSeInt) |
| `inventario.txt` | Datos del inventario en formato JSON; el programa lo genera y lo actualiza automáticamente |
| `README.md` | Este archivo |

## Requisitos

- **Python 3** (probado con Python 3.12). Usa solo la biblioteca estándar (`json` y `os`), no hay que instalar nada.
- **PSeInt** (opcional), solo para abrir la versión en pseudocódigo.

## Cómo ejecutar

### Python

1. Descargar o clonar el repositorio:

   ```bash
   git clone https://github.com/elkanuto78/Fundamentos-de-programacion.git
   cd Fundamentos-de-programacion
   ```

2. Ejecutar el programa desde la carpeta del repositorio:

   ```bash
   python inventarioCalzadosParedes.py
   ```

   En algunos sistemas el comando es `python3 inventarioCalzadosParedes.py`.

3. Elegir una opción del menú:

   ```
   ===== INVENTARIO DE CALZADO =====
   1. Registrar producto
   2. Consultar productos
   3. Actualizar stock por talla
   4. Salir
   ```

### PSeInt

Abrir `InventarioCalzadosParedes.psc` en PSeInt y ejecutar. Esta versión no guarda los datos al salir.

## Funcionalidades

- Registrar un producto con su stock en cada talla (34 a 39), sin permitir nombres vacíos ni duplicados (se ignoran mayúsculas, minúsculas y espacios sobrantes).
- Consultar los productos en orden alfabético, con alerta de stock bajo (menos de 5 unidades).
- Actualizar el stock de una talla de un producto existente.
- Validar los datos numéricos: si el valor ingresado no es válido, se vuelve a pedir.
- Guardar los datos entre ejecuciones en `inventario.txt`.

## Formato de `inventario.txt`

Los datos se guardan como JSON, con una entrada por producto y su stock por talla:

```json
{
  "Tipo de calzado": [
    {
      "nombre": "Sandalia Sport",
      "tallas": {
        "34": 1,
        "35": 1,
        "36": 1,
        "37": 1,
        "38": 1,
        "39": 1
      }
    }
  ]
}
```

Si el archivo tiene un formato incorrecto, el programa avisa, guarda una copia en `inventario_respaldo.txt` e inicia con el inventario vacío, sin destruir el contenido original.

## Integrantes

- Deyvi Josué Ruiz Morán
- Masaki Sebastián Matsuda Paredes
- Nathaly Estefany Alva Alvarado

Docente: Anthony Delgado Chavarri · Trujillo, Perú · octubre de 2026
