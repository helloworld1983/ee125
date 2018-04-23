for n in range(4, 6):
    max_bits = n
    difference = 2**(n) - 1
    current_stored = 0
    for m in range(1, 64):
        maximum_stored = 2**max_bits - 1
        current_stored += difference
        if current_stored > maximum_stored:
            max_bits += 1
            maximum_stored = 2**max_bits - 1
        
        print('''N = {}, M = {}, max_bits = {}, current_stored = {}, max_stored = {}'''
        .format(n, m, max_bits, current_stored, maximum_stored))
    print('------------------------------------------')
    

