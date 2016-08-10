#!/usr/bin/env dub
/+ dub.sdl:
name "example_expo_hist"
dependency "matplotd" path=".."
+/

/**
Using the inverse function rocks
*/
S sample(S, RNG, FInv)(ref RNG gen, FInv finv)
{
    import std.random : uniform;
    S u = uniform!("[)", S)(0, 1);
    return finv(u);
}

void main(string[] args)
{
    import std.random : Mt19937;
    import std.math : exp, log;

    auto gen = Mt19937(42);
    alias S = double;
    auto finv = (S x) => -log(S(1) - x);

    S[] samples = new S[10_000];
    foreach(i; 0..samples.length)
        samples[i] = sample!S(gen, finv);

    string plotDir = "plots";
    import std.file : exists, mkdir;
    if (!plotDir.exists)
        plotDir.mkdir;

    import matplotd.hist;
    auto pdf = (S x) => exp(-x);
    HistogramConfig hc = {histType: "step"};
    hc.color = "red";
    histogram(pdf, samples, "plots/expo.pdf", hc);
    hc.cumulative = true;
    histogram(pdf, samples, "plots/expo_cum.pdf", hc);
}
