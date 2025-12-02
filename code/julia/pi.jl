using Distributed
addprocs(parse(Int, ARGS[1]))

@everywhere function approximate_pi(trials::Int)
    hits = 0
    for i in 1:trials
        hits += (rand()^2 + rand()^2 < 1) ? 1 : 0
    end
    return hits
end

function main()
    total_trials = 500_000_000
    trials_per_worker = div(total_trials, nworkers())
    hits = pmap(w -> approximate_pi(trials_per_worker), workers())
    return 4 * sum(hits) / total_trials
end

println("Estimating π with $(nworkers()) workers...")
@time estimate = main()
println("π ≈ $estimate")

# 1 Worker: 2.045799 seconds
# 2 Workers: 1.654367 seconds
# 3 Workers: 1.504843 seconds
# 4 Workers: 1.520812 seconds
# 5 Workers: 1.458990 seconds
# 6 Workers: 1.699024 seconds
# 7 Workers: 1.840764 seconds
# 8 Workers: 2.489455 seconds
# 9 Workers: 2.258962 seconds
# 10 Workers: 2.228508 seconds
# 11 Workers: 2.138863 seconds
# 12 Workers: 2.226025 seconds
# 13 Workers: 2.581244 seconds
# 14 Workers: 2.688500 seconds
# 15 Workers: 3.071719 seconds
# 16 Workers: 3.693937 seconds
# 17 Workers: 3.750106 seconds
# 18 Workers: 3.839887 seconds
# 19 Workers: 4.528570 seconds
# 20 Workers: 4.422127 seconds
