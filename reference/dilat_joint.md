# Dimensionner un joint de dilatation de pont

Calcule le mouvement de l'extrémité mobile d'un tablier de longueur
\\L_0\\ et la capacité de joint à prévoir. Seul le facteur de dilatation
selon l'axe du tablier (axe x) est utilisé, via
[`dilat_thermique`](https://metagueu.github.io/dilatR/reference/dilat_thermique.md).
\$\$C = L_0\\\alpha\\(T\_{max} - T\_{min})\$\$ \$\$C\_{joint} = C\\(1 +
m)\$\$

## Usage

``` r
dilat_joint(L0, alpha, T_min, T_max, T_ref = 20, marge = 0.2)
```

## Arguments

- L0:

  Longueur dilatable du tablier, en m (de l'appui fixe au joint).

- alpha:

  Coefficient de dilatation linéique, en K^-1 (strictement positif).

- T_min, T_max:

  Températures extrêmes de calcul, en degrés Celsius.

- T_ref:

  Température de référence (température à la pose), en degrés Celsius.

- marge:

  Marge de sécurité \\m\\, en fraction de la course (0,2 pour 20 pour
  cent).

## Value

Une liste : `allongement_mm`, `raccourcissement_mm`, `course_mm` et
`capacite_mm`.

## Examples

``` r
dilat_joint(L0 = 100, alpha = 12e-6, T_min = -10, T_max = 40, T_ref = 10)
#> $allongement_mm
#> [1] 36
#> 
#> $raccourcissement_mm
#> [1] -24
#> 
#> $course_mm
#> [1] 60
#> 
#> $capacite_mm
#> [1] 72
#> 
```
