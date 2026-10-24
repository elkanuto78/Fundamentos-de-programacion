Funcion b <- esNum(t)
    Definir k, n Como Entero
    Definir car Como Caracter
    b <- Verdadero
    n <- Longitud(t)
    Si n = 0 Entonces
        b <- Falso
    SiNo
        Para k <- 1 Hasta n Con Paso 1
            car <- SubCadena(t, k, k)
            Si NO (car >= "0" Y car <= "9") Entonces
                b <- Falso
            FinSi
        FinPara
    FinSi
FinFuncion

Algoritmo InventarioCalzadosParedes
    Definir op, i, j, k, c, sMin, t, sVal, idx, pos Como Entero
    Definir nom, nB, aux, txt Como Caracter
    Definir inv, tallas Como Entero
    Definir enc, ok, hubo Como Logico

    Dimension nom[100]
    Dimension inv[100,6]
    Dimension tallas[6]

    // Tallas disponibles (equivale a TALLAS = [34..39])
    Para j <- 1 Hasta 6 Con Paso 1
        tallas[j] <- 33 + j
    FinPara

    c <- 0
    sMin <- 5

    Repetir
        Escribir ""
        Escribir "===== INVENTARIO DE CALZADO ====="
        Escribir "1. Registrar producto"
        Escribir "2. Consultar productos"
        Escribir "3. Actualizar stock por talla"
        Escribir "4. Salir"
        Escribir "Seleccione una opcion: "

        ok <- Falso
        Repetir
            Leer txt
            Si esNum(txt) Entonces
                op <- ConvertirANumero(txt)
                Si op >= 1 Y op <= 4 Entonces
                    ok <- Verdadero
                SiNo
                    Escribir "Invalido. Ingrese nuevamente la opcion."
                FinSi
            SiNo
                Escribir "Invalido. Ingrese nuevamente la opcion."
            FinSi
        Hasta Que ok

        Segun op Hacer
            1:
                // ---------- Registrar producto ----------
                Escribir "Nombre del producto: "
                Leer nB
                Si Longitud(nB) = 0 Entonces
                    Escribir "El nombre no puede estar vacio."
                SiNo
                    // Busqueda sin distinguir mayusculas/minusculas (casefold)
                    enc <- Falso
                    Para i <- 1 Hasta c Con Paso 1
                        Si Minusculas(nom[i]) = Minusculas(nB) Entonces
                            enc <- Verdadero
                        FinSi
                    FinPara

                    Si enc Entonces
                        Escribir "Ese producto ya existe. Use la opcion Actualizar stock."
                    SiNo
                        c <- c + 1
                        nom[c] <- nB
                        Para j <- 1 Hasta 6 Con Paso 1
                            Escribir "Stock talla ", tallas[j], ": "
                            ok <- Falso
                            Repetir
                                Leer txt
                                Si esNum(txt) Entonces
                                    inv[c,j] <- ConvertirANumero(txt)
                                    ok <- Verdadero
                                SiNo
                                    Escribir "Invalido. Ingrese nuevamente el stock."
                                FinSi
                            Hasta Que ok
                        FinPara

                        // Ordenamiento burbuja por nombre (A-Z, sin distinguir mayusculas)
                        i <- 1
                        hubo <- Verdadero
                        Mientras i <= c - 1 Y hubo Hacer
                            hubo <- Falso
                            Para j <- 1 Hasta c - i Con Paso 1
                                Si Minusculas(nom[j]) > Minusculas(nom[j+1]) Entonces
                                    aux <- nom[j]
                                    nom[j] <- nom[j+1]
                                    nom[j+1] <- aux
                                    Para k <- 1 Hasta 6 Con Paso 1
                                        sVal <- inv[j,k]
                                        inv[j,k] <- inv[j+1,k]
                                        inv[j+1,k] <- sVal
                                    FinPara
                                    hubo <- Verdadero
                                FinSi
                            FinPara
                            i <- i + 1
                        FinMientras

                        Escribir "Producto registrado correctamente."
                    FinSi
                FinSi

            2:
                // ---------- Consultar productos ----------
                Si c = 0 Entonces
                    Escribir "No hay productos registrados."
                SiNo
                    Para i <- 1 Hasta c Con Paso 1
                        Escribir ""
                        Escribir "Producto: ", nom[i]
                        Para j <- 1 Hasta 6 Con Paso 1
                            Si inv[i,j] < sMin Entonces
                                Escribir "  Talla ", tallas[j], ": ", inv[i,j], " *** ALERTA: STOCK BAJO ***"
                            SiNo
                                Escribir "  Talla ", tallas[j], ": ", inv[i,j]
                            FinSi
                        FinPara
                    FinPara
                FinSi

            3:
                // ---------- Actualizar stock por talla ----------
                Escribir "Nombre del producto a actualizar: "
                Leer nB
                idx <- 0
                Para i <- 1 Hasta c Con Paso 1
                    Si Minusculas(nom[i]) = Minusculas(nB) Entonces
                        idx <- i
                    FinSi
                FinPara

                Si idx = 0 Entonces
                    Escribir "Producto no encontrado."
                SiNo
                    Escribir "Tallas disponibles: 34, 35, 36, 37, 38, 39"
                    ok <- Falso
                    Repetir
                        Escribir "Talla a actualizar: "
                        Leer txt
                        Si esNum(txt) Entonces
                            t <- ConvertirANumero(txt)
                            Si t >= 34 Y t <= 39 Entonces
                                ok <- Verdadero
                            SiNo
                                Escribir "Talla invalida. Seleccione una talla de la lista."
                            FinSi
                        SiNo
                            Escribir "Invalido. Ingrese nuevamente la talla."
                        FinSi
                    Hasta Que ok

                    Escribir "Nuevo stock: "
                    ok <- Falso
                    Repetir
                        Leer txt
                        Si esNum(txt) Entonces
                            sVal <- ConvertirANumero(txt)
                            ok <- Verdadero
                        SiNo
                            Escribir "Invalido. Ingrese nuevamente el stock."
                        FinSi
                    Hasta Que ok

                    pos <- t - 33
                    inv[idx, pos] <- sVal
                    Escribir "Stock actualizado correctamente."
                FinSi

            4:
                Escribir "Saliendo..."
        FinSegun

    Hasta Que op = 4

FinAlgoritmo
