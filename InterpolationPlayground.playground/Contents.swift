//: # Interpolation Playground
//:
//: Based on [Jari Komppa's blog post](http://sol.gfxile.net/interpolation/index.html).
//:
//: Simon Gladman / November 2019
import Cocoa
//: The base of all following examples is a function that divides the range [0,1] in `n` sections (e.g. 100).
@discardableResult
func loop(n: Int = 100, _ interpolationFunction: (Double)->Double) -> [Double] {
    return (0..<n).map {
        let v = Double($0) / Double(n)
        return interpolationFunction(v)
    }
}
//: ## Linear Interpolation
loop { (x: Double) in
    return x
}
//: ## Smoothstep
loop { (x: Double) in
    return x * x * (3 - 2*x)
}
//: ## Smootherstep
loop { (x: Double) in
    return x * x * x * (x * (6*x - 15) + 10)
}
//: ## Kyle McDonald `smoothestStep()`
//: Published as a [tweet](https://twitter.com/kcimc/status/580738643347804160).
loop { (x: Double) in
    return -20 * pow(x, 7) + 70 * pow(x, 6) - 84 * pow(x, 5) + 35 * pow(x, 4)
}
//: ## Squared
loop { (x: Double) in
    return x * x
}
//: ## Inverse Squared
loop { (x: Double) in
    return 1 - (1 - x) * (1 - x)
}
//: ## Cubed
loop { (x: Double) in
    return x * x * x
}
//: ## Sin
let 𝝉 = 2 * Double.pi
loop { (x: Double) in
    return sin(x * 𝝉/4)
}
//: ## Catmull-Rom
func catmullRom(_ x: Double, _ p0: Double, _ p1: Double, _ p2: Double, _ p3: Double) -> Double {
    return 0.5 * ((2 * p1) +
                  (-p0 + p2) * x +
                  (2 * p0 - 5 * p1 + 4 * p2 - p3) * x * x +
                  (-p0 + 3 * p1 - 3 * p2 + p3) * x * x * x)
}

let q = -15.0, t = 7.5
loop { (x: Double) in
    catmullRom(x, q, 0.0, 1.0, t)
}
//: ## Elastic In
loop { (x: Double) in
    let p = 0.2
    return pow(2, 10 * (x - 1)) * sin((x - p/4) * (𝝉) / p) + 1
}
//
//: ## Elastic Out
//: Taken from [Josh on design](http://www.joshondesign.com/2013/03/01/improvedEasingEquations).
loop { (x: Double) in
    let p = 0.2
    return pow(2, -10 * x) * sin((x - p/4) * (𝝉) / p) + 1
}
//: ## Wobble
func wobble(_ x: Double, count: Double, height: Double) -> Double {
    let wobbleHeight = sin(𝝉/2 * x) * height
    let wobbleOffset = sin(𝝉/2 * count * x) * wobbleHeight
    return x + wobbleOffset
}

loop { (x: Double) in
    return wobble(x, count: 30, height: 0.25)
}
//: ## Gaussian
func gaussian(_ x: Double, sigma: Double) -> Double {
    func 𝛗(_ x: Double, σ: Double) -> Double {
        let σ² = σ * σ
        return (1.0 / sqrt(𝝉 * σ²)) * pow(M_E, -pow(x, 2) / (2 * σ²))
    }

    let max = 𝛗(0.0, σ: sigma)
    return (max - 𝛗(x, σ: sigma)) / max
}

loop { (x: Double) in
    gaussian(x, sigma: 0.05)
}

loop { (x: Double) in
    gaussian(x, sigma: 0.15)
}

loop { (x: Double) in
    gaussian(x, sigma: 0.25)
}
// end
