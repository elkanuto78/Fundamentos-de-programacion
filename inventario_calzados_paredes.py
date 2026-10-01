import json
import os

TALLAS = [34, 35, 36, 37, 38, 39]
STOCK_MIN = 5
ARCHIVO = "inventario.txt"

nombres = []
inventario = []


def cargar_datos():
    if os.path.exists(ARCHIVO):
        with open(ARCHIVO, "r", encoding="utf-8") as f:
            datos = json.load(f)
            for producto in datos.get("Tipo de calzado", []):
                nombres.append(producto["nombre"])
                inventario.append([producto["tallas"][str(t)] for t in TALLAS])


def guardar_datos():
    productos = []
    for nombre, stocks in zip(nombres, inventario):
        tallas = {str(t): s for t, s in zip(TALLAS, stocks)}
        productos.append({"nombre": nombre, "tallas": tallas})
    with open(ARCHIVO, "w", encoding="utf-8") as f:
        json.dump({"Tipo de calzado": productos}, f, ensure_ascii=False, indent=2)


def leer_entero(mensaje, nombre_dato, minimo=None, maximo=None):
    while True:
        txt = input(mensaje)
        if txt.isdigit():
            valor = int(txt)
            if (minimo is None or valor >= minimo) and (maximo is None or valor <= maximo):
                return valor
        print(f"Invalido, volver a dar {nombre_dato}: ")


def buscar_producto(nombre):
    for i, n in enumerate(nombres):
        if n == nombre:
            return i
    return -1


def registrar_producto():
    nombre = input("Nombre del producto: ")
    if buscar_producto(nombre) != -1:
        print("Ese producto ya existe. Use la opcion Actualizar stock.")
        return
    stocks = []
    for talla in TALLAS:
        stocks.append(leer_entero(f"Stock talla {talla}: ", "stock"))
    nombres.append(nombre)
    inventario.append(stocks)
    print("Producto registrado.")


def consultar_productos():
    if not nombres:
        print("No hay productos registrados.")
        return
    for i, nombre in enumerate(nombres):
        print(f"Producto: {nombre}")
        for j, talla in enumerate(TALLAS):
            stock = inventario[i][j]
            if stock < STOCK_MIN:
                print(f"  Talla {talla}: {stock} *** ALERTA: STOCK BAJO ***")
            else:
                print(f"  Talla {talla}: {stock}")


def actualizar_stock():
    nombre = input("Nombre del producto a actualizar: ")
    idx = buscar_producto(nombre)
    if idx == -1:
        print("Producto no encontrado.")
        return
    talla = leer_entero("Talla a actualizar (34-39): ", "talla", 34, 39)
    nuevo_stock = leer_entero("Nuevo stock: ", "stock")
    inventario[idx][talla - 34] = nuevo_stock
    print("Stock actualizado.")


def main():
    cargar_datos()
    while True:
        print()
        print("1. Registrar producto")
        print("2. Consultar productos")
        print("3. Actualizar stock por talla")
        print("4. Salir")
        opcion = leer_entero("Seleccione una opcion: ", "opcion", 1, 4)

        if opcion == 1:
            registrar_producto()
        elif opcion == 2:
            consultar_productos()
        elif opcion == 3:
            actualizar_stock()
        elif opcion == 4:
            guardar_datos()
            print("Saliendo...")
            break


if __name__ == "__main__":
    main()
