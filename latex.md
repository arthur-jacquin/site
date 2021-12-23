# LaTeX

## Sommaire

[TOC]

## Présentation

Le LaTeX est un langage de balisage léger très utilisé dans les domaines scientifiques. Ses commandes permettent de structurer les documents (rapports, thèses, livres, articles, publications, lettres...) et d'écrire des formules mathématiques.

Les avantages du LaTeX sont nombreux :

- très largement utilisé dans le monde scientifique : cela légitimise son apprentissage pour les élèves se destinant à des métiers en relation avec les sciences, et assure la présence de documentation développées et un entretien du LaTeX pour de nombreuses années ;
- langage gratuit et *open-source* ;
- facilement lisible par un être humain même sans rendu graphique : les commandes sont explicites quant à leur sens et sont d'autant plus courtes que leur utilisation est fréquente ;
- permet de séparer le contenu de sa mise en forme (qui est automatique) : plus besoin de s'occuper du rendu graphique, écrit le contenu une fois et choisit et change de style ensuite ;
- peut être étendu grâce à des paquets tiers (bibliothèques de commandes supplémentaires).

Pour une description plus complète, je vous invite à aller consulter la [page Wikipédia associée](https://fr.wikipedia.org/wiki/LaTeX).

## Intégration des formules mathématiques

Une formule mathématique peut être intégrée de deux façons différentes dans un document :

- Intégrée à un paragraphe : elle doit alors être délimitée par des symboles dollars `$` uniques.

- Constituant un paragraphe : elle doit alors être délimitée par des symboles dollars `$` doubles.

Le rendu graphique peut être affecté par le choix de l'intégration de la formule. Par exemple, la formule de la somme des entiers naturels jusqu'à $n$ ressemble à $\sum_{i=0}^{n}{i} = \frac{n(n+1)}{2}$ lorsqu'elle est intégrée dans un paragraphe, tandis que dans un paragraphe séparé :

$$
\sum_{i=0}^{n}{i} = \frac{n(n+1)}{2}
$$

## Structure d'une commande

Dans la plupart des cas, les commandes sont précédées par l'antislash (`\`), et suivies (selon la commande) d'un ou plusieurs arguments encadrés par des accolades (`{}`). Une commande type est alors : `\commande{argument-1}{argument-2}`.

Les inscriptions en indice et en exposant, très fréquentes, dérogent à ce système :

- Un indice est précédé d'un *underscore* : `u_0` donne $u_0$. Si l'indice comporte plusieurs caractères, il faut le délimiter par des accolades : `x_{AB}` donne $x_{AB}$.
- Un exposant est précédé d'un accent circonflexe : `a^2` donne $a^2$. Si l'exposant comporte plusieurs caractères, il faut de même le délimiter par des accolades.

## Commandes usuelles pour un lycéen

### Saut de ligne

Un saut de ligne est créé par la commande `\\`.

### Symboles mathématiques

- $\leq$ : `\leq`

- $\geq$ : `\geq`

- $\neq$ : `\neq`

- $\simeq$ : `\simeq` (en physique uniquement)

- $\times$ : `\times`

- $\cdot$ : `\cdot` (produit scalaire)

- $\infty$ : `\infty`

- $\neg$ : `\neg`

- $\wedge$ : `\wedge`

- $\vee$ : `\vee`

- $\cup$ : `\cup`

- $\cap$ : `\cap`

- $\in$ : `\in`

- $\notin$ : `\notin`

- $\subset$ : `\subset`

- $\forall$ : `\forall`

- $\exists$ : `\exists`

- $\Rightarrow$ : `\Rightarrow` (implication)

- $\Leftrightarrow$ : `\Leftrightarrow` (équivalence)

- $\|$ : `\|` (normes de vecteurs)

### Lettres grecques

Les commandes pour les lettres grecques sont éponymes :

- $\pi$ : `\pi`

- $\alpha$ : `\alpha`

- ...

Les lettres ayant une représentation différente en fonction de la capitalisation sont aussi prises en compte : $\delta$ (`\delta`) diffère ainsi de $\Delta$ (`\Delta`).

### Ensembles de nombres

Les ensembles de nombres sont désignés par des majuscules stylisées. En LaTeX, il suffit de faire précéder la majuscule de l'antislash :

- $\N$ : `\N`

- $\Z$ : `\Z`

- $\Q$ : `\Q`

- $\R$ : `\R`

- $\C$ : `\C`

Seul l'ensemble des décimaux manque à l'appel.

### Structures

| Elément  |  Commande   |    Exemple    | Rendu |
| :------: | :---------: | :-----------: | :---: |
| Fraction | `\frac{}{}` | `\frac{1}{2}` | $\frac{1}{2}$ |
| Racine | `\sqrt{}` | `\sqrt{2}` | $\sqrt{2}$ |
| Somme | `\sum_{}^{}{}` | `\sum_{i = 0}^{n}{i}` | $\sum_{i = 0}^{n}{i}$ |
| Vecteur | `\vec{}` | `\vec{AB}` | $\vec{AB}$ |

### Parenthèses dynamiques

Le parenthésage peut être dynamique (pour encadrer des éléments hauts) en précédant les symboles de `\left` puis `\right`. `F = G \left( \frac{m_1 m_2}{r^2} \right)` donne ainsi :

$$
F = G \left( \frac{m_1 m_2}{r^2} \right)
$$

### Environnements

Les environnements étendent les possibilités du LaTeX. Ils sont ouverts et fermés par les commandes respectives `\begin{}` et `\end{}`, où le nom de l'environnement utilisé est à placer dans les accolades. La majorité des environnements peuvent s'emboîter.

Un environnement très pratique est l'environnement `cases`. Les lignes intégrées dans cet environnement formeront un système d'équation :

```latex
\begin{cases}
x = 2 \\
y = 3
\end{cases}
```

$$
\begin{cases}
x = 2 \\
y = 3
\end{cases}
$$

Pour aligner les formules, vous pouvez utiliser l'environnement `align`. Les signes `=` seront alors alignés, mais l'alignement peut-être défini par l'utilisateur avec le symbole `&`.

```latex
\begin{align}
x = 2 \\
\Rightarrow x^2 = 4
\end{align}
```

$$
\begin{align}
x = 2 \\
\Rightarrow x^2 = 4
\end{align}
$$

```latex
\begin{align}
& x = 2 \\
\Rightarrow \; & x^2 = 4 \\
\Rightarrow \; & x^2 + 5 = 9
\end{align}
```

$$
\begin{align}
& x = 2 \\
\Rightarrow \; & x^2 = 4 \\
\Rightarrow \; & x^2 + 5 = 9
\end{align}
$$

### Tableaux de signes et de variation

TikZ est un paquet tiers pour la modélisation d'éléments mathématiques graphiques. En tant que paquet tiers, son utilisation est assez complexe, mais c'est un outil incomparable pour générer les tableaux de signes et de variation et ce serait dommage de ne pas l'utiliser. Pour générer un tableau, vous devez suivre les étapes suivantes :

1. Se rendre sur [QuickLaTeX](https://www.quicklatex.com/)
2. Cliquer sur `Choose Options`
3. Ajouter `\usepackage{tikz,tkz-tab}` dans l'encadré "Custom LaTeX Document Preamble"
4. Inscrire le LaTeX souhaité dans l'encadré "Type LaTeX Code"
5. Générer l'image avec le bouton `Render!`

L'environnement utilisé pour ces tableaux est `tikzpicture`. Un tutoriel sur cet environnement est déjà disponible [ici](https://zestedesavoir.com/tutoriels/439/des-tableaux-de-variations-et-de-signes-avec-latex/), donc il ne sera pas décrit ici.

## Utilisation

L'utilisation du LaTeX peut se faire :

- Dans Google Docs, dans l'outil d'équation, pour les commandes linéaires (donc pas d'environnements, pas de sauts de lignes, ...).
- Dans Google Docs, avec le module complémentaire [AutoLaTeX](https://sites.google.com/site/autolatexequations/), outil pratique mais pas très intuitif et assez limité (ne supporte pas les paquets tiers, assez lent).
- Avec n'importe quel logiciel de traitement de texte et le générateur en ligne [QuickLaTeX](https://www.quicklatex.com/).
- Avec le logiciel de traitement de texte [Typora](https://www.typora.io/), qui est fantastique (support du Markdown et du LaTeX, personnalisation totale de l'interface en CSS) mais n'est pas destiné à un usager occasionnel qui cherche simplement à générer du LaTeX.

## Pour aller plus loin

Ce tutoriel est hautement incomplet, car ce n'est qu'une initiation au LaTeX. Si vous avez besoin de modéliser une formule plus complexe, n'hésitez pas à :

- aller voir une [documentation en ligne](https://www.rpi.edu/dept/arc/training/latex/LaTeX_symbols.pdf) très complète ;
- chercher des solutions sur des forums (communauté très large) ;
- demander de l'aide à un camarade ou à votre professeur de mathématiques.