# Fundamentos-de-programacion
## Descripcion
Programa de control de inventario para Calzados Paredes S.A.C., que permite registrar,
consultar y actualizar el stock de productos separado por talla (34-39).

## Archivos
- `InventarioCalzadosParedes.psc` — version en pseudocodigo (PSeInt)
- `inventarioCalzadosParedes.py` — version en Python
- `inventario.txt` — archivo donde se guardan los datos entre ejecuciones (se genera automaticamente)

## Como ejecutar
### PSeInt
Abrir `InventarioCalzadosParedes.psc` en PSeInt y ejecutar.

### Python
## Funcionalidades
- Registrar producto con stock por talla (34 a 39)
- Consultar productos, con alerta de stock bajo
- Actualizar stock de una talla especifica
- Validacion de datos: si el valor ingresado es invalido, se vuelve a pedir
- Persistencia de datos entre ejecuciones (inventario.txt)
