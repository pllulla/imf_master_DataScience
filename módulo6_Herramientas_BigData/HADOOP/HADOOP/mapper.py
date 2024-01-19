import sys

for line in sys.stdin: # Nuestra entrada es stdin
  line = line.strip()
  words = line.split()
  for word in words:
    print ('%s\t%s' % (word,1)) #Esta salida será la entrada de reducer
