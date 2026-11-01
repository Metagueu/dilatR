# Construire une matrice de dilatation thermique

Construit \\D = \mathrm{diag}(1 + \alpha_i\\\Delta T)\\ à partir de la
loi de dilatation linéique \\L = L_0\\(1 + \alpha\\\Delta T)\\. Chaque
axe peut avoir son propre coefficient (matériaux anisotropes : bois,
composites).

## Usage

``` r
dilat_thermique(alpha, dT, dim = length(alpha))
```

## Arguments

- alpha:

  Coefficient(s) de dilatation linéique, en K^-1 : un par axe, ou un
  seul avec `dim`. Exemple : `12e-6` pour l'acier.

- dT:

  Écart de température en K, \\\Delta T = T - T\_{ref}\\.

- dim:

  Dimension de la matrice. Par défaut `length(alpha)`.

## Value

Une matrice carrée diagonale.

## See also

[`dilat_matrice`](https://metagueu.github.io/dilatR/reference/dilat_matrice.md),
[`dilat_joint`](https://metagueu.github.io/dilatR/reference/dilat_joint.md)

## Examples

``` r
dilat_thermique(12e-6, 50, dim = 3)          # acier, isotrope
#>        [,1]   [,2]   [,3]
#> [1,] 1.0006 0.0000 0.0000
#> [2,] 0.0000 1.0006 0.0000
#> [3,] 0.0000 0.0000 1.0006
dilat_thermique(c(5e-6, 35e-6, 35e-6), 40)   # bois, anisotrope
#>        [,1]   [,2]   [,3]
#> [1,] 1.0002 0.0000 0.0000
#> [2,] 0.0000 1.0014 0.0000
#> [3,] 0.0000 0.0000 1.0014
```
