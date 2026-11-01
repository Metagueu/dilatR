# Coefficients de dilatation thermique de matériaux courants

Huit matériaux, avec un coefficient de dilatation linéique par axe
(\\\alpha_x\\, \\\alpha_y\\, \\\alpha_z\\). Pour les matériaux
isotropes, les trois valeurs sont égales ; pour le bois et le composite
carbone/époxy, l'axe x est le sens des fibres.

## Usage

``` r
materiaux
```

## Format

Un `data.frame` de 8 lignes et 6 colonnes :

- materiau:

  Nom du matériau.

- famille:

  Famille : metal, mineral, bois ou composite.

- alpha_x:

  Coefficient de dilatation selon x, en K^-1.

- alpha_y:

  Coefficient de dilatation selon y, en K^-1.

- alpha_z:

  Coefficient de dilatation selon z, en K^-1.

- source:

  Origine de la valeur.

## Source

Valeurs indicatives (Eurocodes EN 1993-1-1 pour l'acier et EN 1992-1-1
pour le béton ; autres valeurs : ordres de grandeur, à remplacer par des
valeurs sourcées).

## Examples

``` r
head(materiaux)
#>                materiau famille alpha_x alpha_y alpha_z                 source
#> 1 Acier de construction   metal 1.2e-05 1.2e-05 1.2e-05            EN 1993-1-1
#> 2                 Beton mineral 1.0e-05 1.0e-05 1.0e-05            EN 1992-1-1
#> 3             Aluminium   metal 2.3e-05 2.3e-05 2.3e-05 a verifier (indicatif)
#> 4                Cuivre   metal 1.7e-05 1.7e-05 1.7e-05 a verifier (indicatif)
#> 5    Verre sodocalcique mineral 9.0e-06 9.0e-06 9.0e-06 a verifier (indicatif)
#> 6    Invar (Fe-Ni 36 %)   metal 1.2e-06 1.2e-06 1.2e-06 a verifier (indicatif)
dilat_thermique(unlist(materiaux[7, c("alpha_x", "alpha_y", "alpha_z")]), 40)
#>        [,1]   [,2]   [,3]
#> [1,] 1.0002 0.0000 0.0000
#> [2,] 0.0000 1.0014 0.0000
#> [3,] 0.0000 0.0000 1.0014
```
