# fishes = [3,4,3,1,2]
with open("day6_input.txt") as f:
    fishes = list(map(int, f.readline().split(",")))

def day6(fishes):
    # wayyy too slow for part 2
    def generation(fishes):
        new_fish = 0
        for i in range(len(fishes)):
            fishes[i] = fishes[i]-1
            if fishes[i] == -1:
                new_fish += 1
                fishes[i] = 6

        fishes.extend(([8]*new_fish))
        return fishes

    for day in range(80):
        fishes = generation(fishes)
    print(len(fishes))


def day6_2(fishes):
    fish_by_year = {i: 0 for i in range(-1,9)}

    #initial load
    for fish in fishes:
        fish_by_year[fish] += 1

    def generation(fish_by_year):
        for i in range(0,9):
            fish_by_year[i-1] = fish_by_year[i]

        # new fish make a long and a short one
        # but all 8 fish have matured so it's just new fish
        fish_by_year[8] = fish_by_year[-1]
        fish_by_year[6] += fish_by_year[-1]

        fish_by_year[-1] = 0

        return fish_by_year


    for day in range(256):
        fish_by_year = generation(fish_by_year)

    print(sum(fish_by_year.values()))


day6_2(fishes)

