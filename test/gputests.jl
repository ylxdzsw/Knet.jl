using Knet, Base.Test

# Uncomment these if you want lots of messages:
# import Base.Test: default_handler, Success, Failure, Error
# default_handler(r::Success) = info("$(r.expr)")
# default_handler(r::Failure) = warn("FAIL: $(r.expr)")
# default_handler(r::Error)   = warn("$(r.err): $(r.expr)")

load_only = true
isapprox3(a,b,c)=all(map((x,y,z)->isapprox(x,y;rtol=z), a,b,c))

include(Pkg.dir("Knet/examples/linreg.jl"))
#@test LinReg.main("") == (0.0005497846637255735,32.77257400591496,0.11265426200775067) #v0.7.2: old Xavier
@test LinReg.main("") == (0.0005497354349066443,32.772564704299114,0.11249865587133624) #v0.7.3: new Xavier

include(Pkg.dir("Knet/examples/mnist2d.jl"))
@test MNIST2D.main("--epochs 1") == (0.3204898f0,32.93997f0,4.614684f0)
@test MNIST2D.main("--epochs 1 --ysparse") == (0.3204898f0,32.93997f0,4.614684f0)
@test isapprox3(MNIST2D.main("--epochs 1 --xsparse"), (0.3204898f0,32.93997f0,4.614684f0), (0.0001,0.0001,0.0001))
@test isapprox3(MNIST2D.main("--epochs 1 --xsparse --ysparse"), (0.3204898f0,32.93997f0,4.614684f0), (0.0001,0.0001,0.0001))

include(Pkg.dir("Knet/examples/mnist4d.jl"))
#@test isapprox3(MNIST4D.main("--epochs 1"), (0.205204,65.8837,114.961), (0.02,0.001,0.2)) #v0.7.2
@test  isapprox3(MNIST4D.main("--epochs 1"), (0.2867,29.243,12.6239), (0.005,0.0005,0.05)) #v0.7.3: New Xavier


include(Pkg.dir("Knet/examples/adding.jl"))
@test Adding.main("--epochs 1") == (0.22713459f0,3.3565507f0,5.3267756f0)
@test Adding.main("--epochs 1 --nettype lstm") == (0.24768005f0,3.601481f0,1.2290705f0)

seqdata = Pkg.dir("Knet/data/seqdata.txt")

include(Pkg.dir("Knet/examples/rnnlm.jl"))
@test RNNLM.main("--max_max_epoch 1 --dense $seqdata") == (30.65637197763184,110.81809997558594,29.36899185180664)

include(Pkg.dir("Knet/examples/copyseq.jl"))
#@test CopySeq.main("--epochs 1 --dense $seqdata") == (40.00286169097269,30.352935791015625,1.646486520767212) #v0.7.2: old Xavier
@test  CopySeq.main("--epochs 1 --dense $seqdata") == (40.00124900530586,22.967731475830078,0.7200922966003418) #v0.7.3: new Xavier

### DEAD CODE:
# using Compat
# using Knet
# @date include("testdense.jl")
# @date include("testsparse.jl")
# @date include("testconvert.jl")
# @date include("testlinalg.jl")
# @date include("testcolops.jl")
# @date include("testmnist.jl")
# @date include("testlayers.jl")
# @date include("testperceptron.jl")
# @date include("testkperceptron.jl")
# # @date include("tutorial.jl")
