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
N =RangeSet (0, n-1)
## P => Tiempo final requerido para completar el proyecton tras cambiar el personal
## T => Tiempo inicial requerido para completar el proyecto n
## R => Retraso m ́aximo del proyecto n.
## Ni => Personal inicial para el proyecto n.
# Nf => Personal final para el proyecto n.
#P=T = R = Ni = RangeSet(0, 1)

P = {
     0:0,
     1:0
     }

T = {
     0:8,
     1:12
     }

R = {
     0:4,
     1:0
     }

Ni = {
      0:10,
      1:10
      }

## Tiempo de adaptacion de un nuevo integrante al proyecto.
a = 2
## Constante de adelanto del proyecto.
b = 4

print (P) 
#Ni[0]= 10

#Ni[1] = 10


#R[0] = 4

#R[1] = 0

#T[0] = 8

#T[1] = 12




#Variables
M.B = Var(T, domain= PositiveIntegers)

M.Nf = Var(N,domain = PositiveIntegers)

P[0] = T[0]*((((M.Nf[1]-M.Nf[0])-(Ni[1]-Ni[0]))/2)+((a-b)*(M.Nf[0]-Ni[0]))) 

P[1] = T[1]*((a-b)*(M.Nf[1]-Ni[1]))

#Objective Function
M.obj = Objective(expr = sum(P[i] for i in N), sense = minimize )

#Constraints
#def retraso_total_rule(Model,i):
#    return ((P[i] - T[i]) <= R[i])

#M.retraso_total =Constraint(N, rule=retraso_total_rule)


#M.no_reduccion_personal = Constraint(expr = (M.Nf[i]>=Ni[i] for i in N) )

def reduccion_rule(Model,i):
    if i!=0:
        return abs(P[i]-T[i]) >=2
    else:
        return Constraint.Skip
M.reduccion=Constraint(N, rule=reduccion_rule)


#SOLVER

SolverFactory('mindtpy').solve(M,mip_solver='glpk',nlp_solver='ipopt') 
M.display()