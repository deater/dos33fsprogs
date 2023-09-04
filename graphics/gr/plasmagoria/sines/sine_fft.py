# https://stackoverflow.com/questions/59725933/plot-fft-as-a-set-of-sine-waves-in-python
import matplotlib.pyplot as plt
import numpy as np
import cmath


sin3 = (46,48,50,52,53,54,56,58,60,60,62,64,65,66,68,69,71,71,73,74,75,76,77,78,79,80,81,82,83,83,84,84,85,85,86,87,87,88,88,87,88,88,88,88,88,88,88,88,88,87,87,87,86,86,85,84,85,84,83,82,82,81,80,79,78,78,77,76,75,75,74,73,72,71,70,69,69,68,66,66,65,65,63,63,61,61,60,59,59,57,57,57,56,56,55,54,54,53,53,52,52,51,50,50,50,49,49,49,48,49,48,48,48,48,47,47,48,47,47,47,47,47,47,47,46,47,47,47,46,47,47,47,47,46,47,47,47,46,47,47,46,46,47,46,46,45,46,45,45,45,44,44,44,43,43,43,42,42,41,40,40,39,39,38,38,37,37,35,35,34,33,33,32,31,31,29,29,28,27,26,25,25,23,22,22,21,20,19,19,18,17,16,15,15,14,13,12,12,11,10,9,9,8,8,8,7,6,7,6,6,6,6,5,6,5,5,6,5,6,6,7,7,8,8,9,9,10,11,11,12,12,13,15,15,16,18,18,20,21,22,23,25,26,27,29,30,32,33,34,36,38,39,40,42,44,46)
#x = np.arange(0,256,1)

# discrete works better if periodicity matches range (?)
x = np.linspace(0,4*np.pi, 256)

#fft3=np.fft.fft(sin3)
#
#plt.plot(x, sin3)
#plt.show()

fft3 = np.fft.fft(sin3)
freqs = np.fft.fftfreq(len(x),.01)
threshold = 0.0
recomb = np.zeros((len(x),))
middle = len(x)//2 + 1
for i in range(middle):
	if abs(fft3[i])/(len(x)) > threshold:
		if i == 0:
			coeff = 2
		else:
			coeff = 1
		sinusoid = 1/(len(x)*coeff/2)*(abs(fft3[i])*np.cos(freqs[i]*2*np.pi*x+cmath.phase(fft3[i])))
		recomb += sinusoid
		print(abs(fft3[i]))
		plt.plot(x,sinusoid)
#plt.show()

plt.plot(x,recomb,x,sin3)
plt.show()

#plt.plot(fft3.imag)
#plt.show()

#for i in range(1,256):
#	plt.plot(x, fft3.imag[i] * np.sin(i*x)/100)
#plt.show()
