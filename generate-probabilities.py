import sys
from collections import defaultdict
import re
import random

if len(sys.argv) != 3:
	print("Usage:", sys.argv[0], "infile outfile");
	sys.exit(1);

d = defaultdict(list)
r = re.compile("(?P<type>[a-z]+)\\((?P<data>[a-z, ]+)\\)\\.")

with open(sys.argv[1], 'r') as f:
	for line in f:
		matcher = r.match(line)
		if not matcher: continue
		d[matcher.group("type")].append(matcher.group("data"))

with open(sys.argv[2], 'w') as f:
	for key in sorted(d.keys()):
		total = 1
		for n,i in enumerate(sorted(d[key])):
			pr = random.uniform((total)/(len(d[key])-n+1), (total)/(len(d[key])-n))
			if (n == len(d[key])- 1): pr = total
			total -= pr
			f.write("{}({}, {}).\n".format(key, str(pr), i))
		f.write("\n")
