import random

class Generator():
    def __init__(self, name):
        self.name = name

    def generate_data(self, iterations):
        result = []
        for i in range(iterations):
            result.append(self.generate_row())
        return result

    def generate_row(self):
        data = []
        randInt = random.randint(1, 100)
        if randInt % 20 == 0:
            data = self.generate_trinket()
        else:
            data.append(self.generate_name())
            data.append(self.generate_cost())
            data.append(self.generate_quantity())
            data.append(self.generate_location())
        
        result = self.name + "(" + ",".join(data) + ")."
        return result

    def generate_name(self):
        names = ["gear", "pipe", "bolt", "motor", "wire", "chemicals"]
        types = ["abc_corp", "parts_galore", "trusted_supplier"]

        result = names[random.randint(0,len(names) - 1)]
        result += ","
        result += types[random.randint(0,len(types) - 1)]
        return result

    def generate_quantity(self):
        upper = 1000
        lower = 0
        return str(random.randint(lower, upper))

    def generate_cost(self):
        upper = 50
        lower = 1
        return str(random.randint(lower, upper))

    def generate_location(self):
        locations = ["australia", "usa", "china"]
        result = locations[random.randint(0,len(locations) - 1)]
        return result

    def generate_trinket(self):
        name = random.choice(["thermometer", "phmeter", "flowmeter", "dO2sensor", "dommeter", "turbmeter", "ionprobe", "algaesensor", "conmeter", "orpsensor"])
        rand = random.randint(1, 4)
        match rand:
            case 1:
                company = "trusted_supplier"
                location = "australia"
            case 2:
                company = "ricks_garage"
                location = "usa"
            case 3:
                company = "meter_house"
                location = "switzerland"
            case 4:
                company = "dancing_horse"
                location = "japan"
            case _:
                print("This shouldn't be reachable")
        cost = str(random.randint(50, 100))
        quantity = str(random.randint(1, 150))
        return [name, company, quantity, cost,location]

x = Generator("part")



with open("sample_data.txt", "w") as f:
    for i in x.generate_data(100):
        f.write(i)
        f.write("\n")
