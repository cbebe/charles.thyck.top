let then = (res: result<'a, 'b>, cb: 'a => result<'c, 'b>) => {
  switch res {
  | Ok(r) => cb(r)
  | Error(err) => Error(err)
  }
}

let catch = (res: result<'a, 'b>, cb: 'b => unit) => {
  switch res {
  | Ok(_) => ()
  | Error(err) => cb(err)
  }
}
