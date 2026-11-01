# Résumé des propriétés d'une matrice de dilatation

Calcule le facteur de volume \\\det D = \prod s_i\\ (facteur d'aire en
2D), les valeurs propres, et le rapport d'anisotropie \\\kappa =
s\_{max}/s\_{min}\\.

## Usage

``` r
dilat_resume(D, tol = 1e-10)
```

## Arguments

- D:

  Matrice de dilatation.

- tol:

  Tolérance relative pour décider si `D` est isotrope.

## Value

Une liste nommée :

- `facteurs` : les facteurs \\s_i\\ ;

- `det` : le facteur de volume (ou d'aire) ;

- `variation_pct` : la variation de volume, en pour cent ;

- `valeurs_propres` : les valeurs propres de `D` ;

- `anisotropie` : le rapport facteur max / facteur min ;

- `isotrope` : `TRUE` si tous les facteurs sont égaux (à la tolérance
  près).

## Examples

``` r
dilat_resume(dilat_matrice(c(3, 0.5)))
#> $facteurs
#> [1] 3.0 0.5
#> 
#> $det
#> [1] 1.5
#> 
#> $variation_pct
#> [1] 50
#> 
#> $valeurs_propres
#> [1] 3.0 0.5
#> 
#> $anisotropie
#> [1] 6
#> 
#> $isotrope
#> [1] FALSE
#> 
```
