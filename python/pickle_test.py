#! /usr/bin/ipython
import pickle
f=open("pickle_test.py",'r')
p=pickle.Pickler(f)
p.dump(obj)
