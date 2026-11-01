# Appliquer une matrice de dilatation à des points

Transforme des points \\\mathbf{x}\\ en \\\mathbf{x}' = D\\\mathbf{x}\\.
Les points sont rangés en lignes : pour une matrice \\X\\ (un point par
ligne), le résultat est \\X' = X\\D^{T}\\.

## Usage

``` r
dilat_appliquer(D, X)
```

## Arguments

- D:

  Matrice de dilatation (voir
  [`dilat_matrice`](https://metagueu.github.io/dilatR/reference/dilat_matrice.md)).

- X:

  Matrice m x n (un point par ligne), data.frame numérique, ou vecteur
  de longueur n (un seul point).

## Value

Les points transformés, avec la même forme que `X`.

## Examples

``` r
D <- dilat_matrice(c(3, 0.5))
dilat_appliquer(D, rbind(c(2, 4)))   # (6 ; 2)
#>      [,1] [,2]
#> [1,]    6    2
carre <- rbind(c(0, 0), c(1, 0), c(1, 1), c(0, 1))
dilat_appliquer(D, carre)            # rectangle 3 x 0,5
#>      [,1] [,2]
#> [1,]    0  0.0
#> [2,]    3  0.0
#> [3,]    3  0.5
#> [4,]    0  0.5
```
