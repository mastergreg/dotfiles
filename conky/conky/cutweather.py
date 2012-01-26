#!/usr/bin/python

weatherfile=open(".weather","r")
weatherfile2=open("weather","w")
weatherlines=weatherfile.readlines()
weather=weatherlines[0]+weatherlines[1]+weatherlines[2][2:len(weatherlines[2])-1]+weatherlines[3][6:]+weatherlines[4][2:len(weatherlines[4])-1]+weatherlines[5][6:]+weatherlines[6][2:len(weatherlines[6])-1]+weatherlines[7][6:]+weatherlines[8][2:len(weatherlines[8])-1]+weatherlines[9][6:]+weatherlines[10]
weatherfile2.write(weather)
weatherfile.close()
weatherfile2.close()
