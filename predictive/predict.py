parsing_table = {
    ('E', 'id'): ['T', 'E\''],
    ('E', '('): ['T', 'E\''],
    ('E\'', '+'): ['+', 'T', 'E\''],
    ('E\'', ')'): [],  # epsilon
    ('E\'', '$'): [],
    ('T', 'id'): ['F', 'T\''],
    ('T', '('): ['F', 'T\''],
    ('T\'', '*'): ['*', 'F', 'T\''],
    ('T\'', '+'): [],
    ('T\'', ')'): [],
    ('T\'', '$'): [],
    ('F', 'id'): ['id'],
    ('F', '('): ['(', 'E', ')']
}

def parse(input_tokens):
    stack = ['$', 'E']
    input_tokens.append('$')
    index = 0

    while len(stack) > 0:
        top = stack.pop()
        current_token = input_tokens[index]

        if top == current_token:
            print(f"Match: {top}")
            index += 1
        elif top in ['id', '+', '*', '(', ')', '$']:
            print(f"Error: unexpected token {current_token}")
            return
        else:
            production = parsing_table.get((top, current_token))
            if production is not None:
                if len(production) == 0:
                    print(f"Apply: {top} → ε")
                else:
                    print(f"Apply: {top} → {' '.join(production)}")
                    stack.extend(reversed(production))
            else:
                print(f"Error: no rule for {top} with lookahead {current_token}")
                return
    print("Input successfully parsed!")

# Example usage:
input_expr = ['id', '+', 'id', '*', 'id']
parse(input_expr)

