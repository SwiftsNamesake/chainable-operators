Chained Operators
=================
This library introduces chainable operators to Haskell, in the style of Python.
In addition to the small set of predefined operators, you may define your own
chainables by 'lifting' binary functions with `chainable`.

```haskell
-- These functions already exist. I've excluded type annotations for brevity.
(≤) = chainable (<=)

(≥) = chainable (>=)

-- Defining your own operators is trivial, given an 'unlifted' function

(<<<) = chainable muchSmaller
```

# TODO
- [ ] Make sure the README is up-to-date
- [ ] Finish the library.

# Contribute
Raise an issue, email me, or submit a pull request.

# Install

Either use `cabal`
> cabal install chainable-operators

or the usurper `stack`.
> stack install chainable-operators

or add it to your dependencies in the `.yaml` or `.cabal` file.
