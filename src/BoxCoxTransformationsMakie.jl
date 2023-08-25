module BoxCoxTransformationsMakie

using BoxCoxTransformations
using BoxCoxTransformations: log_likelihood
using Makie

export boxcox_plot!

function boxcox_plot!(ax::Axis,  # FIXME use Makie Recipes
    bc::BoxCoxTransformation;
    alpha=0.05,
    N=100,
    linewidth = 2,
    kwargs...
)
    interval = bc.details.initial_lower, bc.details.initial_upper
    lmbds = collect(LinRange(interval[1], interval[2], N))
    llf = [log_likelihood(bc, x) for x in lmbds]
    lines!(ax, lmbds, llf; linestyle = nothing, linewidth, kwargs...)

    ylim = extrema(llf)

    y = log_likelihood(bc)
    lines!(ax, [bc.λ, bc.λ], [ylim[1], y]; color = :black, linestyle = :dash)

    conf = confint(bc; alpha)
    y = log_likelihood(bc, conf[1])
    for c in conf
        lines!(ax, [c, c], [ylim[1], y]; color = :gray, linestyle = :dash)
    end
    hlines!(ax, y; color = :gray, linestyle = :dash)

    text!(interval[1], y+0.005*(ylim[2]-ylim[1]), text = _percent_str(alpha))
    return ax
end

function boxcox_plot!(fig::Figure, bc::BoxCoxTransformation; kwargs...)
    return boxcox_plot!(Axis(fig[1,1]), bc; kwargs...)
end


## helper

function _percent_str(alpha::Real)
    p = round(Int, (1-alpha) * 100)
    if p == 100
        p = round((1-alpha) * 100, digits=1)
    end
    string(p)*"%"
end

end;
