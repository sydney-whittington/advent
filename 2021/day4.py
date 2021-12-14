from functools import reduce

with open("day4_input.txt", "r") as f:
    bingo_numbers = map(int, f.readline().split(","))

    # https://stackoverflow.com/questions/1624883/alternative-way-to-split-a-list-into-groups-of-n
    raw_boards = list(zip(*(iter(f.readlines()),) * 6))

boards = []
# preprocess boards
for board in raw_boards:
    rows = board[1:6]
    grid = [row.strip().split() for row in rows]
    matrix = [[(int(num), False) for num in row] for row in grid]

    boards.append(matrix)


def check(board):
    f = lambda x, y: x and y[1]
    winning = False
    for row in range(0,5):
        winning = winning or reduce(f, board[row], True)

    for column in range(0,5):
        winning = winning or reduce(f, [board[row][column] for row in range(0,5)], True)

    # oh, diagonals don't count...
    # winning = winning or reduce(f, [board[diagonal][diagonal] for diagonal in range(0,5)], True)
    # winning = winning or reduce(f, [board[diagonal][4-diagonal] for diagonal in range(0,5)], True)

    return winning


def mark_number(board, number):
    for ri, row in enumerate(board):
        for ci, square in enumerate(row):
            if square[0] == number:
                board[ri][ci] = (square[0], True)

    return board

# board = boards[0]
# line check
# for i in range(0,5):
#     board[0][i] = (board[0][i][0], True)

# column check
# for i in range(0,5):
#     board[i][1] = (board[i][1][0], True)

# diagonal check
# for i in range(0,5):
#     board[i][i] = (board[i][i][0], True)

# other diagonal check
# for i in range(0,5):
#     board[i][4-i] = (board[i][4-i][0], True)

def score(board, number):
    score = 0
    for row in board:
        for square in row:
            if square[1]==False:
                score += square[0]

    score *= number
    return score


loser = 0
for number in bingo_numbers:
    boards = [mark_number(board, number) for board in boards]
    winners = [check(board) for board in boards]

    # part 1    
    # if any(winners):
    #     winner = winners.index(True)
    #     print(f"Winner found! Score = {score(boards[winner], number)}")
    #     break

    # part 2
    if winners.count(False) == 1:
        loser = winners.index(False)
        print("Loser found! Waiting for final score.")

    if winners.count(False) == 0:
        print("Game ended.")
        print(f"Loser Score = {score(boards[loser], number)}")
        break


