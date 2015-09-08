# RWSectionedUI
A collection of classes I use to make UITableViewController & UICollectionViewControllers more modular.

The main concept is that you subclass the base section to provide these functions:
1. count the number of rows/cells in your section
2. create the row/cell for the requested index into your section

You are totally isolated from other sections.
You do not know which section number you are.

The collection view it less fleshed out than the table view, so there could be bugs in there.

Main assumption of the collection view logic:
The bottom-most element of section n is closer to y-offset 0 than the top-most element of section n+1
-- that is, the cells from one section to not intermix with the cells from another section

When laying out your collection view section, you must keep track of the greatest y-offset of your section.
This is used to position the top-most element of the next section.
