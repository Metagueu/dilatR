# Inverse d'une matrice de dilatation

Renvoie \\D^{-1} = \mathrm{diag}(1/s_1, \ldots, 1/s_n)\\ : la
contraction qui ramène à la forme initiale, avec \\D\\D^{-1} = I_n\\.

## Usage

``` r
dilat_inverse(D)
```

## Arguments

- D:

  Matrice de dilatation.

## Value

La matrice inverse (une matrice de dilatation).

## Examples

``` r
dilat_inverse(dilat_matrice(c(2, 4)))
#>      [,1] [,2]
#> [1,]  0.5 0.00
#> [2,]  0.0 0.25
```
