# A5 —  Do-file de limpieza y descriptivos en Stata
## Objetivo

Escribir un do-file que **corra de principio a fin sin intervención** y produzca
un `.log` con la limpieza y los descriptivos de la CASEN — trasladando a Stata lo
que ya sabes hacer en R.

## Datos
- casen_reducido.csv en data/raw/

## Cómo correrlo
1. Abrir Stata 18 y ubicar la carpeta del proyecto con `cd`.
2. Abrir `scripts/tarea_a5.do` en el Do-file Editor.
3. Ejecutarlo completo
4. Revisar `output/tarea_a5.log`, que se genera solo con todos los resultados.
5. La interpretación de los descriptivos está en los comentarios al final del archivo.

## Estructura
```
Semana_12_STATA/
├── data/
│   ├── raw/
│   │   └── casen_reducido.csv
│   └── processed/
├── scripts/
│   └── tarea_a5.do
├── output/
│   └── tarea_a5.log
└── README.md
```

## Autor
Paulina Longos Ulloa — 2026-11-17

## Declaración de autoría y uso de IA
- Herramienta utilizada: Claude 
- Para qué la usé: para redactar  las interpretaciones y verificar el cumplimiento de los requisitos de la actividad.
- Qué hice yo: desarrolle cada paso de la A5, verificando con claude y con los guiones de la semana 12.
- Verificación: confirmo que entiendo y puedo explicar todo lo que entrego.