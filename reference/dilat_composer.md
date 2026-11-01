# Composer plusieurs dilatations

Calcule le produit de plusieurs matrices de dilatation. Pour deux
matrices de facteurs \\s_i\\ et \\t_i\\ : \\D_1 D_2 = \mathrm{diag}(s_1
t_1, \ldots, s_n t_n) = D_2 D_1\\. L'ordre est donc sans importance.

## Usage

``` r
dilat_composer(...)
```

## Arguments

- ...:

  Au moins deux matrices de dilatation de même dimension.

## Value

Leur produit (une matrice de dilatation).

## Examples

``` r
dilat_composer(dilat_matrice(c(2, 3)), dilat_matrice(c(4, 0.5)))
#>      [,1] [,2]
#> [1,]    8  0.0
#> [2,]    0  1.5
```
