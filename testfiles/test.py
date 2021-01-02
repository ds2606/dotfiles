import itertools
import random


class Minesweeper():
    """
    Minesweeper game representation
    """

    def __init__(self, height=8, width=8, mines=8):

        # Set initial width, height, and number of mines
        self.height = height
        self.width = width
        self.mines = set()

        # Initialize an empty field with no mines
        self.board = []
        for i in range(self.height):
            row = []
                         for j in range(self.width):
                row.append(False)
            self.board.append(row)

        # Add mines randomly
        while len(self.mines) != mines:
            i = random.randrange(height)
            j = random.randrange(width)
            if not self.board[i][j]:
                self.mines.add((i, j))
                self.board[i][j] = True

        # At first, player has found no mines
        self.mines_found = set()

    def print(self):
        """
        Prints a text-based representation
        of where mines are located.
        """
        for i in range(self.height):
            print("--" * self.width + "-")
            for j in range(self.width):
                if self.board[i][j]:
                    print("|X", end="")
                else:
                    print("| ", end="")
            print("|")
        print("--" * self.width + "-")

    def is_mine(self, cell):
        i, j = cell
        return self.board[i][j]

    def nearby_mines(self, cell):
        """
        Returns the number of mines that are
        within one row and column of a given cell,
        not including the cell itself.
        """
#TODO hello
        # Keep count of nearby mines
        count = 0

        # Loop over all cells within one row and column
        for i in range(cell[0] - 1, cell[0] + 2):
            for j in range(cell[1] - 1, cell[1] + 2):

                # Ignore the cell itself
                if (i, j) == cell:
                    continue

                # Update count if cell in bounds and is mine
                if 0 <= i < self.height and 0 <= j < self.width:
                    if self.board[i][j]:
                        count += 1

        return count

    def won(self):
        """
        Checks if all mines have been flagged.
        """
        return self.mines_found == self.mines

    def w

class Sentence():
    """
    Logical statement about a Minesweeper game
    A sentence consists of a set of board cells,
    and a count of the number of those cells which are mines.
    """

    def __init__(self, cells, count):
        self.cells = set(cells)
        self.count = count
        self.mines = set() # added to implementation
        self.safes = set() # added to implementation

    def __eq__(self, other):
        return self.cells == other.cells and self.count == other.count

    def __str__(self):
        return f"{self.cells} = {self.count}"

    def known_mines(self):
        """
        Returns the set of all cells in self.cells known to be mines.
        """
        if self.count == len(self.cells) != 0:
            return self.cells.copy()
        else:
            return set()

    def known_safes(self):
        """
        Returns the set of all cells in self.cells known to be safe.
        """
        if self.count == 0:
            return self.cells.copy()
        else:
            return set()

    def mark_mine(self, cell):
        """
        Updates internal knowledge representation given the fact that
        a cell is known to be a mine.
        """
        if cell in self.cells:
            self.cells.remove(cell)
            self.count -= 1

    def mark_safe(self, cell):
        """
        Updates internal knowledge representation given the fact that
        a cell is known to be safe.
        """
        if cell in self.cells:
            self.cells.remove(cell)


class MinesweeperAI():
    """
    Minesweeper game player
    """
    
    def __init__(self, height=8, width=8):

        # Set initial height and width
        self.height = height
        self.width = width

        # Keep track of which cells have been clicked on
        self.moves_made = set()

        # Keep track of cells known to be safe or mines
        self.mines = set()
        self.safes = set()

        # List of sentences about the game known to be true
        self.knowledge = []

    def mark_mine(self, cell):
        """
        Marks a cell as a mine, and updates all knowledge
        to mark that cell as a mine as well.
        """
        self.mines.add(cell)
        for sentence in self.knowledge:
            sentence.mark_mine(cell)

    def mark_safe(self, cell):
        """
        Marks a cell as safe, and updates all knowledge
        to mark that cell as safe as well.
        """
        self.safes.add(cell)
        for sentence in self.knowledge:
            sentence.mark_safe(cell)

    def add_knowledge(self, cell, count):
        """
        Called when the Minesweeper board tells us, for a given
        safe cell, how many neighboring cells have mines in them.
        """
        # (1) mark the cell as a move that has been made
        self.moves_made.add(cell)

        # (2) mark the cell as safe
        self.mark_safe(cell)

        # (3) add a new sentence to the AI's knowledge base, based on  `cell` and `count`values
        neighbors = {
            (i, j)
            for i in range(cell[0] - 1, cell[0] + 2)
            for j in range(cell[1] - 1, cell[1] + 2)
            if i not in (-1, self.height) and j not in (-1, self.width)
            }
        count -= len(neighbors & self.mines)
        possible_mines = neighbors - ({cell} | self.mines | self.safes)
        self.knowledge.append(Sentence(possible_mines, count))

        # (4) mark any additional cells as safe or as mines if inferable from the AI's knowledge base
        new_mines = set()
        new_safes = set()
        for s in self.knowledge:
            new_mines |= s.known_mines()
            new_safes |= s.known_safes()
        if s.count == len(s.cells): # all neighbors mines?
            for mine in s.cells.copy():
                self.mark_mine(mine)
        for mine in new_mines:
            self.mark_mine(mine)
        for safe in new_safes:
            self.mark_safe(safe)

        # clean up knowledge base
        sentences_to_remove = []
        for s in self.knowledge:
            if s.cells == set():
                sentences_to_remove.append(s)
            for t in self.knowledge[self.knowledge.index(s) + 1:]:
                if s == t:
                    sentences_to_remove.append(s)
        for s in sentences_to_remove:
            if s in self.knowledge:
                self.knowledge.remove(s)
            

        # (5) add any new sentences to the AI's knowledge base if they can be inferred from existing knowledge
        new_knowledge = [Sentence(s2.cells - s1.cells, s2.count - s1.count) for s1 in self.knowledge for s2 in self.knowledge if s1.cells < s2.cells and s1.cells != None]
        print(f'new knowledge: {len(new_knowledge)}')
        self.knowledge += new_knowledge

        # debug: print knowledge base
        print('Current knowledge:')
        for k in self.knowledge: print(k)
        print('Current mines:')
        for mine in self.mines: print (mine)
        print('Current safes:')
        for safe in self.safes - self.moves_made: print (safe)

    def make_safe_move(self):
        """
        Returns a safe cell to choose on the Minesweeper board.
        The move must be known to be safe, and not already a move
        that has been made.

        This function may use the knowledge in self.mines, self.safes
        and self.moves_made, but should not modify any of those values.
        """
        safe_moves = self.safes - self.moves_made
        if len(safe_moves) > 0:
            return random.choice(tuple(safe_moves))
        else:
            return None

    def make_random_move(self):
        """
        Returns a move to make on the Minesweeper board.
        Should choose randomly among cells that:
            1) have not already been chosen, and
            2) are not known to be mines
        """
        random_moves = {(i, j) for i in range(self.height) for j in range(self.width)}
        random_moves -= self.moves_made | self.mines
        if len(random_moves) > 0:
            return random.choice(tuple(random_moves))
        else:
            return None
