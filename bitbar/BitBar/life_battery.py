#!/usr/bin/env python

from datetime import datetime

birth = datetime(1984, 1, 2)
death = datetime(2074, 1, 2)

today = datetime.now()
life_seconds = (death - birth).total_seconds()
left_seconds = (death - today).total_seconds()

print('{:.0f}% :skull:'.format(left_seconds / life_seconds * 100))
print('---')
print('{:,d} days left'.format(int(left_seconds / (3600 * 24))))
print('{:,d} hours left'.format(int(left_seconds / 3600)))
print('{:,d} minutes left'.format(int(left_seconds / 60)))
