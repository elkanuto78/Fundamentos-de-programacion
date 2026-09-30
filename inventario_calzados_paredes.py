TALLAS = [34, 35, 36, 37, 38, 39]
STOCK_MIN = 5

nombres = []
inventario = []


def leer_entero(mensaje):
    while True:
        txt = input(mensaje)
        if txt.isdigit():
            return int(txt)
        print("No es un numero valido. Intente de nuevo.")


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
        stocks.append(leer_entero(f"Stock talla {talla}: "))
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
    talla = leer_entero("Talla a actualizar (34-39): ")
    if talla < 34 or talla > 39:
        print("Talla invalida.")
        return
    nuevo_stock = leer_entero("Nuevo stock: ")
    inventario[idx][talla - 34] = nuevo_stock
    print("Stock actualizado.")


def main():
    while True:
        print()
        print("1. Registrar producto")
        print("2. Consultar productos")
        print("3. Actualizar stock por talla")
        print("4. Salir")
        opcion = leer_entero("Seleccione una opcion: ")

        if opcion == 1:
            registrar_producto()
        elif opcion == 2:
            consultar_productos()
        elif opcion == 3:
            actualizar_stock()
        elif opcion == 4:
            print("Saliendo...")
            break
        else:
            print("Opcion invalida.")


if __name__ == "__main__":
    main()
