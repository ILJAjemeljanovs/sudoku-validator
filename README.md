# Solution description

## Lack of time
Unfortunately plans have tendency to change and i was forsed to do this assignment today(August 16th), instad of tomorrow, because of personal matters.
That has resulted in somewhat hasty code, but i did my best.
I have started it at 15:45 and at the moment of writing this file is 20:50,
so it have taken me about 5 hours.

## Goal

Even though this solution looks overcomplicated for the task that was provided
I had in mind that i need to show my skills to the Mitigate developers.
This is the result of this thought:
  * i need to make solution as Object Oriented as possible, even though scripted version could have resulted in a lot less code.
  * i need to create solution using relevant Design Patterns(Composite, Adapter/Interpreter and Command where the natural choises).
  * i need to create unit tests for new code, i'm about to add, to show at least basic TDD.
  * i need to create easily expandable and maintainable code by using Single Responcibility Principle, DRY, Programm to Intreface Not Implementation

## Changes to original code

I have changed the way files are loaded in the Rakefile and the validator_spec.
I have added a couple new fixtures to accomodate grid format check.
I have added `pry` gem for easier debugging

## Solution structure

All starts in Validator, where we begin by using a Parser object that plays the role of Adapter/Interpreter.
Parser first parses the string into a Puzzle object that we can communicate with.
Puzzle object is a Composite object that is constructed by using Line, Column and Quadrant objects, that we will validate later on. Because All sudoku elements only contains 9 digits and play by the same rules - we create Abstract base object by the name Sudoku Element and make it parent to all elements.
When constructing the object we populate it using Command pattern and setting up all the necessary info to the Puzzle object.
Lastly we ask the puzzle object if it is valid, complete or invalid.

Such approach will allow us to expand functionality later on if we for example will introduce new rules or elements to the puzzle (like Killer Sudoku for example) and at the same time we did not write any unneccessary code.

## P.S.
I somehow managed mess up the first git repository with the structured commits `>_<`, so this is a second one where everything is in a couple commits... Bad practice, but i dont't have any energy left to commit every single part one by one and fake the work progress.. Hope it doesnt affect the evaluation much.

# Sudoku validator

## Description

Write code to check if a given string is a correct [sudoku](https://en.wikipedia.org/wiki/Sudoku) puzzle and return a message indicating whether the puzzle is valid, invalid or valid and incomplete.

## Setup

After cloning the repository, run the following command:

```sh
bin/setup
```

## Usage

The program can be run via `rake run`:

```sh
  rake run <path to the sudoku file to validate>
```

Depending on the contents of the sudoku puzzle, the program should return a different result

* If the puzzle is valid and completed, return `Sudoku is valid.`
* If the puzzle is valid but not fully completed, return `Sudoku is valid but incomplete.`
* If the puzzle is not valid, return `Sudoku is invalid.`

A puzzle is valid if:

1. No numbers are repeated in any of the rows
2. No numbers are repeated in any of the columns
3. Every 9x9 square has no repeated numbers
4. Only numbers 1 - 9 are used to fill the puzzle (or 0 for empty cells)

## Implementation

Additions should be written to `lib/validator.rb` within the method `validate`, the creation of additional methods and classes is encouraged.

## Ensuring that the solution is valid

This exercise contains unit tests that verify that the solution functions correctly. If all of the tests pass, the solution is correct.

The tests can be run via `rake spec`.

## Example sudoku file format

*Zeroes represent empty sudoku cells*
```
8 5 0 |0 0 2 |4 0 0
7 2 0 |0 0 0 |0 0 9
0 0 4 |0 0 0 |0 0 0
------+------+------
0 0 0 |1 0 7 |0 0 2
3 0 5 |0 0 0 |9 0 0
0 4 0 |0 0 0 |0 0 0
------+------+------
0 0 0 |0 8 0 |0 7 0
0 1 7 |0 0 0 |0 0 0
0 0 0 |0 3 6 |0 4 0
```
