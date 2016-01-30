//: # Interpolation Playground
//:
//: Based on [http://sol.gfxile.net/interpolation/index.html](http://sol.gfxile.net/interpolation/index.html)
//:
//: Simon Gladman / January 2016


import UIKit

func loop( interpolationFunction: (Double) -> Double )
{
    let n = 25
    let start = 0.0
    let end = 1.0
    
    for i in 0 ..< n
    {
        let v = Double(i) / Double(n)
        
        let interpolatedV = interpolationFunction(v)
        
        let interpolatedValue = (start * interpolatedV) + (end * (1 - interpolatedV))
    }
}

//: ## Linear Interpolation

loop { x in x }

//: ## Smoothstep

loop { x in ((x) * (x) * (3 - 2 * (x))) }

//: ## Smootherstep

loop { x in ((x) * (x) * (x) * ((x) * ((x) * 6 - 15) + 10)) }

//: ## Squared

loop { x in (x * x) }


//: ## Inverse Squared

loop { x in 1 - (1 - x) * (1 - x) }

//: ## Cubed

loop { x in (x * x * x) }

//: ## Sin

loop { x in sin(x * M_PI / 2) }

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




// end
