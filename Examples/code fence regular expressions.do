local cfb "^( ? ? ?)(```+|~~~+)([ ]*)$"
di "`cfb'"
assert ustrregexm("```", "`cfb'")
assert ustrregexm(" ```", "`cfb'")
assert ustrregexm("  ```", "`cfb'")
assert ustrregexm("   ```", "`cfb'")
assert ustrregexm("    ```", "`cfb'")==0 // fails

assert ustrregexm("~~~", "`cfb'")
assert ustrregexm(" ~~~", "`cfb'")
assert ustrregexm("  ~~~", "`cfb'")
assert ustrregexm("   ~~~", "`cfb'")
assert ustrregexm("    ~~~", "`cfb'")==0 // fails

assert ustrregexm("```", "`cfb'")
assert ustrregexm("````", "`cfb'")
assert ustrregexm("`````", "`cfb'")
assert ustrregexm("``", "`cfb'")==0 // fails

assert ustrregexm("``` ", "`cfb'")

local cf "^( ? ? ?)(```+|~~~+)\{?s(tata)?\/?(,.*)?\}?$"
di "`cf'"
assert ustrregexm("~~~s", "`cf'")
assert ustrregexm("~~~", "`cf'")==0 //fails
assert ustrregexm("~~~m", "`cf'")==0 //fails
assert ustrregexm("~~~{s}", "`cf'")
assert ustrregexm("~~~s/", "`cf'")
assert ustrregexm("~~~{s/}", "`cf'")
assert ustrregexm("~~~{stata}", "`cf'")
assert ustrregexm("~~~{stata/}", "`cf'")
assert ustrregexm("~~~{sas}", "`cf'")==0 //fails

assert ustrregexm("```{s, echo=FALSE}", "`cf'")
assert ustrregexm("```{sas, echo=FALSE}", "`cf'")==0
assert ustrregexm("```{stata, echo=FALSE}", "`cf'")
