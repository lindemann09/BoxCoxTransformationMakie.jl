# BoxCoxTransformationsMakie

[![Build Status](https://github.com/lindemann09/BoxCoxTransformationsMakie.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/lindemann09/BoxCoxTransformationsMakie.jl/actions/workflows/CI.yml?query=branch%3Amain)

Depends on [BoxCoxTransformations.jl](https://github.com/lindemann09/BoxCoxTransformations.jl)

```
using BoxCoxTransformations
using BoxCoxTransformationsMakie
using Distributions
using CairoMakie

x = rand(Gamma(2,2), 10000) .+ 1;
bc = fit(BoxCoxTransformation, x)

fig = Figure()
boxcox_plot!(fig, bc)
fig
```