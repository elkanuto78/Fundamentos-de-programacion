
import json
import os

TALLAS = [34, 35, 36, 37, 38, 39]
STOCK_MIN = 5
ARCHIVO = "inventario.txt"

nombres = []
inventario = []


def cargar_datos():
    if not os.path.exists(ARCHIVO):
        return

    try:
        with open(ARCHIVO, "r", encoding="utf-8") as f:
            datos = json.load(f)

        for producto in datos.get("Tipo de calzado", []):
            nombre = producto["nombre"]
            tallas = producto["tallas"]

            stocks = [int(tallas[str(t)]) for t in TALLAS]

            nombres.append(nombre)
            inventario.append(stocks)

        ordenar_burbuja()

    except (json.JSONDecodeError, KeyError, TypeError, ValueError):
        print("Error: el archivo de inventario tiene un formato incorrecto.")


def guardar_datos():
    productos = []

    for nombre, stocks in zip(nombres, inventario):
        tallas = {
            str(t): s for t, s in zip(TALLAS, stocks)
        }

        productos.append({
            "nombre": nombre,
            "tallas": tallas
        })

    with open(ARCHIVO, "w", encoding="utf-8") as f:
        json.dump(
            {"Tipo de calzado": productos},
            f,
            ensure_ascii=False,
            indent=2
        )


def leer_entero(mensaje, nombre_dato, minimo=0, maximo=None):
    while True:
        txt = input(mensaje).strip()

        if txt.isdigit():
            valor = int(txt)

            if valor >= minimo and (
                maximo is None or valor <= maximo
            ):
                return valor

        print(f"Inválido. Ingrese nuevamente {nombre_dato}.")


def buscar_producto(nombre):
    nombre = nombre.strip().casefold()

    for i, n in enumerate(nombres):
        if n.casefold() == nombre:
            return i

    return -1


def registrar_producto():
    nombre = input("Nombre del producto: ").strip()

    if not nombre:
        print("El nombre no puede estar vacío.")
        return

    if buscar_producto(nombre) != -1:
        print("Ese producto ya existe. Use la opción Actualizar stock.")
        return

    stocks = []

    for talla in TALLAS:
        stock = leer_entero(
            f"Stock talla {talla}: ",
            "el stock"
        )
        stocks.append(stock)

    nombres.append(nombre)
    inventario.append(stocks)

    ordenar_burbuja()
    guardar_datos()

    print("Producto registrado correctamente.")


def consultar_productos():
    if not nombres:
        print("No hay productos registrados.")
        return

    for i, nombre in enumerate(nombres):
        print(f"\nProducto: {nombre}")

        for j, talla in enumerate(TALLAS):
            stock = inventario[i][j]

            if stock < STOCK_MIN:
                print(
                    f"  Talla {talla}: {stock} "
                    "*** ALERTA: STOCK BAJO ***"
                )
            else:
                print(f"  Talla {talla}: {stock}")


def actualizar_stock():
    nombre = input(
        "Nombre del producto a actualizar: "
    ).strip()

    idx = buscar_producto(nombre)

    if idx == -1:
        print("Producto no encontrado.")
        return

    print("Tallas disponibles:", ", ".join(map(str, TALLAS)))

    while True:
        talla = leer_entero(
            "Talla a actualizar: ",
            "la talla"
        )

        if talla in TALLAS:
            break

        print("Talla inválida. Seleccione una talla de la lista.")

    nuevo_stock = leer_entero(
        "Nuevo stock: ",
        "el stock"
    )

    posicion = TALLAS.index(talla)
    inventario[idx][posicion] = nuevo_stock

    guardar_datos()

    print("Stock actualizado correctamente.")


def ordenar_burbuja():
    n = len(nombres)

    for i in range(n - 1):
        hubo_cambio = False

        for j in range(n - 1 - i):
            if nombres[j].casefold() > nombres[j + 1].casefold():
                nombres[j], nombres[j + 1] = (
                    nombres[j + 1],
                    nombres[j]
                )

                inventario[j], inventario[j + 1] = (
                    inventario[j + 1],
                    inventario[j]
                )

                hubo_cambio = True

        if not hubo_cambio:
            break


def main():
    cargar_datos()

    while True:
        print("\n===== INVENTARIO DE CALZADO =====")
        print("1. Registrar producto")
        print("2. Consultar productos")
        print("3. Actualizar stock por talla")
        print("4. Salir")

        opcion = leer_entero(
            "Seleccione una opción: ",
            "la opción",
            1,
            4
        )

        if opcion == 1:
            registrar_producto()

        elif opcion == 2:
            consultar_productos()

        elif opcion == 3:
            actualizar_stock()

        elif opcion == 4:
            guardar_datos()
            print("Inventario guardado. Saliendo...")
            break


if __name__ == "__main__":
    main()
