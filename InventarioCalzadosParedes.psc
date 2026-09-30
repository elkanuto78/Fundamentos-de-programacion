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
    Definir op, i, j, c, sMin, t, sVal Como Entero
    Definir nom Como Caracter
    Definir inv Como Entero
    Definir nB Como Caracter
    Definir enc Como Logico
    Definir idx Como Entero
    Definir txt Como Caracter
    Definir ok Como Logico

    Dimension nom[100]
    Dimension inv[100,6]

    c <- 0
    sMin <- 5

    Repetir
        Escribir ""
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
                    Escribir "Invalido, volver a dar opcion: "
                FinSi
            SiNo
                Escribir "Invalido, volver a dar opcion: "
            FinSi
        Hasta Que ok

        Según op Hacer
            1:
                Escribir "Nombre del producto: "
                Leer nB
                enc <- Falso
                Para i <- 1 Hasta c Con Paso 1
                    Si nom[i] = nB Entonces
                        enc <- Verdadero
                    FinSi
                FinPara
                Si enc Entonces
                    Escribir "Ese producto ya existe. Use la opcion Actualizar stock."
                SiNo
                    c <- c + 1
                    nom[c] <- nB
                    Para j <- 1 Hasta 6 Con Paso 1
                        Escribir "Stock talla ", 33 + j, ": "
                        ok <- Falso
                        Repetir
                            Leer txt
                            Si esNum(txt) Entonces
                                inv[c,j] <- ConvertirANumero(txt)
                                ok <- Verdadero
                            SiNo
                                Escribir "Invalido, volver a dar stock: "
                            FinSi
                        Hasta Que ok
                    FinPara
                    Escribir "Producto registrado."
                FinSi

            2:
                Si c = 0 Entonces
                    Escribir "No hay productos registrados."
                SiNo
                    Para i <- 1 Hasta c Con Paso 1
                        Escribir "Producto: ", nom[i]
                        Para j <- 1 Hasta 6 Con Paso 1
                            Si inv[i,j] < sMin Entonces
                                Escribir "  Talla ", 33 + j, ": ", inv[i,j], " *** ALERTA: STOCK BAJO ***"
                            SiNo
                                Escribir "  Talla ", 33 + j, ": ", inv[i,j]
                            FinSi
                        FinPara
                    FinPara
                FinSi

            3:
                Escribir "Nombre del producto a actualizar: "
                Leer nB
                enc <- Falso
                idx <- 0
                Para i <- 1 Hasta c Con Paso 1
                    Si nom[i] = nB Entonces
                        idx <- i
                        enc <- Verdadero
                    FinSi
                FinPara
                Si NO enc Entonces
                    Escribir "Producto no encontrado."
                SiNo
                    Escribir "Talla a actualizar (34-39): "
                    ok <- Falso
                    Repetir
                        Leer txt
                        Si esNum(txt) Entonces
                            t <- ConvertirANumero(txt)
                            Si t >= 34 Y t <= 39 Entonces
                                ok <- Verdadero
                            SiNo
                                Escribir "Invalido, volver a dar talla: "
                            FinSi
                        SiNo
                            Escribir "Invalido, volver a dar talla: "
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
                            Escribir "Invalido, volver a dar stock: "
                        FinSi
                    Hasta Que ok
                    inv[idx, t - 33] <- sVal
                    Escribir "Stock actualizado."
                FinSi

            4:
                Escribir "Saliendo..."
        FinSegun

    Hasta Que op = 4

FinAlgoritmo
