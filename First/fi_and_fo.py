from collections import defaultdict

EPSILON = 'ε'

productions = defaultdict(list)
non_terminals = set()
terminals = set()

first = defaultdict(set)
follow = defaultdict(set)

def compute_first(symbol):
    if symbol in terminals:
        return {symbol}
    if symbol == EPSILON:
        return {EPSILON}

    if symbol in first and first[symbol]:
        return first[symbol]

    result = set()
    for prod in productions[symbol]:
        for sym in prod:
            sym_first = compute_first(sym)
            result.update(sym_first - {EPSILON})
            if EPSILON not in sym_first:
                break
        else:
            result.add(EPSILON)

    first[symbol] = result
    return result

def compute_follow():
    start_symbol = list(productions.keys())[0]
    follow[start_symbol].add('$')

    updated = True
    while updated:
        updated = False
        for lhs in productions:
            for prod in productions[lhs]:
                for i in range(len(prod)):
                    B = prod[i]
                    if B in non_terminals:
                        after = prod[i+1:]
                        temp = set()
                        if after:
                            for sym in after:
                                temp |= compute_first(sym) - {EPSILON}
                                if EPSILON in compute_first(sym):
                                    continue
                                else:
                                    break
                            else:
                                temp |= follow[lhs]
                        else:
                            temp |= follow[lhs]

                        if not temp.issubset(follow[B]):
                            follow[B] |= temp
                            updated = True

def display_results():
    print("\nFIRST sets:")
    for nt in non_terminals:
        print(f"FIRST({nt}) = {{ {', '.join(first[nt])} }}")

    print("\nFOLLOW sets:")
    for nt in non_terminals:
        print(f"FOLLOW({nt}) = {{ {', '.join(follow[nt])} }}")

def main():
    n = int(input("Enter number of productions: "))
    print("Enter productions in the format A -> α (use ε for epsilon):")
    for _ in range(n):
        line = input().strip()
        lhs, rhs = line.split("->")
        lhs = lhs.strip()
        rhs = rhs.strip().split()

        non_terminals.add(lhs)
        for sym in rhs:
            if not sym.isupper() and sym != EPSILON:
                terminals.add(sym)
            elif sym.isupper():
                non_terminals.add(sym)

        productions[lhs].append(rhs)

    for nt in non_terminals:
        compute_first(nt)

    compute_follow()
    display_results()

if __name__ == "__main__":
    main()

