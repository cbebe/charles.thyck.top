pub struct Uniform {
    a: f32,
    b: f32,
    prob: Vec<f32>,
}

pub trait IUniform {
    type T;
    fn new(a: Self::T, b: Self::T) -> Self;
    fn decay(&mut self, rate_decay_min: Self::T, rate_decay_max: Self::T);
    fn range_of(&self, i: usize) -> (Self::T, Self::T);
    fn a(&self) -> Self::T;
    fn b(&self) -> Self::T;
    fn range_limit(&mut self, range: (Self::T, Self::T)) -> Self::T;
    fn normalize(&mut self) -> Self::T;
    fn clamp_range(r: (Self::T, Self::T), i: usize) -> (Self::T, Self::T);
}

fn prefix_float_sum(input: &Vec<f32>) -> Vec<(f32, f32)> {
    let mut prefix_sum = vec![(0., 0.)];
    let mut sum = 0.;
    let mut c = 0.;
    for i in 0..input.len() {
        let cur = input[i];
        let t = sum + cur;
        if sum.abs() >= cur.abs() {
            c += (sum - t) + cur;
        } else {
            c += (cur - t) + sum;
        }
        sum = t;
        prefix_sum.push((sum, c));
    }

    return prefix_sum;
}

pub fn range_intersect(a: (f32, f32), b: (f32, f32)) -> Option<(f32, f32)> {
    (a.0 <= b.1 && a.1 >= b.0).then(|| (f32::max(a.0, b.0), f32::min(a.1, b.1)))
}

pub fn range_intersect_length(a: (f32, f32), b: (f32, f32)) -> f32 {
    range_intersect(a, b)
        .and_then(|r| Some(r.1 - r.0))
        .unwrap_or(0.)
}

impl IUniform for Uniform {
    type T = f32;

    fn clamp_range(r: (f32, f32), i: usize) -> (f32, f32) {
        (r.0 + i as f32, r.0 + (i + 1) as f32)
    }

    fn new(a: Self::T, b: Self::T) -> Self {
        if a >= b {
            panic!("a < b does not hold")
        }
        let range = (a, b);
        let total_length = b - a;
        let a = a.floor();
        let b = b.ceil();
        let start = a as usize;
        let end = b as usize;
        let mut prob = Vec::with_capacity(end - start);
        for i in 0..(end - start) {
            prob.push(range_intersect_length(Self::clamp_range(range, i), range) / total_length);
        }
        Self { a, b, prob }
    }

    fn decay(&mut self, rate_decay_min: f32, rate_decay_max: f32) {
        let rate_decay_min = rate_decay_min.round() as usize;
        let rate_decay_max = rate_decay_max.round() as usize;
        self.a = self.a - (rate_decay_max as f32);
        self.b = self.b - (rate_decay_min as f32);

        let prefix = prefix_float_sum(&self.prob);
        let max_x = self.prob.len();
        let max_y = (rate_decay_max - rate_decay_min) as usize;

        self.prob = (0..(max_x + max_y))
            .map(|i| {
                // Note that left and right here are INCLUSIVE.
                let left = i32::max(0, i as i32 - max_y as i32) as usize;
                let right = usize::min(max_x - 1, i);
                // We want to sum, in total, prefix[right+1], -prefix[left], and subtract
                // the 0.5s if necessary.
                // This may involve numbers of differing magnitudes, so use the float sum
                // algorithm to sum these up.
                let numbers_to_sum = vec![
                    Some(prefix[right + 1].0),
                    Some(prefix[right + 1].1),
                    Some(-prefix[left].0),
                    Some(-prefix[left].1),
                    // Need to halve the left endpoint.
                    (left as i32 == (i as i32 - max_y as i32)).then(|| -self.prob[left] / 2.),
                    // Need to halve the right endpoint.
                    // It's guaranteed that we won't accidentally "halve" twice,
                    // as that would require i-max_Y = i, so max_Y = 0 - which is
                    // impossible.
                    (right == i).then(|| -self.prob[right] / 2.),
                ];
                numbers_to_sum.iter().flatten().sum()
            })
            .collect();
    }

    fn range_of(&self, i: usize) -> (Self::T, Self::T) {
        Self::clamp_range((self.a, self.b), i)
    }

    fn a(&self) -> Self::T {
        self.a
    }

    fn b(&self) -> Self::T {
        self.b
    }

    fn range_limit(&mut self, range: (Self::T, Self::T)) -> Self::T {
        let start = f32::max(range.0, self.a);
        let end = f32::min(range.1, self.b);
        if start >= end {
            self.a = 0.;
            self.b = 0.;
            return 0.;
        }
        let start = start.floor();
        let end = end.ceil();
        self.prob = ((start - self.a) as usize..(end - self.a) as usize)
            .map(|i| self.prob[i] * range_intersect_length(self.range_of(i), range))
            .collect();
        self.a = start;
        self.b = end;
        self.normalize()
    }

    fn normalize(&mut self) -> Self::T {
        let total_probability = self.prob.iter().sum();
        self.prob = self.prob.iter().map(|i| i / total_probability).collect();
        total_probability
    }
}

#[cfg(test)]
mod tests {
    use crate::pdf::IUniform;

    #[test]
    fn test_uniform() {
        let pdf = super::Uniform::new(6000., 8000.);
        assert_eq!(pdf.prob.len(), 2000);
        for i in 0..2000 {
            assert_eq!(pdf.prob[i], 0.0005);
        }
    }

    ////////// RIP FLOATS
    // #[test]
    // fn test_prefix_float_sum() {
    //     let input = vec![
    //         0.009990099900996993,
    //         0.010000100001000031,
    //         0.010000100001000031,
    //         0.010000100001000031,
    //         0.010000100001000031,
    //         0.010000100001000031,
    //         0.010000100001000031,
    //         0.010000100001000031,
    //         0.010000100001000031,
    //         0.010000100001000031,
    //         0.010000100001000031,
    //     ];
    //     let want = vec![
    //         (0., 0.),
    //         (0.009990099900996993, 0.),
    //         (0.019990199901997026, -1.734723475976807e-18),
    //         (0.029990299902997057, -1.734723475976807e-18),
    //         (0.03999039990399709, -1.734723475976807e-18),
    //         (0.04999049990499712, -1.734723475976807e-18),
    //         (0.05999059990599715, -1.734723475976807e-18),
    //         (0.06999069990699719, -8.673617379884035e-18),
    //         (0.07999079990799722, -8.673617379884035e-18),
    //         (0.08999089990899725, -8.673617379884035e-18),
    //         (0.09999099990999728, -8.673617379884035e-18),
    //         (0.10999109991099731, -8.673617379884035e-18),
    //     ];
    //     let got = super::prefix_float_sum(&input);
    //     assert_eq!(got, want);
    // }
}
