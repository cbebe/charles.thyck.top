type t = (array<Predictor.prediction>, array<float>)
let showResults: t => unit
let parsePredictions: Predictor.t => t
let writeError: string => unit
