//: # Interpolation Playground
//:
//: Based on [http://sol.gfxile.net/interpolation/index.html](http://sol.gfxile.net/interpolation/index.html)
//:
//: Simon Gladman / January 2016


import UIKit

func loop( interpolationFunction: Double -> Double )
{
    let n = 100

    for i in 0 ..< n
    {
        let v = Double(i) / Double(n)
        
        let _ = interpolationFunction(v)
    }
}

//: ## Linear Interpolation

loop { x in x }

//: ## Smoothstep

loop { x in (x * x * (3 - 2 * x)) }

//: ## Smootherstep

loop { x in (x * x * x * (x * (x * 6 - 15) + 10)) }

//: ## Kyle McDonald Smootherstep
//: Taken from [https://twitter.com/kcimc/status/580738643347804160](https://twitter.com/kcimc/status/580738643347804160)

func smoothestStep(t: Double) -> Double
{
    var x = -20 * pow(t, 7)
    
    x += 70 * pow(t, 6)
    x -= 84 * pow(t, 5)
    x += 35 * pow(t, 4)
    
    return x
}

loop { t in smoothestStep(t) }

//: ## Squared

loop { x in (x * x) }


//: ## Inverse Squared

loop { x in 1 - (1 - x) * (1 - x) }

//: ## Cubed

loop { x in (x * x * x) }

//: ## Sin

loop { x in sin(x * M_PI_2) }

//: ## Catmull-Rom

func catmullRom(t: Double, _ p0: Double, _ p1: Double, _ p2: Double, _ p3: Double) -> Double
{
    return 0.5 * (
        (2 * p1) +
        (-p0 + p2) * t +
        (2 * p0 - 5 * p1 + 4 * p2 - p3) * t * t +
        (-p0 + 3 * p1 - 3 * p2 + p3) * t * t * t
    )
}

let q = -15.0
let t = 7.5

loop { x in catmullRom(x, q, 0.0, 1.0, t) }

//: ## Elastic In

func elasticIn(x: Double, p: Double = 0.2) -> Double
{
    return pow(2, 10 * (x - 1)) * sin((x - p/4) * (2 * M_PI) / p) + 1
}

loop { x in elasticIn(x) }

//: ## Elastic Out
//: Taken from [http://www.joshondesign.com/2013/03/01/improvedEasingEquations](http://www.joshondesign.com/2013/03/01/improvedEasingEquations)

func elasticOut(x: Double, p: Double = 0.2) -> Double
{
    return pow(2, -10 * x) * sin((x - p/4) * (2 * M_PI) / p) + 1
}

loop { x in elasticOut(x) }

//: ## Wobble

        func wobble(x: Double, wobbleCount: Double, wobbleHeight: Double) -> Double
        {
            let wobbleHeight = sin(M_PI * x) * wobbleHeight
            let wobbleOffset = sin(M_PI * wobbleCount * x) * wobbleHeight
            
            return x + wobbleOffset
        }

        loop { x in wobble(x, wobbleCount: 30, wobbleHeight: 0.25) }

// end
