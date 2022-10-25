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

        data.append(self.generate_name())
        data.append(self.generate_quantity())
        data.append(self.generate_cost())
        data.append(self.generate_location())
        
        result = self.name + "(" + ",".join(data) + ")"
        return result

    def generate_name(self):
        names = ["Gear", "Pipe", "Bolt"]
        types = ["A", "B", "C"]

        result = "'" + names[random.randint(0,len(names) - 1)]
        result += " "
        result += types[random.randint(0,len(types) - 1)]
        result += "'"
        return result

    def generate_quantity(self):
        upper = 100
        lower = 10
        return str(random.randint(lower, upper))

    def generate_cost(self):
        upper = 100
        lower = 10
        return str(random.randint(lower, upper))

    def generate_location(self):
        locations = ["Australia", "USA", "Germany"]
        result = locations[random.randint(0,len(locations) - 1)]
        result = "'" + result + "'"
        return result
        
x = Generator("part")
f = open("sample_data.txt", "w")

for i in x.generate_data(100):
    f.write(i)
    f.write("\n")
f.close()


