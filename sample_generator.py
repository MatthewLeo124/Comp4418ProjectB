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
            data.append(self.generate_quantity())
            data.append(self.generate_cost())
            data.append(self.generate_location())
        
        result = self.name + "(" + ",".join(data) + ")."
        return result

    def generate_name(self):
        names = ["gear", "pipe", "bolt", "motor", "wire", "chemicals"]
        types = ["s", "m", "l"]

        result = names[random.randint(0,len(names) - 1)]
        result += ","
        result += types[random.randint(0,len(types) - 1)]
        return result

    def generate_quantity(self):
        upper = 10000
        lower = 0
        return str(random.randint(lower, upper))

    def generate_cost(self):
        upper = 100
        lower = 10
        return str(random.randint(lower, upper))

    def generate_location(self):
        locations = ["australia", "usa", "china"]
        result = locations[random.randint(0,len(locations) - 1)]
        return result

    def generate_trinket(self):
        name = random.choice(["thermometer", "phmeter", "flowmeter", "controlpanel"])
        location = random.choice(["australia", "usa", "switzerland", "japan"])
        cost = str(random.randint(500, 10000))
        quantity = str(random.randint(0, 500))
        return [name, quantity, cost,location]

x = Generator("part")

with open("sample_data.txt", "w") as f:
    for i in x.generate_data(100):
        f.write(i)
        f.write("\n")
