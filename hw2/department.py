class employee(object):
    """This class describes an employee parameters us
    first name, second name, salary, experiance (years)"""
    def __init__(self, first_name, last_name, salary, experience, manager=None):
        super(employee, self).__init__()
        self.first_name = first_name
        self.last_name = last_name
        self.salary = salary
        self.experience = experience
        self.manager = manager

    def get_salary(self):
        '''If experiance of employee is > 2 years, he gets bonus + 200$,
         if experiance is > 5 years, he gets salary*1.2 + bonus 500'''
        if self.experience > 5:
            return self.salary * 1.2 + 500
        elif self.experience > 2:
            return self.salary + 200
        else:
            return float(self.salary)

    def __str__(self):
        return '{0} {1} :: got salary :: {2}'.format(self.first_name, self.last_name, self.get_salary())

class designer(employee):
    """This class describes designer nd count they salery."""

    def __init__(self, first_name, last_name, salary, experience, coeff):
        super(designer, self).__init__(first_name, last_name, salary, experience)
        self.coeff = coeff

    def get_salary(self):
        return employee.get_salary(self) * self.coeff

class developer(employee):
    """This class describes developers and count they salery."""

    def __init__(self, first_name, last_name, salary, experience):
        super(developer, self).__init__(first_name, last_name, salary, experience)
        pass

class manager(employee):
    """This class describes managers and count they salery."""

    def __init__(self, first_name, last_name, salary, experience, team_all, team_dev):
        super(manager, self).__init__(first_name, last_name, salary, experience)
        self.team_all = team_all
        self.team_dev = team_dev

    def get_salary(self):
        if self.team_all // 2 > self.team_dev:
            bonus = 0
        else:
            bonus = 1.1
        if self.team_all > 10:
            return employee.get_salary(self) * bonus + 300
        elif self.team_all > 5:
            return employee.get_salary(self) * bonus + 200


class department(object):
    """This class describes department."""

    def __init__(self, manager):
        super(department, self).__init__()
        self.manager = manager

    def get_salary(self):
        return employee.get_salary(self)




piter = designer('piter', 'parker', 20, 2, 4)
ali = developer('ali', 'aba', 50, 3)
king = manager('king', 'kong', 100, 5, 10, 6)
print(king)
print(ali)
print(piter)
