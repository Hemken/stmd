cd "y:/hemken"

doedit example0.stmd

stmd example0.stmd

stmd example0.stmd, docx  // requires Stata 16

stmd example0.stmd, pdf   // requires Stata 16

stmd example0.stmd, saving(example0_emb.html) replace embedimage

stmd2dyn example0.stmd

dyndoc example0.dyn, saving(example0.emb.html) embedimage