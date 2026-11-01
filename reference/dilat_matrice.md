# Construire une matrice de dilatation

Construit la matrice diagonale \\D = \mathrm{diag}(s_1, \ldots, s_n)\\,
qui multiplie l'axe \\i\\ par le facteur \\s_i\\. Si un seul facteur est
donné, la dilatation est isotrope : \\D = s\\I_n\\.

## Usage

``` r
dilat_matrice(s, dim = length(s))
```

## Arguments

- s:

  Facteurs de dilatation, strictement positifs : un vecteur (un facteur
  par axe) ou un seul nombre (dilatation isotrope, avec `dim`).

- dim:

  Dimension de la matrice (2 pour le plan, 3 pour l'espace). Par défaut
  `length(s)`.

## Value

Une matrice carrée `dim` x `dim`, diagonale.

## See also

[`dilat_thermique`](https://metagueu.github.io/dilatR/reference/dilat_thermique.md)
pour construire la matrice à partir de coefficients de dilatation
thermique.

## Examples

``` r
dilat_matrice(2, dim = 2)   # isotrope : D = 2 I
#>      [,1] [,2]
#> [1,]    2    0
#> [2,]    0    2
dilat_matrice(c(3, 0.5))    # anisotrope
#>      [,1] [,2]
#> [1,]    3  0.0
#> [2,]    0  0.5
```
