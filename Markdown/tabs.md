## Tabs

Tabs in lines are not expanded to [spaces].  However,
in contexts where whitespace helps to define block structure,
tabs behave as if they were replaced by spaces with a tab stop
of 4 characters.

Thus, for example, a tab can be used instead of four spaces
in a code block (indicated by indentation).

Note, however, that flexmark and pegdown differ on how internal
tabs are treated.  In flexmark, tabs are passed through as literal tabs, 
not expanded to spaces. In pegdown they are filled out with spaces to the
next tab stop, i.e. anywhere from 1 to 4 spaces.

Example 1 - leading tab
~~~~
```
	foo	baz		bim
```
~~~~

	foo	baz		bim

Example 2 - leading spaces plus tab
~~~~
```
	foo	baz		bim
```
~~~~

	foo	baz		bim

Example 3 - four leading spaces
~~~~
```
    a	a
			a
```
~~~~

    a	a
			a

In the following example, a continuation paragraph of a list
item is indented with a tab; this has exactly the same effect
as indentation with four spaces would:

Example 4 - continue a list with a tabbed paragraph
~~~~
```
- foo

	bar
```
~~~~
- foo

	bar

Example 5 - continuation with two tabs, formatted as code
~~~~
```
- foo

		bar
```
~~~~
- foo

		bar

Normally the `>` that begins a block quote may be followed
optionally by a space, which is not considered part of the
content.  In the following case `>` is followed by a tab,
which is treated as if it were expanded into three spaces.
Since one of these spaces is considered part of the
delimiter, `foo` is considered to be indented six spaces
inside the block quote context, so we get an indented
code block starting with two spaces.

(Here again, flexmark and pegdown differ.)

Example 6 - blockquote and two tabs
~~~~
```
>		foo
```
~~~~
>		foo

Example 7 - list item and two tabs
~~~~
```
-		foo
```
~~~~
-		foo

Example 8 - space indented code block, continued with tab indent
~~~~
```
    foo
	bar
```
~~~~
    foo
	bar

Example 9 - list, 3 space indent, tab indent item 3
~~~~
```
 - foo
   - bar
	- baz
```
~~~~
 - foo
   - bar
	- baz

Example 10 - tab in header
~~~~
```
#	Foo
```
~~~~
#	Foo

Example 11 - tabs in theme break
~~~~
```
*	*	*	
```
~~~~
*	*	*	
