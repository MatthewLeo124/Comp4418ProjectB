import random

with open("sample_data.txt", "w") as f:
    for i in range(7):
        items = ["thermometer", "phmeter", "flowmeter", "dO2sensor", "dommeter", "turbmeter", "ionprobe", "algaesensor", "conmeter", "orpsensor"]
        companies = ["trusted_supplier", "ricks_garage", "meter_house", "dancing_horse", "zzz_inc", "putin_corp", "u_comp"]
        locations = ["australia", "usa", "switzerland", "japan", "china", "russia", "ukraine"]
        upper = 9
        for j in range(random.randint(0, 9)):
            index = random.randint(0, upper)
            item = items[index]
            company = companies[i]
            location = locations[i]
            cost = str(random.randint(10, 100))
            quantity = str(random.randint(1, 150))
            data = [item, company, cost, quantity, location]
            to_write = "part(" + ",".join(data) + ").\n"
            f.write(to_write)
            items.pop(index)
            upper -= 1
