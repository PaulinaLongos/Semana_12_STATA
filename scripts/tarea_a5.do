* ============================================================
* A5 — Limpieza y descriptivos de CASEN
* Autor: Paulina Longos Ulloa      Fecha: 2026-11-17
* ============================================================
* 1. Encabezado y bitácora
* ============================================================
version 14
clear all
set more off
pwd
// cd"C:\Users\TEST\Documents\FUNDAMENTOS-PROGRAMACION\Semana_12_STATA"
capture mkdir "output"
capture log close
log using "output/tarea_a5.log", replace text
* ============================================================
* 2. Carga los datos
* ============================================================
import delimited "data/raw/casen_reducido.csv", clear varnames(1) encoding("utf-8") // encoding("utf-8")` hace que «Construcción» y «Ñuble» se lean bien (S12S1)
describe   // Se ven 60 obs y 6 var (region, sector, educ, edad, ingreso, genero)
summarize  // region, sector y genero aparecen con 0 obs
* ============================================================
* 3. Crea variables con `generate` y `replace`
* ============================================================
generate experiencia = max(edad - educ - 6, 0)
generate mujer = (genero == "F")
generate alta_educ = 0
replace alta_educ = 1 if educ >= 13 & !missing(educ)
* ------------------------------------------------------------
* 4. Etiquetas
* ------------------------------------------------------------
label variable experiencia "Experiencia potencial (años)"
label variable mujer "Mujer"
label variable alta_educ "Educación alta (13+ años)"
label define mujer_lbl 0 "Hombre" 1 "Mujer"
label values mujer mujer_lbl
label define alta_lbl 0 "12 años o menos" 1 "13+ años"
label values alta_educ alta_lbl

tabulate mujer
tabulate alta_educ
* ------------------------------------------------------------
* 5. Cuidado con los missing
* ------------------------------------------------------------
count if missing(ingreso)
count if ingreso > 500000
count if ingreso > 500000 & !missing(ingreso)
summarize ingreso
* ¿Por qué summarize ingreso no se equivoca con los missing, pero count if ingreso > 500000 sí puede equivocarse?
* El missing se guarda como un número mayor que cualquier otro, summarize ingreso lo deja fuera y calcula solo con las 55 personas que tienen dato obs = 55, en cambio count if ingreso > 500000 cuenta los missing como si fueran ingresos altos da 46 y 5 de ellos no tienen dato, hay que agregar & !missing(ingreso) así el resultado correcto es 41.
* ------------------------------------------------------------
* 6. Descriptivos
* ------------------------------------------------------------
summarize ingreso educ edad experiencia
tabulate sector
tabulate sector alta_educ, row
correlate ingreso educ experiencia

summarize ingreso if mujer == 1
scalar media_mujer = r(mean)
summarize ingreso if mujer == 0
scalar media_hombre = r(mean)
display "Brecha de ingreso medio (hombres - mujeres): " %9.0fc media_hombre - media_mujer
* ------------------------------------------------------------
* 7. Cierre
* ------------------------------------------------------------
log close
* De las 60 personas, 55 tienen ingreso y el promedio es $655.291, con una desviación estándar de $209.912. 
* Más años de educación se asocian con mayor ingreso (tiene una correlación de 0,68) y  la experiencia potencial casi no se asocia (-0,09). 
* Los hombres tienen un ingreso medio de $673.607 y las mujeres de $636.296 (diferencia de $37.311),
* con 27 y 28 personas esta brecha es solo descriptiva y no permite hablar de causas.