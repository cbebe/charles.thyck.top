type t = Fluctuating | LargeSpike | Decreasing | SmallSpike | Unsure

let fromInt = (i: int) =>
  switch i {
  | 0 => Fluctuating
  | 1 => LargeSpike
  | 2 => Decreasing
  | 3 => SmallSpike
  | _ => Unsure
  }

let toString = (i: t) =>
  switch i {
  | Fluctuating => "Fluctuating"
  | LargeSpike => "Large spike"
  | Decreasing => "Decreasing"
  | SmallSpike => "Small spike"
  | Unsure => "" // Impossible
  }

let toShortString = (i: t) =>
  switch i {
  | Fluctuating => "Fluc"
  | LargeSpike => "LaSp"
  | Decreasing => "Decr"
  | SmallSpike => "SmSp"
  | Unsure => "" // Impossible
  }
