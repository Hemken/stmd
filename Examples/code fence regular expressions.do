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

*local cf        "^( ? ? ?)(```+|~~~+)\{?s(tata)?\/?(,.*)?\}?$"
*local infofence "^( ? ? ?)(```+|~~~+)\{?s(tata)?\/?(,.*)?\}?$"
local infofence "^( ? ? ?)(```+|~~~+)\{?(s|stata)\/?(,.*)?\}?$"
di "`infofence'"
assert ustrregexm("~~~", "`infofence'")==0 //fails, ordinary code fence

assert ustrregexm("~~~s", "`infofence'")     //markstat
di ustrregexs(1)
di ustrregexs(2)
di ustrregexs(3)
di ustrregexs(4)
assert ustrregexm("~~~stata", "`infofence'") //markstat
assert ustrregexm("~~~s/", "`infofence'")    //markstat
assert ustrregexm("~~~stata/", "`infofence'") //markstat
assert ustrregexm("~~~m", "`infofence'")==0 //fails

assert ustrregexm("~~~{s}", "`infofence'")
assert ustrregexm("~~~{s/}", "`infofence'")
assert ustrregexm("~~~{stata}", "`infofence'")
assert ustrregexm("~~~{stata/}", "`infofence'")

assert ustrregexm("~~~{sas}", "`infofence'")==0 //fails
di ustrregexs(1)
di ustrregexs(2)
di ustrregexs(3)
di ustrregexs(4)

assert ustrregexm("```{s, echo=FALSE}", "`infofence'")
assert ustrregexm("```{sas, echo=FALSE}", "`infofence'")==0
assert ustrregexm("```{stata, echo=FALSE}", "`infofence'")
