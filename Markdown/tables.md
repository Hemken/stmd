## Tables (extension)

<style>
table {
    border-collapse: collapse;
}
table, th, td {
   border: 1px solid black;
}
blockquote {
    border-left: solid blue;
	padding-left: 10px;
}
</style>

GFM enables the `table` extension, where an additional leaf block type is
available.

A [table](@) is an arrangement of data with rows and columns, consisting of a
single header row, a [delimiter row] separating the header from the data, and
zero or more data rows.

Each row consists of cells containing arbitrary text, in which [inlines] are
parsed, separated by pipes (`|`).  A leading and trailing pipe is also
recommended for clarity of reading, and if there's otherwise parsing ambiguity.
Spaces between pipes and cell content are trimmed.  Block-level elements cannot
be inserted in a table.

The [delimiter row](@) consists of cells whose only content are hyphens (`-`),
and optionally, a leading or trailing colon (`:`), or both, to indicate left,
right, or center alignment respectively.

~~~~
```
| foo | bar |
| --- | --- |
| baz | bim |
```
~~~~
| foo | bar |
| --- | --- |
| baz | bim |

Flexmark and pegdown differ in how they treat leading spaces.
In flexmark, one to three leading spaces are ignored. In pegdown,
a leading space in the header is an extra cell, but leading
spaces on all lines is a paragraph.
~~~~
```
 | foo | bar |
| --- | --- |
| baz | bim |
```
~~~~
 | foo | bar |
| --- | --- |
| baz | bim |

~~~~
```
 | foo | bar |
 | --- | --- |
 | baz | bim |
```
~~~~
 | foo | bar |
 | --- | --- |
 | baz | bim |

Four leading spaces marks an indented code block, and the
rest of the table is recognized (but has no header row).
~~~~
```
    | foo | bar |
| --- | --- |
| baz | bim |
```
~~~~
    | foo | bar |
| --- | --- |
| baz | bim |

Cells in one column don't need to match length, though it's easier to read if
they are. Likewise, use of leading and trailing pipes may be inconsistent:

~~~~
```
| abc | defghi |
:-: | -----------:
bar | baz
```
~~~~
| abc | defghi |
:-: | -----------:
bar | baz

Include a pipe in a cell's content by escaping it, including inside other
inline spans:

~~~~
```
| f\|oo  |
| ------ |
| b `\|` az |
| b **\|** im |
```
~~~~
| f\|oo  |
| ------ |
| b `\|` az |
| b **\|** im |

The table is broken at the first empty line, or beginning of another
block-level structure:

~~~~
```
| abc | def |
| --- | --- |
| bar | baz |
> bar
```
~~~~
| abc | def |
| --- | --- |
| bar | baz |
> bar

Flexmark and pegdown interpret the first "bar" as a paragraph, while
GFM specifies it as a (short) table row/cell.  At least flexmark and
pegdown agree with each other.
~~~~
```
| abc | def |
| --- | --- |
| bar | baz |
bar

bar
```
~~~~
| abc | def |
| --- | --- |
| bar | baz |
bar

bar

In GFM, the header row must match the [delimiter row] in the number of cells.  If not,
a table will not be recognized.  However flexmark and pegdown both see this
as a table.

~~~~
```
| abc | def |
| --- |
| bar |
```
~~~~
| abc | def |
| --- |
| bar |

The remainder of the table's rows may vary in the number of cells.  In GFM, if there
are a number of cells fewer than the number of cells in the header row, empty
cells are inserted.  If there are greater, the excess is ignored.  In flexmark
and pegdown, the row with the greatest number of cells rules them all.

~~~~
```
| abc | def |
| --- | --- |
| bar |
| bar | baz | boo |
```
~~~~
| abc | def |
| --- | --- |
| bar |
| bar | baz | boo |

If there are no rows in the body, no `<tbody>` is generated in HTML output:
~~~~
```
| abc | def |
| --- | --- |
```
~~~~
| abc | def |
| --- | --- |

If there are no rows in the header, no visible header is generated in HTML output:
~~~~
```
| --- | --- |
| abc | def |
```
~~~~
| --- | --- |
| abc | def |

Examples not considered in the GFM extension.
Table in a blockquote? Yes.
~~~~
```
> sometext

> | foo | bar |
> | --- | --- |
> | baz | bim |
```
~~~~
> sometext

> | foo | bar |
> | --- | --- |
> | baz | bim |

And note that lazy blockquoting works as well.
~~~~
```
> sometext

> | foo | bar |
| --- | --- |
| baz | bim |
```
~~~~
> sometext

> | foo | bar |
| --- | --- |
| baz | bim |

Table in a list?  Yes, a table may be a list item.
~~~~
```
- sometext

- | foo | bar |
| --- | --- |
| baz | bim |
```
~~~~
- sometext

- | foo | bar |
| --- | --- |
| baz | bim |

A table may also appear as a continuation of a list item.  Note there
are four leading spaces.
~~~~
```
- sometext

    | foo | bar |
    | --- | --- |
    | baz | bim |
```
~~~~
- sometext

    | foo | bar |
    | --- | --- |
    | baz | bim |
	
