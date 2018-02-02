assert ustrregexm("{", "^\{")
assert ustrregexm("}", "^\{")==0
assert ustrregexm("}", "^\}")
assert ustrregexm("{", "^\}")==0 //does not crash

assert ustrregexm("{}", "^\{")
assert ustrregexm("}{", "^\{")==0
assert ustrregexm("}{", "^\}")
assert ustrregexm("{}", "^\}")==0 //does not crash

assert ustrregexm("{}", "^\}\{")==0
assert ustrregexm("}{", "^\}\{")

assert ustrregexm("{}", "^\{\}")
assert ustrregexm("}{", "^\{\}")==0

assert ustrregexm("{stata}", "^\{stata\}")
assert ustrregexm("{sas}", "^\{stata\}")==0

assert ustrregexm("{s}", "^\{s(tata)?\}")
assert ustrregexm("{stata}", "^\{s(tata)?\}")
assert ustrregexm("{sas}", "^\{s(tata)?\}")==0

assert ustrregexm("{s}", "^\{?s(tata)?\}?$")
assert ustrregexm("{stata}", "^\?{s(tata)?\}?$")
assert ustrregexm("{sas}", "^\{?s(tata)?\}?$")==0

assert ustrregexm("{s}", "^\{?s(tata)?\/?\}?$")
assert ustrregexm("{stata}", "^\?{s(tata)?\/?\}?$")
assert ustrregexm("{sas}", "^\{?s(tata)?\/?\}?$")==0
assert ustrregexm("{s/}", "^\{?s(tata)?\/?\}?$")
assert ustrregexm("{stata/}", "^\?{s(tata)?\/?\}?$")
assert ustrregexm("{sas/}", "^\{?s(tata)?\/?\}?$")==0

assert ustrregexm("{s, echo=FALSE}", "^\{?s(tata)?\/?\}?$")==0
assert ustrregexm("{s, echo=FALSE}", "^\{?s(tata)?\/?(,.*)\}?$")
assert ustrregexm("{sas, echo=FALSE}", "^\{?s(tata)?\/?(,.*)\}?$")==0
assert ustrregexm("{stata, echo=FALSE}", "^\{?s(tata)?\/?(,.*)\}?$")