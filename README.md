# Random Food Order Generator (Common Lisp)

An interactive Common Lisp program that generates random food orders from four category lists — **sandwiches**, **sides**, **beverages**, and **desserts** — and lets the user add or remove items from any list at runtime.

Originally written for **CMPSC 460 — Principles of Programming Languages** (Penn State Harrisburg, Spring 2026).

## Features

- Menu-driven loop with four options: generate an order, add an item, remove an item, quit.
- Random food order built by picking one item from each list in order: sandwich → side → beverage → dessert.
- Add/remove items from any category at runtime, with duplicate-protection on add and safe handling of empty lists / missing items on remove.
- Input validation on all menu choices (re-prompts on invalid input).
- Uses only local variables — no globals — and is built from small, single-purpose functions.

## Initial food lists

| Category   | Items                                                  |
| ---------- | ------------------------------------------------------ |
| Sandwiches | `blt`, `tuna-salad`, `grilled-cheese`, `hamburger`, `cheesesteak` |
| Sides      | `tossed-salad`, `pasta-salad`, `fries`, `onion-rings`, `chips` |
| Beverages  | `lemonade`, `iced-tea`, `water`, `soda`, `coffee`       |
| Desserts   | `ice-cream`, `cake`, `pie`, `brownie`, `cookies`        |

## Requirements

- A Common Lisp implementation. Developed with [SBCL](http://www.sbcl.org/) 2.6.3, but it should work with any standard CL (LispWorks, CLISP, CCL, etc.).

## How to run

### 1. Install a Common Lisp

- **Windows:** download SBCL from [sbcl.org/platform-table.html](http://www.sbcl.org/platform-table.html) and run the installer.
- **macOS:** `brew install sbcl`
- **Linux (Debian/Ubuntu):** `sudo apt install sbcl`

Verify the install with:

```bash
sbcl --version
```

### 2. Clone this repo

```bash
git clone https://github.com/<your-username>/<your-repo>.git
cd <your-repo>
```

### 3. Navigate to the project folder

Make sure your terminal is in the folder that contains `FoodOrder.LISP`:

```bash
cd <path-to-the-folder-containing-FoodOrder.LISP>
dir          # Windows PowerShell — confirms the file is here
ls           # macOS / Linux
```

> If you don't see `FoodOrder.LISP` listed, you're probably in a parent folder. `cd` one level deeper until `FoodOrder.LISP` shows up in the listing.

### 4. Start SBCL and load the program

```bash
sbcl --load FoodOrder.LISP
```

This drops you into the SBCL REPL, which uses `*` as its prompt. You don't type the `*` — it's just shown at the start of each input line.

### 5. Run the program

At the `*` prompt, call the main function:

```lisp
(loop-program)
```

The menu will appear. Pick options by typing the number and pressing Enter. Choose **4** to quit the program.

To exit SBCL afterward:

```lisp
(quit)
```

## Example session

```
MENU OPTIONS:
1) Generate a food order
2) Add a food item
3) Remove a food item
4) Quit
Please enter your choice:
1

Random food order:
BLT, ONION-RINGS, LEMONADE, CAKE

MENU OPTIONS:
1) Generate a food order
2) Add a food item
3) Remove a food item
4) Quit
Please enter your choice:
4

"Thank you for using my Food Order Generator!"
```

## Program structure

| Function                | Purpose                                                            |
| ----------------------- | ------------------------------------------------------------------ |
| `loop-program`          | Main driver — owns the four lists and runs the menu loop.          |
| `display-main-menu`     | Prints the top-level menu.                                         |
| `display-sub-menu`      | Prints the food-category submenu.                                  |
| `display-all-lists`     | Prints the current state of all four lists.                        |
| `get-main-choice`       | Reads + range-checks a 1–4 selection for the main menu.            |
| `get-sub-choice`        | Reads + range-checks a 1–4 selection for the submenu.              |
| `generate-food-order`   | Picks one random item per list and prints the order.               |
| `add-food-item`         | Adds an item to a list if not already present.                     |
| `remove-food-item`      | Removes an item from a list; safe on empty list / missing item.    |
| `handle-add`            | Wires the submenu choice to the correct list for adding.           |
| `handle-remove`         | Wires the submenu choice to the correct list for removing.         |

## Files

- `FoodOrder.LISP` — Common Lisp source code
- `LISP OUTPUT DOC.docx` — sample runs from the program

## Author

Muhammad Danish Zahin Bin Rafizal — `mjr7066@psu.edu`

## Notes

GitHub Copilot was used during development; see the header comment in `FoodOrder.LISP`.
