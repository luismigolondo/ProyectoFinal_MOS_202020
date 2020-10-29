# -*- coding: utf-8 -*-
"""
Created on Thu Oct 29 18:08:56 2020

@author: Julian David Mendoza Ruiz & Luis Miguel Gomez Londoño
"""
from __future__ import division
from pyomo.environ import *
from pyomo.opt import SolverFactory
import dis
import inspect
import numpy as np
from pprint import pprint

#M = Model
M = ConcreteModel()

# Sets and Parameters
## n => Numero de Proyectos
n = 2
## T => Tiempo inicial requerido para completar el proyecto n
## R => Retraso m ́aximo del proyecto n.
## Ni => Personal inicial para el proyecto n.
## Nf => Personal final para el proyecto n.
## B => Periodo en que se agrega personal al proyecto n
T = R = Ni = Nf = B = RangeSet(1, n)
## Tiempo de adaptacion de un nuevo integrante al proyecto.
a = 2
## Constante de adelanto del proyecto.
b = 4

#Variables


#Objective Function


#Constraints


#SOLVER
SolverFactory('glpk').solve(M)
M.display()