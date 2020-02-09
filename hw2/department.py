class employee(object):
    """This class describes an employee parameters us
    first name, second name, salary, experiance (years)"""

    def __init__(self, first_name, last_name, salary, experiance):
        super(employee, self).__init__()
        self.first_name = first_name
        self.last_name = last_name
        self.salary = salary
        self.experiance = experiance

    def get_salary():
        '''If experiance of employee is > 2 years, he gets bonus + 200$,
         if experiance is > 5 years, he gets salary*1.2 + bonus 500'''
        if self.experiance > 5:
            return self.experiance * 1.2 +500
        elif self.experiance > 2:
            return self.experiance +500
        else:
            return float(self.experiance)

class developer(employee):
    """Class for developers."""
    pass

class designer(employee):
    """Class for designer."""

    def __init__(self, first_name, second_name, salary, experience, coeff):
        super(designer, self).__init__(first_name, second_name, salary, experience)
        self.coeff = coeff

    def get_salary(self):
        employee.get_salary(self)
        self.salary *= self.coeff
        return self.salary


class manager(employee):
    """Class for managers."""
    def __init__(self, first_name, last_name, salary, experiance, team = []):
        self.team = team
        super(manager, self).__init__(first_name, second_name, salary, experience)

    def get_salary(self):
        employee.get_salary(self)
        team_counter = len(self.team)
        if 5 < team_counter <= 10:
            self.salary +=200
        elif team_counter >= 10:
            self.salary += 300
        dev_counter = 0
        for employee in self.team:
            if isinstance(employee, developer):
                dev_counter += 1
        print (dev_counter)
        if dev_counter > team_counter % 2:
            self.salary *= 1.1
        return self.salary
